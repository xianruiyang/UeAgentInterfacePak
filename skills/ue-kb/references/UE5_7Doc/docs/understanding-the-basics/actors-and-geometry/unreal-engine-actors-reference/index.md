---
title: "Actor参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-actors-reference"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "Actor和几何体", "Actor参考"]
---

# Actor参考

> 路径：虚幻引擎5.7文档 / 理解基础知识 / Actor和几何体 / Actor参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-actors-reference

本页面介绍了你将在虚幻引擎中最常用的Actor类型。Actor按用途和功能分组。每个小节均包括其他页面和资源的链接，你可在其中进一步了解这些Actor以及你可以对其执行的操作。

请注意，这并不是虚幻引擎中所有可用Actor类型的全面列表。一些插件和项目模板添加了自身的Actor，而某些Actor可能不可用于所有项目。

## 网格体Actor

**网格体** 定义了环境道具或玩家角色的形状和大小。虚幻引擎使用两种类型的网格体Actor：

- 静态网格体Actor，用于构建关卡和环境。
- 骨骼网格体Actor，通常用于玩家角色和动画非玩家角色（NPC）。

### 静态网格体Actor

**静态网格体Actor（Static Mesh Actor）** 是一种简单的Actor类型，用于在关卡中显示网格体。尽管名称暗示Actor是静态的（或无法移动），但这里"静态"指的是所使用的网格体类型，而不是指Actor能否移动。如果网格体的几何体不会改变，该网格体就是 *静态的*。否则，Actor本身可以在运行期间以其他方式移动或更改。

静态网格体Actor常用于创建游戏世界或其他类型的环境。

请参阅[静态网格体](../../../working-with-content/static-meshes/index.md)小节了解更多。

### 骨骼网格体Actor

**骨骼网格体Actor（Skeletal Mesh Actor）** 显示动画网格体，其几何体可以变形，通常是通过使用动画序列期间的控制点来变形。这些Actor可以从外部3D动画应用程序创建和导出，也可以直接在虚幻引擎中编程来实现。

骨骼网格体Actor常用于表示玩家角色或NPC，以及其他动画生物和复杂的机制。

请参阅[骨骼网格体](skeletal-mesh-actors/index.md)小节了解更多。

## 笔刷Actor（几何体Actor）

**笔刷Actor（Brush Actors）** 是一种基本类型的Actor，用于显示场景中的简单3D几何体，例如球体、立方体和楼梯。这些Actor可以使用关卡编辑器中的几何体编辑模式来更改。

虚幻引擎中提供了以下类型的笔刷Actor：

- 盒体
- 椎体
- 圆柱体
- 弧形楼梯
- 线性楼梯
- 螺旋楼梯
- 球体

笔刷Actor常用于快速对环境制作原型并粗略规划关卡。这些Actor可用于获得对环境道具的大小和布置的大致映像。

请参阅[几何体笔刷Actor](geometry-brush-actors/index.md)页面了解更多。

## 光源Actor

顾名思义，**光源Actor（Light Actors）** 用于将不同类型的光源放置在你的关卡中。一些光源Actor在周围有一个有限的效果范围，而其他光源Actor则影响你的整个关卡。

虚幻引擎中提供了以下类型的光源Actor：

- 定向光源
- 点光源
- 聚光源
- 矩形光源
- 天空光照

> [!TIP]
> 你可以从以下虚幻在线学习课程中进一步了解有关虚幻引擎的光照基础知识：
>
> - [光照基本概念和效果](https://www.unrealengine.com/en-US/onlinelearning-courses/lighting-essential-concepts-and-effects)
> - [介绍全局光照](https://www.unrealengine.com/en-US/onlinelearning-courses/introducing-global-illumination)

### 定向光源Actor

**定向光源（Directional Light）** 将模拟从无限远的光源发射的光线。这意味着此光源投射的所有阴影都将是平行的，从而使其非常适合模拟太阳光。

请参阅[定向光源](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/directional-lights/index.md)页面了解更多。

### 点光源Actor

**点光源（Point Lights）** 类似于现实世界的灯泡。点光源从中心（即关卡中的单个点）沿所有方向发射光线。

请参阅[点光源](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/point-lights/index.md)页面了解更多。

### 聚光源Actor

**聚光源（Spot Lights）** 类似于舞台灯光或手电筒。聚光源从单个点以圆锥形的形状向外发射光线。聚光源的形状由两个单独的锥角定义：

- 内锥角，光源在其中实现完全亮度。
- 外锥角，它定义了聚光源的外边界。

从内锥角延伸到外锥角的限值，光源的强度会衰减，在聚光源的光照盘面周围柔化。

请参阅[聚光源](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/spot-lights/index.md)页面了解更多。

### 矩形光源Actor

**矩形光源（Rect Lights）** 从定义了宽度和高度的矩形平面将光线发射到关卡中。你可以使用Actor这些来模拟具有矩形表面的各种光源，如窗户、电视或显示器屏幕。

请参阅[矩形光源](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/rectangular-area-lights/index.md)页面了解更多。

### 天空光照Actor

**天空光照（Sky Light）** 可捕获关卡的远处，并将其作为光源应用于场景。这意味着，无论你的天空是来自大气、天空盒顶部的云层或者远山，天空的外观及其光照/反射都将匹配。

> [!TIP]
> 如果你在开发增强现实（AR）应用程序，请考虑改用 **AR天空光照（ARSky Light）**Actor。
>
> AR天空光照是天空光照类的子类，使用现实世界环境探头来更新反射。每当对应探头的纹理基于现实世界光照更新时，它会重新生成光照和反射。这一切都在渲染线程上发生。

请参阅[天空光照](../../../building-virtual-worlds/lighting-the-environment/light-types-and-their-mobility/sky-lights/index.md)页面了解更多。

## 摄像机Actor

与现实世界的对等物一样，**摄像机Actor（Camera Actors）** 用于查看你的关卡并创建过场动画序列。此外，有一些起到支持作用的Actor可用于模拟现实世界摄像机镜头。

请参阅[摄像机Actor](camera-actors/index.md)了解详情。

## 音频和声音Actor

**音频和声音Actor（Audio and Sound Actors）** 用于向你的关卡添加音乐、语音录制和声音效果。

### 环境声音Actor

使用 **环境声音Actor（Ambient Sound Actor）** 可在关卡中的特定位置播放循环（连续）声音。

请参阅[环境声音Actor用户指南](../../../working-with-audio/audio-volume-actor/ambient-sound-actor-user-guide/index.md)页面了解更多。

### 音频音量

你可以使用 **音频音量Actor（Audio Volume Actor）** 在蓝图图表中定义可用于处理声音的区域，并将其设置用于应用混响效果、设置音量、定义受影响的区域、模拟声音上的遮蔽并定义声音音量的形状。

请参阅[音频音量](../../../working-with-audio/audio-volume-actor/audio-volumes/index.md)页面了解更多。

## Gameplay Actor

**Gameplay Actor** 将触发交互式功能。别受其名称误导，它们其实在所有种类的交互式应用程序中有广泛的用途，不仅仅是游戏。

下面是最常用的Gameplay Actor类型。

> [!TIP]
> 凡是能放进关卡中的东西，都称为Actor。体积（Volume）是有三维形状（例如立方体或球体）的Actor类型。

### 玩家出生点

**玩家出生点（Player Start）** 是放置在关卡中的一种Actor，用于指定在玩家开始关卡时，玩家角色在何处生成。

请参阅[玩家出生点](player-start-actor/index.md)页面了解更多。

### 触发器体积

**触发器（Triggers）** 这种Actor会在关卡中的其他事物（如玩家角色或另一个对象）与之交互时导致某个事件发生。例如，玩家可以与触发器交互以开启光源。

虚幻引擎中提供了以下类型的触发器：

- 盒体触发器
- 胶囊体触发器
- 球体触发器

所有这三种触发器类型有相同的功能。唯一不同的是形状。你可以根据触发器在关卡中的视觉表示种类来选择不同的形状。

此外，虚幻引擎还有泛型触发器体积。就像几何体Actor那样，你可以使用此体积快速对关卡中的交互制作原型。

请参阅[触发器体积Actor](trigger-volume-actors/index.md)页面了解更多。

### 阻挡体积

顾名思义，**阻挡体积（Blocking Volumes）** 用于防止玩家穿过。例如，你可以使用阻挡体积不让玩家从游戏世界的边缘掉落。

### Kill Z体积

**Kill Z体积Actor（Kill ZVolume Actor）** 会在玩家角色进入体积或与之交互时立即将其"杀死"（销毁）。你可以在Kill Z体积Actor的细节面板中指定销毁条件。

> [!NOTE]
> 请注意，Kill Z体积Actor不同于 **世界设置（World Settings）** 面板中的"Kill Z"选项，后者会在玩家越过Z轴（垂直轴）上的特定点之后立即摧毁玩家。

### 施加伤害体积

**施加伤害体积（Pain Causing Volume）** 会对进入体积的玩家或对象逐渐造成伤害。例如，如果玩家站在火焰中，你可以设置施加伤害体积来对其生命值产生对应的伤害。

> [!TIP]
> 不要站在火焰中。

请参阅[伤害施加体积Actor](pain-causing-volume-actor/index.md)页面了解更多。

## 角色和Pawn Actor

**Pawn** 和 **角色（Characters）** 这两种Actor都可以用于表示玩家和AI控制的角色。

### Pawn

**Pawn** 是世界中的玩家或AI实体的物理呈现。Pawn不仅决定了玩家或AI实体的视觉外观，还决定了它在碰撞和其他物理交互方面如何与世界交互。

根据你所构建的项目种类，Pawn可以是玩家头像、汽车，也可以根本没有物理呈现。

虚幻引擎中提供了两种类型的Pawn：

| Pawn类型 | 说明 |
| --- | --- |
| Pawn | 这是空的Pawn Actor。它没有附加视觉效果呈现（网格体）或功能按钮。 |
| 默认Pawn | 这是一种简单的Pawn Actor，带有球形碰撞和内置飞行动作。请注意，你需要向其附加控制器组件，然后它才能响应玩家输入。 |

### 角色

**角色（Character）** 是一种特定类型的Pawn，设计用于垂直方向的玩家角色，该角色可以在世界中行走、奔跑、跳跃、飞行和游泳。换言之，如果你的玩家控制了一个双足头像（例如，一个人类），该头像将为角色，而不是Pawn。

虚幻引擎中提供了多种类型的角色Actor。设置项目时，请选择最符合项目类型的角色Actor。

| 角色类型 | 说明 | 延伸阅读 |
| --- | --- | --- |
| 角色（Character） | 这是一个简单的角色Actor，带有胶囊体碰撞、空的网格体和角色运动。照现状，此Actor在关卡中不可见，但可以控制。 |  |
| Arch Vis角色（Arch Vis Character） | Arch Vis角色基于虚幻引擎的第一人称角色类。其中某些参数（如扭曲和转身速度）进行了调整，以方便更流畅地移动。此角色针对架构可视化项目进行了优化。 | 使用[Archviz角色Pawn](https://www.youtube.com/watch?v=tLWVDEUtysc) (YouTube) |
| 平面角色（Paper Character） | 平面角色用于2D项目。平面角色与通用角色之间的区别是，平面角色使用平面图像序列视图组件（一种Sprite）来直观表示角色，而泛型角色使用三维网格体。 | [Paper 2D Sprites](../../../animating-characters-and-objects/paper-2d-overview/paper-2d-sprites/index.md) |

## 视觉效果Actor

**视觉效果Actor（Visual Effects Actors）** 用于更改关卡的外观体验。这些Actor只有有限的效果区域，由有限的三维体积定义。

### 后期处理体积

**后期处理体积（Post Process Volume）** 将一个或多个视觉效果应用于其中包含的对象。虚幻引擎提供了广泛的效果供你应用，从泛光和渐晕到全局光照和光线追踪反射，不一而足。

> [!NOTE]
> 根据关卡的大小和复杂程度，以及你的设备规格，后期处理可能是一个极度耗费资源的过程，并且可能对运行时的性能产生重大影响。

请参阅[后期处理效果](../../../designing-visuals-rendering-and-graphics/post-process-effects/index.md)了解更多。

### 反射捕获Actor

**反射捕获Actor（Reflection Capture Actors）** 用于捕获关卡的内容进行反射。它们将捕获周围区域的静态图像，并根据Actor的形状将该图像映射到球体或盒体形状。在反射捕获Actor的体积中，所有内容的静态图像都会被其周围的反射表面所反射。

虚幻引擎中提供了以下类型的反射捕获Actor：

- 球体反射捕获
- 盒体反射捕获

请参阅[反射环境](../../../building-virtual-worlds/lighting-the-environment/reflections-environment/index.md)页面了解更多。

### 平面反射Actor

**平面反射Actor（Planar Reflection Actor）** 将捕获场景的2D镜像。它非常适合用于创建动态镜面反射，以及捕获不在当前摄像机视图中的事物。

请参阅[平面反射](../../../building-virtual-worlds/lighting-the-environment/reflections-environment/planar-reflections/index.md)页面了解更多。

### 贴花Actor

**贴花Actor（Decal Actors）** 可以放在网格体表面以渲染其顶部的材质，非常类似于现实世界的"贴纸"。你可以使用贴花来向使用相同纹理的多个表面添加细节和变体，例如向模块化墙壁添加漏水或油漆溅污。

请参阅以下页面了解更多：

- [贴花Actor](decal-actors/index.md)

## 世界构建Actor

使用 **世界构建Actor（Worldbuilding Actors）** 可向你的关卡添加逼真细节，例天空大气、雾和体积云。

### 天空大气Actor

**天空大气（Sky Atmosphere）** **Actor** 是基于物理的天空和大气渲染技术。它足够灵活，可创建类似地球的大气，展现出以日出和日落为特色的昼夜变换，也可以创建具有异世界性质的地外大气。它还提供了空中视角，你可以通过使用恰当的行星曲率模拟从地面到天空再到外太空的过渡。

请参阅[天空大气](../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/sky-atmosphere-component/index.md)页面了解更多。

### 体积云Actor

**体积云Actor（Volumetric Cloud Actor）** 是基于物理的云渲染系统，该系统使用材质驱动方法，让美术师和设计师可以自由地创建项目所需的任意类型的云。该系统提供可伸缩的云，适用于使用地面视角、空中视角以及地面到外太空过渡的项目。

请参阅[体积云](../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/volumetric-cloud-component/index.md)页面了解更多。

### 指数高度雾Actor

**指数高度雾（Exponential Height Fog）** 将在关卡中海拔较低处创建密度较大的雾，在海拔较高处创建密度较低的雾。过渡很平滑，因此绝不会随着海拔的增加而出现生硬的界限。

指数高度雾还提供了两种雾颜色，其中一种颜色用于面向主导定向光源的半球（如果不存在这样的光源，则直接向上），另一种颜色用于另一半球。

请参阅[指数高度雾用户指南](../../../building-virtual-worlds/lighting-the-environment/environmental-light-with-fog-clouds-sky-and-atmosphere/exponential-height-fog/index.md)页面了解更多。

## 其他Actor

虚幻引擎包含其他一些Actor，可以用于向你的关卡添加各种元素。其中一些Actor默认启用，而其他一些Actor则要求你首先启用特定的插件。要了解如何在虚幻引擎中启用插件，请参阅"使用插件"页面。

### 文本渲染Actor

**文本渲染Actor（Text Render Actor）** 提供了向关卡添加文本的简单方法。要快速了解用法示例，请创建新的第三人称项目。地板上显示的"第三人称（THIRD PERSON）"蓝色文本是使用文本渲染Actor渲染的。

你可以使用 **文本3D（Text 3D）** 插件创建更复杂的3D文本并对其进行动画处理。请参阅[3D文本Actor](3d-text-actor/index.md)页面了解更多。

### 目标点Actor

**目标点Actor（Target Point Actors）** 提供了世界中的一个泛型点，你可以从中生成项目。如果你熟悉其他3D应用程序（例如3Ds Max或Maya），你就会知道，目标点Actor与这些程序中的虚拟Actor非常相似。

请参阅[目标点Actor](target-point-actors/index.md)页面了解更多。
