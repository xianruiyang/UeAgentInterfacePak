# 使用自定义 Dataprep 过滤器和操作实现自动化

### 按距位置的距离过滤

使用此自定义过滤器，您可以指定起始位置，然后过滤距离该位置一定距离内的任何对象的选择。例如，如果您正在处理大型文件（例如城市模型），但您只需要在特定点周围选择一小部分模型，这会很有帮助。它还可以在较小的范围内使用，允许您过滤房间或其他焦点的特定半径内的选定对象。

**按距位置片段代码的距离进行过滤**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0" ExportPath=/Script/BlueprintGraph.K2Node_FunctionEntry'"/Game/COMPLETED/Distance_from_Location.Distance_from_Location:Fetch.K2Node_FunctionEntry_0"'
   ExtraFlags=1073741824
   FunctionReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepBoolFetcher"',MemberName="Fetch")
   NodePosX=-1136
   NodePosY=-288
   NodeGuid=3A8201534EB5060939109DB7E156DDDB
   CustomProperties Pin (PinId=099249A34F2D46FA4DABD9B118D1CAF0,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_DynamicCast_1 C512628248682466E3EC87B8E27BF8A4,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=B3F92DF546C440946050EDB800829FD1,PinName="Object",PinToolTip="Object\nObject Reference\n\nThe object from which the fetcher should try to retrieve the boolean",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject=/Script/CoreUObject.Class'"/Script/CoreUObject.Object"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_DynamicCast_1 5A069BE84FBD21E1835C77B8770D217C,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionResult Name="K2Node_FunctionResult_0" ExportPath=/Script/BlueprintGraph.K2Node_FunctionResult'"/Game/COMPLETED/Distance_from_Location.Distance_from_Location:Fetch.K2Node_FunctionResult_0"'
```

### 过滤元数据组合

此过滤器允许您选择与元数据键+值对的组合相匹配的参与者。这有助于将过滤功能扩展到单个值之外。您可能在架构 Datasmith 文件导入中有数百个模型。通过过滤元数据值组合的能力，我们可以按楼层进行过滤，进一步细化过滤器以仅包括楼层上的服务器机房模型等。源数字内容创建 (DCC) 工具（例如 3D Studio Max）中指定的元数据可能包括材质属性、艺术指导决策、注释、要在 Dataprep 中执行的操作列表等。下面的使用 Datasmith 元数据文档链接包括有关在外部 DCC 工具中格式化元数据以供 Datasmith 摄取的信息。 - [使用 Datasmith 元数据](https://docs.unrealengine.com/5.3/en-US/using-datasmith-metadata-in-unreal-engine)

```
Begin Object Class=/Script/BlueprintGraph.K2Node_FunctionEntry Name="K2Node_FunctionEntry_0" ExportPath=/Script/BlueprintGraph.K2Node_FunctionEntry'"/Game/COMPLETED/Metadata_Combos.Metadata_Combos:Fetch.K2Node_FunctionEntry_0"'
   LocalVariables(0)=(VarName="CurrentObject",VarGuid=F117F9134A305CF8A5CA9BBF22C2FD79,VarType=(PinCategory="object",PinSubCategoryObject=/Script/CoreUObject.Class'"/Script/CoreUObject.Object"'),FriendlyName="Current Object",Category=NSLOCTEXT("KismetSchema", "Default", "Default"),PropertyFlags=5)
   ExtraFlags=1073741824
   FunctionReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepBoolFetcher"',MemberName="Fetch")
   NodePosX=-576
   NodePosY=-192
   NodeGuid=319C781F43EFB24704B307B50EE32395
   CustomProperties Pin (PinId=2240C9B94A986BEEDE062CA1FBB6F5D3,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_VariableSet_0 98CB46084C14F0042AD969BCAD273EA8,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=7A582DCE4C777919CB1894A197784ECD,PinName="Object",PinToolTip="Object\nObject Reference\n\nThe object from which the fetcher should try to retrieve the boolean",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject=/Script/CoreUObject.Class'"/Script/CoreUObject.Object"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_VariableSet_0 6B30E3E049CFD930768B7B8064D70E29,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
```
