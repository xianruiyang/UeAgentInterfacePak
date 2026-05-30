# 使用自定义 Dataprep 过滤器和操作实现自动化

### 操作增量变换

此操作将增量修改堆栈中过滤的每个角色的位置、旋转和缩放值。此示例旨在说明，在使用自定义 Dataprep 操作时，我们不必将统一的结果应用于每个过滤的参与者。

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_0" ExportPath=/Script/BlueprintGraph.K2Node_Event'"/Game/COMPLETED/Increment_Transforms.Increment_Transforms:EventGraph.K2Node_Event_0"'
   EventReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepOperation"',MemberName="OnExecution")
   bOverrideFunction=True
   NodePosX=-784
   NodePosY=64
   NodeGuid=7590B77F4FFF2F2FF25CA6A7DAC21107
   CustomProperties Pin (PinId=3F0791304621877361A6749B4BBE7C49,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepOperation"',MemberName="OnExecution"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=369A2240427361361480E8881DD53821,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_VariableSet_8 D3A1EE8845C6971F1D8A3CADA02FF4EE,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=38BBDE0D4A0DC40CDBE19B843F52A5BD,PinName="InContext",PinToolTip="In Context\nDataprep Context Structure (by ref)\n\nThe context contains the data that the operation should operate on.",Direction="EGPD_Output",PinType.PinCategory="struct",PinType.PinSubCategory="",PinType.PinSubCategoryObject=/Script/CoreUObject.ScriptStruct'"/Script/DataprepCore.DataprepContext"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=True,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_BreakStruct_0 FE351DB74F9DB5F0679CABBD30268DB9,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
```
