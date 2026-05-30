# 自定义蓝图节点：使用 UFunction 将 C++ 暴露给蓝图 (Part 4/6)

# 自定义蓝图节点：使用 UFunction 将 C++ 暴露给蓝图 (Part 4/6)

Source file: `unreal-engine-custom-blueprint-nodes-exposing-c-to-blueprint-with-ufunction.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 5. 数组参数

数组需要通过引用传递。

**数组参数：示例**

```cpp
UFUNCTION(BlueprintPure, BlueprintImplementableEvent)
void Arrays(
	const TArray<bool>& BoolArrayInput,
	const TArray<UObject*>& ObjectArrayInput,
	const TArray<UClass*>& ClassArrayInput,
	TArray<TSubclassOf<AGameModeBase>>& GameModeClassArrayOutput,
	TArray<AActor*>& ActorArrayOutput
);
```

**数组参数：示例**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0"
   ExtraFlags=268435456
   FunctionReference=(MemberParent=Class'"/Script/GettingStarted.CustomNodesActor"',MemberName="Arrays")
   NodeGuid=5B3C3C104FC54F090D9F119D9C22CB7B
   CustomProperties Pin (PinId=6FEBA2CE4D409E225D4E06A70898C1EB,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_FunctionResult_0 8DD6E293405343E95A53F88B200FA947,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=0368D45E46E85B81049863B1450495FC,PinName="BoolArrayInput",PinToolTip="Bool Array Input\nArray of Booleans",Direction="EGPD_Output",PinType.PinCategory="bool",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=Array,PinType.bIsReference=True,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=B10C7F4543B9E43A3A6EECA32B09EF36,PinName="ObjectArrayInput",PinToolTip="Object Array Input\nArray of Object References",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/CoreUObject.Object"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=Array,PinType.bIsReference=True,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=4D72853A4F22787D15FB87B4A1EE89EF,PinName="ClassArrayInput",PinToolTip="Class Array Input\nArray of Object Class References",Direction="EGPD_Output",PinType.PinCategory="class",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/CoreUObject.Object"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=Array,PinType.bIsReference=True,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionResult Name="K2Node_FunctionResult_0"
```
### 6. 接口参数

接口参数有多种用例： - 传递实现接口的对象。 - 传递实现接口的对象数组。 - 允许包含不同类型的数组 - 将接口作为类型传递。 - 就像上课一样。 - 接口参数有点混乱。 - 是的，接口可以扩展其他接口。

**接口参数：示例**

```cpp
UFUNCTION(BlueprintPure, BlueprintImplementableEvent)
void Interfaces(
	const TScriptInterface<IMyInterface>& InterfaceObjectInput,
	const TArray<TScriptInterface<IMyInterface>>& InterfaceObjectArrayInput,
	TScriptInterface<IMyInterface>& InterfaceObjectOutput,
	TArray<TSubclassOf<UMyInterface>>& InterfaceClassArrayOutput
);
```

**接口参数：示例**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0"
   ExtraFlags=268435456
   FunctionReference=(MemberParent=Class'"/Script/GettingStarted.CustomNodesActor"',MemberName="Interfaces")
   NodeGuid=E5179ED94099131DE64A8EBF240C7106
   CustomProperties Pin (PinId=307606094E3F4122D45D2EB7726A04DD,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_FunctionResult_0 C1B28E3B4B9F45BCB2E2028B5ABCFE17,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=6D90EADC4423E4317F1CAAA7CC69C4F3,PinName="InterfaceObjectInput",PinToolTip="Interface Object Input\nMy Interface Interface (by ref)",Direction="EGPD_Output",PinType.PinCategory="interface",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/GettingStarted.MyInterface"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=True,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=True,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=6676D2564726A0073A9D0F9CA1365291,PinName="InterfaceObjectArrayInput",PinToolTip="Interface Object Array Input\nArray of My Interface Interfaces",Direction="EGPD_Output",PinType.PinCategory="interface",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/GettingStarted.MyInterface"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=Array,PinType.bIsReference=True,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=True,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionResult Name="K2Node_FunctionResult_0"
   FunctionReference=(MemberParent=Class'"/Script/GettingStarted.CustomNodesActor"',MemberName="Interfaces")
```

- [界面参数 - 更多示例](https://dev.epicgames.com/community/snippets/003/unreal-engine-interfaces-for-c-and-blueprint)

