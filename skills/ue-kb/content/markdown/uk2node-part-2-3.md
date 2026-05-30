# 创建返回引用的 UK2Node (Part 2/3)

# 创建返回引用的 UK2Node (Part 2/3)

Source file: `unreal-engine-creating-a-uk2node-returning-a-reference.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### UK2节点

编写 UK2Node 允许我们使用我们想要的任何输入和输出引脚编写完全自定义的节点。我们的目标结果如下：

![教程图片](assets/unreal-engine-creating-a-uk2node-returning-a-reference/image-02.jpg)

该节点允许我们传入我们想要读取的实例数据以及我们正在查找的 PropertyRef。作为输出，我们得到属性的值。除此之外，我们还有两个“Then”输出引脚，无论我们是否找到该属性，都只会调用其中一个。这只是为了理智，不一定需要，因为从我的设置来看，应该确保传递的对象始终具有该属性。 UK2Node 是一个仅编辑器的类，因此请将实现放入定义 UInstanceData 的运行时模块的匹配编辑器模块（UncookedOnly 或 Development！）中。让我们从以下声明开始：

```cpp
UCLASS()
class UK2Node_GetPropertyFromInstanceData : public UK2Node
{
    GENERATED_BODY()

public:
    void AllocateDefaultPins() override;
    FText GetNodeTitle(ENodeTitleType::Type TitleType) const override;
    FText GetTooltipText() const override;
    FText GetMenuCategory() const override;
```

虽然 GetNodeTitle、GetTooltipText、GetMenuCategory 应该是不言自明的，但让我们看一下 AllocateDefaultPins。该函数用于指定我们所有的输入和输出引脚，可能如下所示：

```cpp
namespace UK2Node_GetPropertyFromInstanceDataHelper
{
    static FName InstanceDataPinName = "InstanceData";
    static FName DataFoundPinName = "DataFound";
    static FName DataNotFoundPinName = "DataNotFound";
    static FName DataPinName = "Data";
    static FName PropertyRefName = "PropertyRef";
}

void UK2Node_GetPropertyFromInstanceData::AllocateDefaultPins()
```

为了减少人为错误，我们在详细名称空间中定义一次所有引脚名称。 CreatePin 函数将使用传递的设置实例化一个引脚。对于 DataPin，我们将坚持使用通配符，因为我们还不知道类型。在我们继续有趣的部分之前：不要忘记实现 UK2Node::GetMenuActions，以便您可以生成节点并验证进度。一个简单的实现如下所示：

```cpp
void UK2Node_GetPropertyFromInstanceData::GetMenuActions(FBlueprintActionDatabaseRegistrar& ActionRegistrar) const
{
    Super::GetMenuActions(ActionRegistrar);
    UClass* Action = GetClass();
    if (ActionRegistrar.IsOpenForRegistration(Action))
    {
        UBlueprintNodeSpawner* Spawner = UBlueprintNodeSpawner::Create(Action);
        ActionRegistrar.AddBlueprintAction(Action, Spawner);
    }
}
```

下一步是根据输入指定输出引脚类型。为此，我们需要实现 UK2Node::PinConnectionListChanged 和 UK2Node::PostReconstructNode。如果您的 Pin 也支持默认值，您还可以实现 UEdGraphNode::PinDefaultValueChanged。由于这些函数仅用于调用我们实际的刷新函数，这里是快速示例：

```cpp
// You will see such getters through out the tutorial, so here a quick example:
UEdGraphPin* UK2Node_GetPropertyFromInstanceData::GetPropertyRefPin() const
{
    UEdGraphPin* Pin = FindPinChecked(UK2Node_GetPropertyFromInstanceDataHelper::PropertyRefName);
    // Just for sanity, make sure to have it fit the direction the pin was declared with
    check(Pin->Direction == EGPD_Input);
    return Pin;
}

void UK2Node_GetPropertyFromInstanceData::PinConnectionListChanged(UEdGraphPin* Pin)
```

基本思想是：我们的输入引脚上的某些内容发生了变化？我们可能需要更新输出引脚类型。那么让我们看一下 RefreshOutputType。

```cpp
void UK2Node_GetPropertyFromInstanceData::RefreshOutputType() const
{
    UEdGraphPin* OutValuePin = GetOutDataPin();
    UEdGraphPin* PropertyRefPin = GetPropertyRefPin();

    const UBlueprint* BP = FBlueprintEditorUtils::FindBlueprintForNodeChecked(this);
    if (BP && BP->GeneratedClass && PropertyRefPin->LinkedTo.Num() == 1)
    {
        UK2Node_VariableGet* VariableGet = Cast<UK2Node_VariableGet>(PropertyRefPin->LinkedTo[0]->GetOwningNode());
        if (VariableGet)
```

正如您可能已经发现的：我只介绍了 UK2Node_VariableGet 类型的输入引脚。原因是，对于更动态的输入（例如函数返回），我们无法预测要处理的 PropertyRef 类型。而且它也不打算这样做。但是，如果您有不同的用例，您可能会使用与我不同的方法。这个函数有什么作用？我们首先获取我们想要读取的属性的 PropertyRef 输入和输出引脚。由于属性类型存储在 PropertyRef 的实例上，因此我们还需要该节点所属的蓝图。现在我们可以尝试获取连接到输入引脚的节点。如果我们找到一个并且它是一个变量，我们会查找它将在 BP 生成类上返回的属性。如果我们找到了，我们可以从生成的类的 DefaultObject (CDO) 中读取该值。现在我们只需要比较 PinType，如果它与 PropertyRef 上的设置不同，我们只需更改它即可。如果我们未连接到某个引脚或某些其他条件不匹配，我们将重置为通配符引脚。但是，如果有人更改 PropertyRef 上的 PinType，会发生什么情况？好吧，直到刷新节点后我们才能识别它......但这会很糟糕，那么我们可以解决这个问题吗？ - 答案是肯定的！我花了一些时间才找到正确的方法，但是有一个名为 UK2Node::ClearCachedBlueprintData 的函数。我们只需调用 RefreshOutputType 即可完成。现在我们有了一个基本的节点，它将根据我们提供的输入确定其输出类型。那么我们现在错过了什么？函数体！我们基本上只是提供了函数签名，因此下一步是实现它的主体。为此，我们需要实现 UK2Node::ExpandNode。

```cpp
void UK2Node_GetPropertyFromInstanceData::ExpandNode(FKismetCompilerContext& CompilerContext, UEdGraph* SourceGraph)
{
    Super::ExpandNode(CompilerContext, SourceGraph);
    const UEdGraphSchema_K2* Schema = CompilerContext.GetSchema();

    bool bIsErrorFree = true;
    // Create an intermediate node to call our actual function
    UK2Node_CallFunction* const TryGetPropertyObjectNode = CompilerContext.SpawnIntermediateNode<UK2Node_CallFunction>(this, SourceGraph);
    TryGetPropertyObjectNode->FunctionReference.SetExternalMember(GET_FUNCTION_NAME_CHECKED(UInstanceData, TryGetProperty), UInstanceData::StaticClass());
    TryGetPropertyObjectNode->AllocateDefaultPins();
```

我对代码进行了评论，因为我认为它应该自我解释发生了什么。这里的基本思想是生成一个 CallFunction 节点来调用我们之前创建的 CustomThunk 函数。之后，我们使用 IFElse 节点根据函数的结果来分割执行。哦，我是否错过了解释我的 Get 函数？我打赌你可以解决这个问题，但这里有一个例子：

```cpp
UEdGraphPin* UK2Node_GetPropertyFromInstanceData::GetPropertyRefPin() const
{
    UEdGraphPin* Pin = FindPinChecked(UK2Node_GetPropertyFromInstanceDataHelper::PropertyRefName);
    check(Pin->Direction == EGPD_Input);
    return Pin;
}
```

但现在我们已经完成了，对吧？ - 如果您喜欢复制所有内容 - 是的。否则，请查看本文的最后部分。

