# 使用自定义 Dataprep 过滤器和操作实现自动化

### HTTP 获取操作

这需要根据 Web API 和您的目标 JSON 响应进行定制修改。下面是一个示例，说明如何发送 HTTP Get 请求以从 Web API 接收信息，然后该请求可以指示 Dataprep 应如何处理对象或帮助使用 Web 数据填充虚幻引擎场景。此处的 HTTP Get 操作示例从 Web API URL 端点的 JSON 响应中提取信息。我们可以拥有一个数据库，其中包含您打算通过 Datasmith 文件格式引入的所有资产的信息，该数据库可用于应用材质、决定需要交换哪些网格，或根据值填充添加的逻辑级别等。我们甚至可以有一个场景，其中仅将具有唯一标识符的虚拟占位符引入 Dataprep，然后使用来自 Web API 的信息换出游戏资产。 **注意：这也可以修改为包括使用标头作为 HTTP 蓝图插件一部分的身份验证步骤。 ** **https://www.yourwebsite.com/api/getcontent** 就本示例而言，JSON 响应如下所示：

**JSON 响应示例**

```
{
    "ObjectID":"33968",
    "ObjectName":"MajorOak",
    "Material":1,
    "eastings":53.20422029847928,
    "northings":-1.0727655629256523,
    "country":"England",
    "codes":
    {
      "weather_code":"3433433",
```

这显示了一个基本示例，从 JSON 对象中提取两个字段值。我计划在寒假后用更多的例子来扩展这一点。

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_0" ExportPath=/Script/BlueprintGraph.K2Node_Event'"/Game/HTTP_Get.HTTP_Get:EventGraph.K2Node_Event_0"'
   EventReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepOperation"',MemberName="OnExecution")
   bOverrideFunction=True
   NodePosX=-528
   NodePosY=128
   NodeGuid=F56C21B144CE7E9240F15D93306DEC7A
   CustomProperties Pin (PinId=9BA3A3824CB4CD53EFF5A5AD34A664B3,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent=/Script/CoreUObject.Class'"/Script/DataprepCore.DataprepOperation"',MemberName="OnExecution"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=9D648CD447D36E43D8F76399CCB79F73,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_HttpRequest_0 35CD07624ABD25965E4DFFA3F322011F,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=4C5A57BC49EE56294A2D7C974337400F,PinName="InContext",PinToolTip="In Context\nDataprep Context Structure (by ref)\n\nThe context contains the data that the operation should operate on.",Direction="EGPD_Output",PinType.PinCategory="struct",PinType.PinSubCategory="",PinType.PinSubCategoryObject=/Script/CoreUObject.ScriptStruct'"/Script/DataprepCore.DataprepContext"',PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=True,PinType.bIsConst=True,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
```

### 概括

我希望这些可下载的自定义 Dataprep 过滤器和操作能够作为起点有所帮助，并为那些希望在 Dataprep UI 中超越默认过滤器和操作实现自动化的人提供一些灵感。寒假结束后，我将在此页面添加一些进一步的自定义 Dataprep 过滤器和操作。亲切的问候，西蒙·布莱克尼|技术客户经理 | Epic Games - [Dataprep 概述](https://docs.unrealengine.com/5.1/en-US/dataprep-overview-in-unreal-engine) - [在虚幻引擎中使用可视化 Dataprep |网络研讨会](https://youtu.be/g7LS8SaHmsI?feature=shared) - [Snowden Tower 示例项目 Datasmith 文件](https://epicgames.box.com/shared/static/suxhu8fyjip4qcyrt89grng0jt3ijnty.zip)

## 相关链接

- [Datasmith Export Plugins](https://unrealengine.com/en-US/datasmith/plugins)
- [Datasmith Overview](https://docs.unrealengine.com/5.3/en-US/datasmith-plugins-overview)
- [Dataprep Overview](https://docs.unrealengine.com/5.3/en-US/dataprep-overview-in-unreal-engine)
- [Download Custom Filters](https://epicgames.box.com/v/customfilters)
- [Using Datasmith Metadata](https://docs.unrealengine.com/5.3/en-US/using-datasmith-metadata-in-unreal-engine)
- [Data Driven Gameplay Elements](https://docs.unrealengine.com/5.3/en-US/data-driven-gameplay-elements-in-unreal-engine)
- [Download Custom Operations](https://epicgames.box.com/v/customoperations)
- [Dataprep Overview](https://docs.unrealengine.com/5.1/en-US/dataprep-overview-in-unreal-engine)
- [Using Visual Dataprep in Unreal Engine | Webinar](https://youtu.be/g7LS8SaHmsI?feature=shared)
- [Snowden Tower Sample Project Datasmith Files](https://epicgames.box.com/shared/static/suxhu8fyjip4qcyrt89grng0jt3ijnty.zip)
