# K2Nodes 的简要介绍 (Part 2/2)

# K2Nodes 的简要介绍 (Part 2/2)

Source file: `unreal-engine-a-not-so-brief-intro-to-k2nodes.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 主要功能

超级 **K2Node ** 类中有很多很多函数，可以完成许多不同的事情。大多数时候你不会需要它们中的大多数，但有些你会一直需要，比如你总是需要重写的这两个主要函数（除了上面列出的函数之外）：

```cpp
virtual void AllocateDefaultPins() override;
```

您可以在创建时向节点添加输入和输出引脚。

```cpp
virtual void ExpandNode(class FKismetCompilerContext& CompilerContext, UEdGraph* SourceGraph) override;
```

该函数是在编译和运行 Node 时运行的，因此可以将其视为 Node 的运行时功能，而不是编辑器功能。让我们看看我对 Get Node 的定义，首先 **AllocateDefaultPins()**

**.cpp**

```cpp
void UPSK2Node_SetObjectVarByName::AllocateDefaultPins()
{
  const UEdGraphSchema_K2* K2Schema = GetDefault<UEdGraphSchema_K2>();
  /*Create our pins*/
  // Execution pins
  CreatePin(EGPD_Input, UEdGraphSchema_K2::PC_Exec, UEdGraphSchema_K2::PN_Execute);
  CreatePin(EGPD_Output, UEdGraphSchema_K2::PC_Exec, UEdGraphSchema_K2::PN_Then);
  //Input
  UEdGraphNode::FCreatePinParams PinParams;
  PinParams.bIsReference = true;
```

正如您所看到的，**CreatePin()** 函数是本例中的举重运动员。调用它会将生成的 Pin 添加并注册到 **K2Node**。不需要存储为变量，除非您需要对其执行某些操作，例如设置其默认值（未连接到另一个引脚时的值）。唯一的其他奇特部分是创建并传递 **CreatePin()** 和 **FCreatePinParams **，用于制作稍微更高级的引脚，在本例中是按引用传递。然后将此 **FCreatePinsParam ** 作为参数传递给 **CreatePin()** 函数。这就是这个级别上这个函数的全部内容。我们来看看 **ExpandNode()**

**.cpp**

```cpp
void UPSK2Node_SetObjectVarByName::ExpandNode(class FKismetCompilerContext& CompilerContext, UEdGraph* SourceGraph)
{
  Super::ExpandNode(CompilerContext, SourceGraph);
  UFunction* BlueprintFunction = FindSetterFunctionByType(GetNewValuePin()->PinType);
  if (!BlueprintFunction)
  {
    CompilerContext.MessageLog.Error(*LOCTEXT("InvalidFunctionName", "The function has not been found.").ToString(), this);
    return;
  }
  UK2Node_CallFunction* CallFunction = CompilerContext.SpawnIntermediateNode<UK2Node_CallFunction>(this, SourceGraph);
```

这比另一个多一点，所以让我们稍微分解一下。调用 super 后，我调用我自己的函数之一

```cpp
UFunction* BlueprintFunction = FindSetterFunctionByType(GetNewValuePin()->PinType);
```

它只是根据 **FPinType ** 参数返回适当的 Set 函数，因此如果输入 Pin 是 **Boolean**，它会通过访问前面提到的 **FSetterFunctionNames ** 命名空间来返回 **SetBooleanByName()** 函数引用。一旦我们存储了 **UFUNCTION ** 并确认它存在，我们就创建一个 **UK2Node_CallFunction** 节点。这可以被认为是任何函数的基本 **K2Node ** 包装器，它根据它所包装的 **UFUNCTION ** 的声明生成自己的输入和输出引脚。所以在本节中：

```cpp
CallFunction->SetFromFunction(BlueprintFunction); 
CallFunction->AllocateDefaultPins();
```

**CallFunction** 是 **K2Node_CallFunction**，我们将存储的 **UFUNCTION** 传递给它，然后运行它的 **AllocateDefaultPins()** 以进行设置。现在我们准备简单地将输入和输出从我们自己的 **K2Node ** 插入到我们生成的 **K2Node_CallFunction** “节点”。

**.cpp**

```cpp
  //Input
  CompilerContext.MovePinLinksToIntermediate(*FindPin(FGetPinName::GetTargetPinName()), *CallFunction->FindPinChecked(TEXT("Target")));
  CompilerContext.MovePinLinksToIntermediate(*FindPin(FGetPinName::GetVarNamePinName()), *CallFunction->FindPinChecked(TEXT("VarName")));
  CompilerContext.MovePinLinksToIntermediate(*FindPin(FGetPinName::GetNewValuePinName()), *CallFunction->FindPinChecked(TEXT("NewValue")));
  //Output
  CompilerContext.MovePinLinksToIntermediate(*FindPin(FGetPinName::GetOutputValuePinName()), *CallFunction->FindPinChecked(TEXT("OutValue")));
  CompilerContext.MovePinLinksToIntermediate(*FindPin(FGetPinName::GetOutputResultPinName()), *CallFunction->GetReturnValuePin());
//Exec pins
UEdGraphPin* NodeExec = GetExecPin();
UEdGraphPin* NodeThen = FindPin(UEdGraphSchema_K2::PN_Then);
```

解释；我存储的 **UFUNCTION ** 有五个加两个“引脚”： - **Exec**：这是运行函数的输入，在原始 C++ 中没有真正的比较 - **Then**：这是函数完成运行后的输出信号，同样没有直接的原始 C++ 比较。然后是实际参数： - **目标**：一个 **UObject*** 输入参数。 - **VarName**：**FName **输入参数。 - **NewValue**：要输入的新值。因此，如果我们修改一个布尔值，这将是一个布尔值，如果它是一个浮点值，它将是一个浮点值，等等。 - **OutValue**：一个常量输出值，与 NewValue 具有相同的类型。 - **Return**：函数的默认返回类型，如 c++ 中声明的那样，对于所有这些都是布尔值，即 bSuccess。这是它的声明（布尔版本）供参考：

```cpp
UFUNCTION(BlueprintCallable, BlueprintInternalUseOnly)
    static bool SetBoolByName(UObject* Target, FName VarName, bool NewValue, bool &OutValue);
```
### 回顾+前进

回顾过去，**K2Node** 并不像看起来那么复杂，更重要的是了解哪种类型的引脚和功能最适合您想要实现的目标。我忽略了一些重要的功能，但大体的轮廓就在那里。如果您想查看我的两个节点的完整、漏洞百出且注释不充分的代码，请[单击此处](https://github.com/nFerrar/K2Node_Intro)。值得注意的是，目前我的节点不处理结构和枚举。它们稍微复杂一些，因此需要更多的工作。随着我理解的增长，我将继续修补它们并改进它们。否则，如果您有任何疑问，请通过 Twitter 通过 [@_nFerrar](https://twitter.com/_nferrar) 与我联系。当然，请查看 [S1T2 博客](https://s1t2.com/blog)，了解更多此类有关我们所做工作的内容。快乐编码！

