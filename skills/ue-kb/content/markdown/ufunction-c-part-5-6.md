# 自定义蓝图节点：使用 UFunction 将 C++ 暴露给蓝图 (Part 5/6)

# 自定义蓝图节点：使用 UFunction 将 C++ 暴露给蓝图 (Part 5/6)

Source file: `unreal-engine-custom-blueprint-nodes-exposing-c-to-blueprint-with-ufunction.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 7. 执行引脚

要创建多个执行引脚，可以使用 *ExpandEnumAsExecs* 和/或 *ExpandBoolAsExecs*。 **工作原理** 使用节点时，扩展参数的值将转换为执行引脚。实现仅适用于普通参数类型。 **一般** - 执行什么 - 每个扩展参数的 1x 引脚被触发。 - 不少于也不多 - （无异步执行） - 引脚顺序 1. 扩展的 *enum* 参数 2. 扩展的 *bool* 参数 3. 正常参数 - 仅允许 1x 输入组 当具有多个扩展参数时，输出执行引脚的旁边会显示组名称。

**执行引脚：示例**

```cpp
UFUNCTION(BlueprintCallable, BlueprintNativeEvent,
meta=(ExpandBoolAsExecs="OutputSwitch", ExpandEnumAsExecs="Fruit,CarBrand,Success"))
void ExecutionPins(
	EFruit Fruit, // or bool InputSwitch,
	ECarBrand& CarBrand,
	bool& OutputSwitch,
	ESuccess& Success
);
```

**执行引脚：示例**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0"
   FunctionReference=(MemberParent=Class'"/Script/GettingStarted.CustomNodesActor"',MemberName="ExecutionPins")
   NodeGuid=0F96CCBB40BDC55B72B472ACB68DEE29
   CustomProperties Pin (PinId=8A3E6A6944A05D52C03AFDB7E9C64988,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_SwitchEnum_0 5175711D42118688DCAA2E95E38B6892,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=DF0EEDF14367554D6003718F7C315446,PinName="Fruit",PinToolTip="Fruit\nEFruit Enum",Direction="EGPD_Output",PinType.PinCategory="byte",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Enum'"/Script/GettingStarted.EFruit"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,DefaultValue="APPLE",LinkedTo=(K2Node_SwitchEnum_0 54F13E5D4B07277F7BC917B738492B61,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionResult Name="K2Node_FunctionResult_0"
   FunctionReference=(MemberParent=Class'"/Script/GettingStarted.CustomNodesActor"',MemberName="ExecutionPins")
   NodePosX=448
   NodeGuid=9093D06A41FEAB06689D0689126757C0
```

**执行引脚：示例**

```cpp
// example C++ usage
void ACustomNodesActor::ExecutionPins_Implementation(EFruit Fruit,
	ECarBrand& CarBrand, bool& OutputSwitch, ESuccess& Success)
{
	CarBrand = ECarBrand::FORD;
	OutputSwitch = true;
	Success = ESuccess::FAILURE;
}
```

