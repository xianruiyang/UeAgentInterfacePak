# 使用自定义 Dataprep 过滤器和操作实现自动化

### 操作 HTTP Post 通知

一旦您的 Dataprep 配方达到各个完成阶段，就发送 HTTP Post 请求。此自定义 Dataprep 操作可以添加到配方堆栈的任何部分。它可用于向 Web API 发送通知，或用于将 Dataprep 场景信息发送到数据库。如果您在云服务器上无头处理 Dataprep 文件，这可能是进一步控制自动化的一种方法。 **注意：Body 字段中的数据对于该节点成功 POST 不是必需的，但它允许在接收端编程附加功能。** URL 端点可能如下所示： **https://www.yourwebsite.com/api/notify**** ** 并且 Body 可能包含一些如下所示的 JSON 数据：

```
{
  "DataprepFile": "Stage3DModel1A",
  "Completion": "Successful"
}
```

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_0" ExportPath=/Script/BlueprintGraph.K2Node_Event'"/Game/COMPLETED/HTTP_Post.HTTP_Post:EventGraph.K2Node_Event_0"'
   EventReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepOperation"',MemberName="OnExecution")
   bOverrideFunction=True
   NodePosX=-192
   NodePosY=64
   NodeGuid=52B433764EBF627C458D6282FC427725
   CustomProperties Pin (PinId=E6B697E343E8B2758A290FACA26C6F8B,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepOperation"',MemberName="OnExecution"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=5DD9BE5444414DC003A40AA3E51CC863,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_HttpRequest_0 825E3D49490BB45F11BACDAEE696865E,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=3778026547E997A29F3A35A2CBB7D9F8,PinName="InContext",PinToolTip="In Context\nDataprep Context Structure (by ref)\n\nThe context contains the data that the operation should operate on.",Direction="EGPD_Output",PinType.PinCategory="struct",PinType.PinSubCategory="",PinType.PinSubCategoryObject=/Script/CoreUObject.ScriptStruct'"/Script/DataprepCore.DataprepContext"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=True,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
```
