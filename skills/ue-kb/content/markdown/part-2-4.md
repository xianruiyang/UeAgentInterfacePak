# 蓝图事件中的参考参数 (Part 2/4)

# 蓝图事件中的参考参数 (Part 2/4)

Source file: `unreal-engine-reference-parameters-in-blueprint-events.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 使用参考参数

如果我们不能返回任何东西，也许我们可以传递一个引用参数。具体来说，如果我们无法创建返回函数，我们可以创建一个更改整数的过程。这应该很容易。我的意思是，在 C++ 中确实如此。这是“返回”整数的函数的两个版本。

```cpp
int ReturnInt()
{
        return 5;
}

void ReturnInt(int& Int)
{
        Int = 5;
}
```

我们只需要对事件做同样的事情。这应该很容易......不是吗？那么，让我们更改我们的委托声明。现在它应该通过引用接收一个 int 。另外，让我们回到多播版本并删除 BindGetInteger 方法。请记住再次添加 BlueprintAssignable 属性。

```cpp
DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnGetInteger, int&, Integer);

UCLASS()
class PROCEDURALTEST_API AMyActor : public AActor
{
	GENERATED_BODY()

public:
	UPROPERTY(BlueprintAssignable)	
	FOnGetInteger GetIntegerFunc;
```

现在我们可以将 BP_Integer 变量传递给委托。这也可以编译。 （唷...）让我们创建事件。

![教程图片](assets/unreal-engine-reference-parameters-in-blueprint-events/image-02.jpg)

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_0"
   EventReference=(MemberParent=/Script/CoreUObject.Class'"/Script/Engine.Actor"',MemberName="ReceiveBeginPlay")
   bOverrideFunction=True
   bCommentBubblePinned=True
   NodeGuid=C23BD34948F390344710B28F89BE5372
   CustomProperties Pin (PinId=9A0299304B502A85CF68F5B2B7FC347E,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent=/Script/CoreUObject.Class'"/Script/Engine.Actor"',MemberName="ReceiveBeginPlay"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=783D96FA4AE6FB1E1A807C83F63E17F6,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_AddDelegate_0 0F4930894B83B0ABB901A6BADA569446,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_CallFunction Name="K2Node_CallFunction_1"
   FunctionReference=(MemberName="LogInteger",bSelfContext=True)
```

现在我们可以实现...等一下...参数在哪里？我的参考参数...它在哪里？哦，我记得蓝图将参考参数理解为输出值。这就是为什么它没有出现。为了让它看起来应该是const。好吧，我们可以轻松解决这个问题。让我们再次更改委托声明。

```cpp
DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnGetInteger, const int&, Integer);
```

然后再试一次。

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_0"
   EventReference=(MemberParent=/Script/CoreUObject.Class'"/Script/Engine.Actor"',MemberName="ReceiveBeginPlay")
   bOverrideFunction=True
   bCommentBubblePinned=True
   NodeGuid=C23BD34948F390344710B28F89BE5372
   CustomProperties Pin (PinId=9A0299304B502A85CF68F5B2B7FC347E,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent=/Script/CoreUObject.Class'"/Script/Engine.Actor"',MemberName="ReceiveBeginPlay"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=783D96FA4AE6FB1E1A807C83F63E17F6,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_AddDelegate_1 0AD0F2304A675A6BD0D5A8BB9B3C82F7,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_CallFunction Name="K2Node_CallFunction_1"
   FunctionReference=(MemberName="LogInteger",bSelfContext=True)
```

好的。现在我们可以改变它的值...我们不能。我们无法更改它的值，因为没有节点可以设置参数。而且...更重要的是，整数是 const！我们根本无法改变它的价值！

