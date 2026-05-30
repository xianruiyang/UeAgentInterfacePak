# 自定义蓝图节点：使用 UFunction 将 C++ 暴露给蓝图 (Part 3/6)

# 自定义蓝图节点：使用 UFunction 将 C++ 暴露给蓝图 (Part 3/6)

Source file: `unreal-engine-custom-blueprint-nodes-exposing-c-to-blueprint-with-ufunction.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 4. 类参数

类可以作为 UClass 指针 (*UClass** ) 传递。 *TSubclassOf* 可用于将类选择限制为子类。 - 严格来说，*UClasses* 也是对象（在 UE 中）。 -（与其他对象一样） - TSubclassOf 可以被视为 UClass*

**类参数：示例**

```cpp
UFUNCTION(BlueprintPure, BlueprintImplementableEvent)
void Classes(
	UClass* ClassInput,
	TSubclassOf<AActor> SubclassInput,
	UPARAM(ref) UClass*& RefClassInput,
	UPARAM(ref) TSubclassOf<AGameModeBase>& RefSubclassInput,
	UClass*& ClassOutput,
	TSubclassOf<AGameModeBase>& SubclassOutput
);
```

**类参数：示例**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0"
   ExtraFlags=268435456
   FunctionReference=(MemberParent=Class'"/Script/GettingStarted.CustomNodesActor"',MemberName="Classes")
   NodeGuid=A2E37EB34EEF2CDDED545EACED2DF40B
   CustomProperties Pin (PinId=EAF41FD841A16B74F3833EAB24BF821C,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_FunctionResult_0 F494433442688FF9F6E25591970C90DF,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=4ABAA8AB42F3B2CF340D18A57AF00F37,PinName="ClassInput",PinToolTip="Class Input\nObject Class Reference",Direction="EGPD_Output",PinType.PinCategory="class",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/CoreUObject.Object"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=E58EB4C0493E1559A70340BCAE756CEC,PinName="SubclassInput",PinToolTip="Subclass Input\nActor Class Reference",Direction="EGPD_Output",PinType.PinCategory="class",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/Engine.Actor"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=True,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=470C00F947FF757255C99AB626CEE4E0,PinName="RefClassInput",PinToolTip="Ref Class Input\nObject Class Reference (by ref)",Direction="EGPD_Output",PinType.PinCategory="class",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/CoreUObject.Object"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=True,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=DBA7997B445F42D882ECC1AA4D00B9BE,PinName="RefSubclassInput",PinToolTip="Ref Subclass Input\nGame Mode Base Class Reference (by ref)",Direction="EGPD_Output",PinType.PinCategory="class",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/Engine.GameModeBase"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=True,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=True,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
```

