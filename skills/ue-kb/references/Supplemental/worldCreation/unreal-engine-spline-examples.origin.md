# 样条曲线示例

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/oLLe/unreal-engine-spline-examples

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1689 字符。

## 摘要

样条线片段。

## 中文整理

### 样条曲线示例

**1.***** **几何脚本样条线* 蓝图类型：生成的动态网格物体 Actor（需要插件）复制并粘贴到事件图中。要公开的参数：（半径、长方体数量、长方体比例、翻转方向）向蓝图添加至少一个样条组件，以便您可以使用它。提示：打开样条线上的“覆盖构造脚本”，以便您可以在关卡中进行编辑。材料片段如下。

**几何脚本样条线（需要插件）**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_3" ExportPath="/Script/BlueprintGraph.K2Node_Event'/Game/PyTest/BP_GeoScriptSpline.BP_GeoScriptSpline:EventGraph.K2Node_Event_3'"
   EventReference=(MemberParent="/Script/CoreUObject.Class'/Script/GeometryScriptingEditor.GeneratedDynamicMeshActor'",MemberName="OnRebuildGeneratedMesh")
   bOverrideFunction=True
   NodePosX=-496
   NodePosY=-112
   NodeGuid=83F62D8E48AD10D6C3125BAFF674BF9B
   CustomProperties Pin (PinId=263D1F394BB8B04BEE78BB8AB1EE38C7,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent="/Script/CoreUObject.Class'/Script/GeometryScriptingEditor.GeneratedDynamicMeshActor'",MemberName="OnRebuildGeneratedMesh"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=9C1314D94DE758BF9174AA8BFAB7C50B,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_CallFunction_15 743D0E8A4CCE780731629DAD70A1780D,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=446000194269653A91937FB43E281724,PinName="TargetMesh",PinToolTip="Target Mesh\nDynamic Mesh Object Reference",Direction="EGPD_Output",PinType.PinCategory="object",PinType.PinSubCategory="",PinType.PinSubCategoryObject="/Script/CoreUObject.Class'/Script/GeometryFramework.DynamicMesh'",PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
```

***几何脚本样条线使用的材质片段：***

**道路可视化材料**
