# 使用自定义 Dataprep 过滤器和操作实现自动化

### 按数据表过滤

此自定义过滤器允许您根据与数据表值匹配的元数据来选择参与者。有很多方法可以实现这一目标。这可以是唯一的 ID、资产标签的匹配、匹配的自定义元数据等。在此示例中，我们将来自 Datasmith 导出的传入元数据与数据表字段进行匹配。这种方法的优点之一是可以使用 CSV 文件来管理过滤。您团队中的部分成员可能没有 UE 经验，因此这有助于将 Dataprep 的配置转移到 Google Sheets 和 Microsoft Excel 等程序中。对于此示例，以下蓝图结构已用于我们的数据表参考。如果我们将此 Google Sheet 导出到 CSV 文件，然后将该 CSV 文件导入到虚幻引擎中，则此时我们可以指定它应对应的蓝图结构。下面我们有一个更复杂的蓝图结构的示例视图，设施经理/资产经理可以使用它来跟踪资产。可以创建蓝图结构来匹配导入数据的定制格式。 - [数据驱动游戏元素](https://docs.unrealengine.com/5.3/en-US/data-driven-gameplay-elements-in-unreal-engine)

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0" ExportPath=/Script/BlueprintGraph.K2Node_FunctionEntry'"/Game/COMPLETED/Filter_by_Data_Table.Filter_by_Data_Table:Fetch.K2Node_FunctionEntry_0"'
   ExtraFlags=1073741824
   FunctionReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepBoolFetcher"',MemberName="Fetch")
   NodePosX=-848
   NodeGuid=75257AF34E85088C31FEA597B144032D
   CustomProperties Pin (PinId=E226DFA54AF88D7F8ED8B28C85A4DDAF,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_CallFunction_3 075B85BC4C2481B2344D759EE1E1B645,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=F8D0F6144E7382941241DDBF63F2FAD3,PinName="Object",PinToolTip="Object\nObject Reference\n\nThe object from which the fetcher should try to retrieve the boolean",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject=/Script/CoreUObject.Class'"/Script/CoreUObject.Object"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_CallFunction_3 16E5C75D4F400DE68F26EA94AB5E1797,K2Node_CallFunction_5 16E5C75D4F400DE68F26EA94AB5E1797,K2Node_CallFunction_0 16E5C75D4F400DE68F26EA94AB5E1797,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionResult Name="K2Node_FunctionResult_1" ExportPath=/Script/BlueprintGraph.K2Node_FunctionResult'"/Game/COMPLETED/Filter_by_Data_Table.Filter_by_Data_Table:Fetch.K2Node_FunctionResult_1"'
   FunctionReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepBoolFetcher"',MemberName="Fetch")
```

### 可下载的自定义操作

从下面的链接下载 Dataprep 自定义操作。该 zip 文件包含所有 Dataprep 自定义操作 .uasset 文件 (Unreal Engine 5.2)。要在您自己的虚幻引擎 5.2 或 5.3 项目中使用这些文件，请通过 Windows 文件资源管理器将 .uasset 文件复制到您的项目内容文件夹中。 - [下载自定义操作](https://epicgames.box.com/v/customoperations)
