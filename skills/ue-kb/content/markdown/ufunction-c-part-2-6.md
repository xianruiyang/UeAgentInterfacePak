# 自定义蓝图节点：使用 UFunction 将 C++ 暴露给蓝图 (Part 2/6)

# 自定义蓝图节点：使用 UFunction 将 C++ 暴露给蓝图 (Part 2/6)

Source file: `unreal-engine-custom-blueprint-nodes-exposing-c-to-blueprint-with-ufunction.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 3. 对象参数

对象（实例）只能作为指针传递。 - 使它们成为强制性的 - 使用 *UPARAM(ref)* - const-references 不起作用

**对象参数：示例**

```cpp
UFUNCTION(BlueprintPure, BlueprintImplementableEvent)
void ObjectAndActor(
	UObject* ObjectInput,
	AActor* ActorInput,
	UPARAM(ref) UObject*& RefObjectInput,
	UPARAM(ref) AActor*& RefActorInput,
	UObject*& ObjectOutput,
	AActor*& ActorOutput
);
```

**对象参数：示例**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0"
   ExtraFlags=268435456
   FunctionReference=(MemberParent=Class'"/Script/GettingStarted.CustomNodesActor"',MemberName="ObjectAndActor")
   NodeGuid=677921574BDE35CC2AD6F78406B24AE9
   CustomProperties Pin (PinId=4EBA276C4A3E024EAD8A30AE7F7F9F1C,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_FunctionResult_0 93157B7949EAC3594A422E996AECBD86,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=FDB9E90D434EE733E8DC70A35E4CC4A2,PinName="ObjectInput",PinToolTip="Object Input\nObject Reference",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/CoreUObject.Object"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=32E381214D5FD2561E985FA4FB2AA7FD,PinName="ActorInput",PinToolTip="Actor Input\nActor Object Reference",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/Engine.Actor"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=D1F859E44ABDCA1F7E0F3C861184BA84,PinName="RefObjectInput",PinToolTip="Ref Object Input\nObject Reference (by ref)",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/CoreUObject.Object"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=True,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=DE66895B45C0FC7FFAAA5F8291D5DA0A,PinName="RefActorInput",PinToolTip="Ref Actor Input\nActor Object Reference (by ref)",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject=Class'"/Script/Engine.Actor"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=True,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
```

