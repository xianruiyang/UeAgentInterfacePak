# 创建返回引用的 UK2Node (Part 3/3)

# 创建返回引用的 UK2Node (Part 3/3)

Source file: `unreal-engine-creating-a-uk2node-returning-a-reference.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### FNodeHandling函子

到目前为止我们所做的一切基本上都是为了有一个漂亮的节点。嗯，使用起来有些方便。但我们仍然总是归还副本。这不一定是问题！如果您只有小型类型/没有那么大的容器，我不会打扰它。但由于我很好奇，所以我确实费了心思，这就是我如何做到不复制所有内容的方法。第一步是了解引用在蓝图字节代码中的工作原理。非常感谢艾伦为我指明了正确的方向。据我了解，蓝图不知道引用。相反，它们使用 Stack (FFrame) 对象，该对象存储如下数据：

```cpp
struct FFrame : public FOutputDevice
{
    // ...
    FProperty* MostRecentProperty;
    uint8* MostRecentPropertyAddress;
    uint8* MostRecentPropertyContainer;
    // ...
};
```

MostRecentProperty描述当前MostRecentPropertyAddress所属的Property。如果属性是容器（例如某个对象）的一部分，则 MostRecentPropertyContainer 指向所述实例。这意味着，如果我们想要引用对象上的某些属性，我们只需设置这些值即可完成。但我们怎样才能做到这一点呢？我敢打赌您从一开始就记得我们的 CustomThunk 函数吗？好的 - 又来了：

```cpp
DEFINE_FUNCTION(UInstanceData::execTryGetProperty)
{
    P_GET_STRUCT_REF(FPropertyRef, PropertyRef)
    Stack.MostRecentPropertyAddress = nullptr;
    Stack.StepCompiledIn<FProperty>(nullptr);
    void* DataPtr = Stack.MostRecentPropertyAddress;
    const FProperty* DataProp = Stack.MostRecentProperty;
    P_FINISH;

    bool bSuccess = false;
```

那么我们难道不能超越这些价值观并且我们就很好吗？如果有这么简单，我会开始写这篇文章吗？为了能够写入堆栈值并让调用代码使用它们，我们需要指定要内联使用的输出，即没有为其写入的临时变量创建。不幸的是（据我所知）我们无法在 ExpandNode 中执行此操作。这就是为什么我们现在必须实现 FNodeHandlingFunctor 的原因。这也意味着我们不能再使用 ExpandNode 函数，因为它们是互斥的。那么我们可以删除它吗？我建议保留它，但要延长它。我决定，如果它不是容器，我就可以接受副本（如果我想要引用或副本，我什至可以在函数的实例化上指定），因此，如果我遇到这种情况，我只是提前返回函数。正如我刚刚了解 FNodeHandlingFunctor 一样，不要期望对所有内容都有正确或准确的解释。我将介绍我认为我已经理解的内容以及使我的节点工作所需的内容。为了能够覆盖堆栈上的值并使用它们而不是写入临时变量，我们需要标记出值，例如用作函数输入的值，以进行内联，即成为 InlineGenerateParameter。这意味着，我们可以分配一个要调用的函数，该函数将更新当前堆栈值以指向在以下执行中应用作此参数的值。一切都从实现 RegisterNets 开始。

```cpp
class FKCHandler_GetPropertyFromInstanceData final : public FNodeHandlingFunctor
{
    void RegisterNets(FKismetFunctionContext& Context, UEdGraphNode* Node) override;
    void Compile(FKismetFunctionContext& Context, UEdGraphNode* Node) override;

    TMap<UEdGraphNode*, FBPTerminal*> LocalBools;
};

void FKCHandler_GetPropertyFromInstanceData::RegisterNets(FKismetFunctionContext& Context, UEdGraphNode* Node)
{
```

我使用这个函数来创建可以写入的变量。首先，我为内联输出创建一个 FBPTerminal 实例。终端似乎是一些用作函数参数的上下文，例如可以描述变量。因此我们可以将其标记为内联生成值而不是实际变量。我创建的另一个终端是一个布尔值，我可以用来写入函数调用的结果，确定对象上是否存在请求的属性。这将我们引向下一个重要点。我们不能再使用 CustomThunk 函数了。我们现在需要两个功能，而不是只有一个功能。我上面提到的第一个函数是 HasProperty。这将是一个简单的 UFUNCTION，用于检查是否可以从 FPropertyRef 解析 FProperty。

```cpp
bool UInstanceData::HasProperty(const FPropertyRef& PropertyRef) const
{
    const FProperty* RequestedProperty = PropertyRef.Property.Get(GetClass());
    return !!RequestedProperty && this->IsA(RequestedProperty->GetOwner<UClass>());
}
```

现在我们可以实现该函数，该函数被称为“内联”，而不是为我们的结果值提供一个变量。我将其命名为 GetPropertyInplace：

```cpp
// void GetPropertyInplace(const FPropertyRef& PropertyRef) const
DEFINE_FUNCTION(UInstanceData::execGetPropertyInplace)
{
    P_GET_STRUCT_REF(FPropertyRef, PropertyRef)
    P_FINISH;

    if (FProperty* RequestedProperty = PropertyRef.Property.Get(P_THIS->GetClass()))
    {
        Stack.MostRecentPropertyAddress = RequestedProperty->ContainerPtrToValuePtr<uint8>(P_THIS);
        Stack.MostRecentPropertyContainer = reinterpret_cast<uint8*>(P_THIS);
```

该函数既没有返回值，也没有输出参数。它只是将 PropertyRef 作为输入，仅此而已。这就是我们进行“内联”部分的地方。首先，我们获取输入，即 PropertyRef。之后我们只需要解决它并请求指向当前实例上的属性的指针。所以我们只需要分配 MostRecentPropertyAddress、MostRecentPropertyContainer 和 MostRecentPropertyContainer。如果传递了 RESULT_PARAM，我们需要复制到其中。如果引脚插入值类型，则可能会发生这种情况。如果我们找不到该属性，我们需要以某种方式优雅地中断执行。这可以通过将所有内容设置为空来完成。我们也可以抛出异常，但我还没有触及这个。现在缺少的最后一部分是将所有内容缝合在一起的编译函数。我们首先获得我们需要的所有终端。

```cpp
const auto* MyNode = CastChecked<UK2Node_GetPropertyFromInstanceData>(/*UEdGraphNode* */ Node);
FBPTerminal* InstanceDataPtr = Context.NetMap.FindRef(FEdGraphUtilities::GetNetFromPin(MyNode->GetInstanceDataPin()));
FBPTerminal* PropertyRef = Context.NetMap.FindRef(FEdGraphUtilities::GetNetFromPin(MyNode->GetPropertyRefPin()));
const UEdGraphPin* OutPin = MyNode->GetOutDataPin();
FBPTerminal* OutValuePtr = Context.NetMap.FindRef(OutPin);
FBPTerminal* TmpLocalBool = LocalBools.FindChecked(/*UEdGraphNode* */ Node);
```

现在我们需要调用 HasProperty 函数。这是通过生成 FBlueprintCompiledStatement 并将其类型设置为 KCST_CallFunction 来完成的。然后我们需要指定要调用的 UFunction 以及我们调用该函数的对象 (FunctionContext)。最后，我们设置要将返回值分配到的位置（分配给左轴）以及传递给函数的参数（右轴）。就是这样。现在 BPVM 将调用我们的函数并将结果分配给我们的临时布尔值。

```cpp
// TmpLocalBool = InstanceDataPtr->GetPropertyAddress(PropertyRef)
FBlueprintCompiledStatement& HasPropertyFunction = Context.AppendStatementForNode(Node);
HasPropertyFunction.Type = KCST_CallFunction;
HasPropertyFunction.FunctionToCall = UYggDialogInstanceData::StaticClass()->FindFunctionByName(GET_FUNCTION_NAME_CHECKED(UInstanceData, HasProperty));
HasPropertyFunction.FunctionContext = InstanceDataPtr;
HasPropertyFunction.LHS = TmpLocalBool;
HasPropertyFunction.RHS.Add(PropertyRef);
```

下一步是设置我们的内联输出值。我们只是创建另一个函数，但不是添加到当前上下文，而是创建一个新实例，因此我们可以将其分配给 InlineGenerateParameter。这意味着每次我们想要访问 OutValue 时，我们都会调用函数并在堆栈上设置值。

```cpp
// InstanceDataPtr->GetPropertyFromAddress(PropertyRef) -> Sets OutValuePtr In place
FBlueprintCompiledStatement* GetValueFunction = new FBlueprintCompiledStatement();
GetValueFunction->Type = KCST_CallFunction;
GetValueFunction->FunctionToCall = UYggDialogInstanceData::StaticClass()->FindFunctionByName(GET_FUNCTION_NAME_CHECKED(UInstanceData, GetPropertyInplace));
GetValueFunction->FunctionContext = InstanceDataPtr;
GetValueFunction->RHS.Add(PropertyRef);
OutValuePtr->InlineGeneratedParameter = GetValueFunction;
```

最后一步我们需要添加 If/Else 逻辑。由于代码是从上到下执行的，因此您通常似乎从 else 部分开始跳转到未找到的情况。条件作为 LHS 参数传递给语句。之后，您需要将从执行的 Statement 到下一个 Pin 的映射添加到 GotoFixupRequestMap 中，以便编译器知道之后要执行什么。

```cpp
FBlueprintCompiledStatement& PropertyNotFound = Context.AppendStatementForNode(Node);
PropertyNotFound.Type = KCST_GotoIfNot;
PropertyNotFound.LHS = TmpLocalBool;
Context.GotoFixupRequestMap.Add(&PropertyNotFound, MyNode->GetDataNotFoundPin());

FBlueprintCompiledStatement& PropertyFound = Context.AppendStatementForNode(Node);
PropertyFound.Type = KCST_UnconditionalGoto;
PropertyFound.LHS = TmpLocalBool;

Context.GotoFixupRequestMap.Add(&PropertyFound, MyNode->GetDataFoundPin());
```

这里有完整的功能供参考

```cpp
void FKCHandler_GetPropertyFromInstanceData::Compile(FKismetFunctionContext& Context, UEdGraphNode* Node)
{
    const auto* MyNode = CastChecked<UK2Node_GetPropertyFromInstanceData>(Node);
    FBPTerminal* InstanceDataPtr = Context.NetMap.FindRef(FEdGraphUtilities::GetNetFromPin(MyNode->GetInstanceDataPin()));
    if (!InstanceDataPtr)
    {
        Context.MessageLog.Error(TEXT("Instande Data not found"));
        return;
    }
    FBPTerminal* PropertyRef = Context.NetMap.FindRef(FEdGraphUtilities::GetNetFromPin(MyNode->GetPropertyRefPin()));
```

感谢您的阅读:) 在我忘记之前：当然还有最后一件事要补充：

```cpp
FNodeHandlingFunctor* UK2Node_GetPropertyFromInstanceData::CreateNodeHandler(FKismetCompilerContext& CompilerContext) const
{
    return new FKCHandler_GetPropertyFromInstanceData(CompilerContext);
}
```

为了让节点在非容器中像以前一样运行，您需要进行以下更改：

```cpp
void UK2Node_GetPropertyFromInstanceData::RefreshOutputType() const
{
    // ...
            if (StructProperty && StructProperty->Struct == FPropertyRef::StaticStruct())
            {
                FPropertyRef Value;
                Property->GetValue_InContainer(CDO, &Value);
                // -----------------------------------------
                if (Value.VarType.IsContainer())
                {
```

