# 蓝图断言

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/Ebo4/unreal-engine-blueprint-assert

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2299 字符。

## 摘要

重新创建断言类似行为的蓝图方法。

## 中文整理

### 概览

要验证成员是否已在生成时设置，蓝图中没有可以使用的断言，如 [C++](https://docs.unrealengine.com/5.0/en-US/asserts-in-unreal-engine/) 中那样。为了使用类似的方法，您需要在 **BeginPlay ** 检查对象是否存在。如果未设置，则只需添加 **PrintString ** 并向其添加 **断点 **。当您生成此对象时，如果尚未设置，您将立即到达此断点。

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Event Name="K2Node_Event_3"
   EventReference=(MemberParent=Class'"/Script/Engine.ActorComponent"',MemberName="ReceiveBeginPlay")
   bOverrideFunction=True
   NodePosX=1632
   NodePosY=368
   NodeGuid=B2C8E21049AB65B9AD9E30B8444D405F
   CustomProperties Pin (PinId=BD02A9994D8F3612BE8A8BA447467FFD,PinName="OutputDelegate",Direction="EGPD_Output",PinType.PinCategory="delegate",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(MemberParent=Class'"/Script/Engine.ActorComponent"',MemberName="ReceiveBeginPlay"),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=3438C24C4C8AFC4057A56DBC5A62C63B,PinName="then",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_MacroInstance_2 84D8ACC740B9CAF70A90DABBF56B86BE,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_MacroInstance Name="K2Node_MacroInstance_2"
```
