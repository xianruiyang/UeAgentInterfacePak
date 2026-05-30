# 第一人称动作 01：简介 (Part 2/3)

Source file: `unreal-engine-first-person-motion-01-introduction.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

### 跑步

在这里我们将设置运行行为。通过更改**角色组件**变量**最大步行速度**可以轻松设置跑步行为。 600 和 1200 的值似乎相当不错，但这取决于您想要的游戏玩法。至于蹲伏，我们将使用在 **IMC_Default ** 中映射到 **左移** 键的新按下/释放操作 (**IA_Run**)，然后在 **BP_FirstPersonCharacter** 蓝图中实现该事件。因此，当我们按下 Shift 键时，角色会奔跑，松开时角色会行走。对于步行/跑步速度值，我们将使用设置数据资源，如下一节：游戏设置中所述。 - 首先，在 **开始游戏** 时，我们将提取步行设置并将其提升为变量 - 然后我们将实现跑步事件

**从设置中提取行走设置并将其放入开始游戏时的变量中**

```
Begin Object Class=/Script/BlueprintGraph.K2Node_Tunnel Name="K2Node_Tunnel_0" ExportPath="/Script/BlueprintGraph.K2Node_Tunnel'/Game/Blueprint/Game/BP_FirstPersonCharacter.BP_FirstPersonCharacter:EventGraph.K2Node_Composite_3.Init.K2Node_Tunnel_0'"
   OutputSourceNode="/Script/BlueprintGraph.K2Node_Composite'/Game/Blueprint/Game/BP_FirstPersonCharacter.BP_FirstPersonCharacter:EventGraph.K2Node_Composite_3'"
   bCanHaveOutputs=True
   NodePosX=2160
   NodePosY=-1888
   NodeGuid=BCEC551745A58E482AB2A483E3D72AF6
   CustomProperties Pin (PinId=0AB1BA684720F75F518BED8610C28B4E,PinName="execute",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_VariableSet_0 F4A40E6B4A33A1F72A3C0382CF0D918E,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties UserDefinedPin (PinName="execute",PinType=(PinCategory="exec"),DesiredPinDirection=EGPD_Output)
End Object
Begin Object Class=/Script/BlueprintGraph.K2Node_Tunnel Name="K2Node_Tunnel_1" ExportPath="/Script/BlueprintGraph.K2Node_Tunnel'/Game/Blueprint/Game/BP_FirstPersonCharacter.BP_FirstPersonCharacter:EventGraph.K2Node_Composite_3.Init.K2Node_Tunnel_1'"
```

**实现运行输入事件**

```
Begin Object Class=/Script/InputBlueprintNodes.K2Node_EnhancedInputAction Name="K2Node_EnhancedInputAction_1" ExportPath="/Script/InputBlueprintNodes.K2Node_EnhancedInputAction'/Game/Blueprint/Game/BP_FirstPersonCharacter.BP_FirstPersonCharacter:EventGraph.K2Node_EnhancedInputAction_1'"
   InputAction="/Script/EnhancedInput.InputAction'/Game/Data/Input/Actions/IA_Run.IA_Run'"
   NodePosX=2112
   NodePosY=336
   AdvancedPinDisplay=Hidden
   NodeGuid=5A45169B4240AB2A70B0D3AB4CFE24B9
   CustomProperties Pin (PinId=FC1B41CD48E88973D19A008DADF9C786,PinName="Triggered",PinToolTip="Triggering occurred after one or more processing ticks",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=False,bOrphanedPin=False,)
   CustomProperties Pin (PinId=C70A53AA4BCF94F84F1A6AB5FBD46CB8,PinName="Started",PinToolTip="An event has occurred that has begun Trigger evaluation. Note: Triggered may also occur this frame, but this event will always be fired first.",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,LinkedTo=(K2Node_VariableSet_0 5DE809FB41EAFA7B438001AB57B188ED,),PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=True,bOrphanedPin=False,)
   CustomProperties Pin (PinId=08A3C91E48C6640E844A56B9D710B882,PinName="Ongoing",PinToolTip="Triggering is still being processed. For example, an action with a \"Press and Hold\" trigger\nwill be \"Ongoing\" while the user is holding down the key but the time threshold has not been met yet.",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=True,bOrphanedPin=False,)
   CustomProperties Pin (PinId=4B50F62C4C616A545C4A35A2C453A903,PinName="Canceled",PinToolTip="Triggering has been canceled. For example,  the user has let go of a key before the \"Press and Hold\" time threshold.\nThe action has started to be evaluated, but never completed.",Direction="EGPD_Output",PinType.PinCategory="exec",PinType.PinSubCategory="",PinType.PinSubCategoryObject=None,PinType.PinSubCategoryMemberReference=(),PinType.PinValueType=(),PinType.ContainerType=None,PinType.bIsReference=False,PinType.bIsConst=False,PinType.bIsWeakPointer=False,PinType.bIsUObjectWrapper=False,PinType.bSerializeAsSinglePrecisionFloat=False,PersistentGuid=00000000000000000000000000000000,bHidden=False,bNotConnectable=False,bDefaultValueIsReadOnly=False,bDefaultValueIsIgnored=False,bAdvancedView=True,bOrphanedPin=False,)
```
