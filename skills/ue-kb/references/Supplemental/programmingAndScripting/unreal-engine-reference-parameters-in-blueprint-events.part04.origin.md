# 蓝图事件中的参考参数 (Part 4/4)

Source file: `unreal-engine-reference-parameters-in-blueprint-events.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 解决方案 2 of 2：包含整数的 USTRUCT

我们将使用结构体，而不是使用 UObject。但是，结构只能通过引用传递，而不能通过指针传递。这意味着引用应该是 const。如果结构体是 const，那么它的每个成员也将是 const。但是我们可以让 C++ 认为成员不是 const，即使结构是 const。首先，我们将使用的结构。

```cpp
USTRUCT(BlueprintType)
struct PROCEDURALTEST_API FInteger
{
	GENERATED_BODY()

	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	int Integer;

	int* pInteger = &Integer;
};
```

请注意成员 pInteger。这个指针就可以解决问题。观察指针指向实际的 Integer。另外，结构不能有 UFUNCTION，因此我们需要创建一个蓝图库。

```cpp
UCLASS()
class PROCEDURALTEST_API UWrapperValuesLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()

	UFUNCTION(BlueprintCallable)
	static void SetInteger(const FInteger& Integer, int Value)
	{
		*const_cast<int*>(Integer.pInteger) = Value;
	}
```

就是这样。诀窍。 SetInteger 正在接收对结构的 const 引用。但是，我们可以使用 const_cast 删除整数的 const 限定符。代表现在是这样的。

```cpp
DECLARE_DYNAMIC_MULTICAST_DELEGATE_OneParam(FOnGetInteger, const FInteger&, Integer);
```

在 C++ 中使用 struct 比使用 UObject 更容易。

```cpp
UCLASS()
class PROCEDURALTEST_API AMyActor : public AActor
{
	GENERATED_BODY()

public:
	UPROPERTY(BlueprintAssignable)	
	FOnGetInteger GetIntegerFunc;

	UFUNCTION(BlueprintCallable)
```

在蓝图方面。

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_0"
   EventReference=(MemberParent=/Script/CoreUObject.Class'"/Script/Engine.Actor"',MemberName="ReceiveBeginPlay")
   bOverrideFunction=True
   bCommentBubblePinned=True
   NodeGuid=C23BD34948F390344710B28F89BE5372
   CustomProperties Pin (PinId=9A0299304B502A85CF68F5B2B7FC347E,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent=/Script/CoreUObject.Class'"/Script/Engine.Actor"',MemberName="ReceiveBeginPlay"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=783D96FA4AE6FB1E1A807C83F63E17F6,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_AddDelegate_0 2C8830BF4B4B196E549797A36C49B5A0,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_CallFunction Name="K2Node_CallFunction_1"
   FunctionReference=(MemberName="LogInteger",bSelfContext=True)
```

放置演员并开始游戏后，您将再次看到荣耀消息。
