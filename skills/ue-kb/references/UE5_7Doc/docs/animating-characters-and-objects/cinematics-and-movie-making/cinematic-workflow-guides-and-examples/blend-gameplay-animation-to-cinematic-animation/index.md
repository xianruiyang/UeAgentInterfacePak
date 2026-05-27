---
title: "混合Gameplay和Sequencer动画"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/blend-gameplay-animation-to-cinematic-animation-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "过场动画和Sequencer", "过场动画流程指南和示例", "混合Gameplay和Sequencer动画"]
---

# 混合Gameplay和Sequencer动画

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 过场动画和Sequencer / 过场动画流程指南和示例 / 混合Gameplay和Sequencer动画

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/blend-gameplay-animation-to-cinematic-animation-in-unreal-engine

创建过场动画序列时，你可能希望将Gameplay动画与关卡序列中的动画进行相互混合。通常，这样做是为了创建进出过场动画的无缝过渡，包括混合玩家动画和玩家摄像机。

本文档介绍可用于在Sequencer和Gameplay之间混合玩家动画和摄像机动画的工作流程和注意事项。

#### 先决条件

- 在项目中有一个可控制的玩家角色。本文将以

  第三人称模板

  为例。
- 已经创建过场动画序列，并已准备好将其混合到Gameplay。
- 已熟悉如何在Sequencer中

  引用玩家

  。

## 动画蓝图设置

通常，在Sequencer中设置角色动画时，"动画模式（Animation Mode）"属性会自动更改为 **使用自定义模式（Use Custom Mode）**。自定义模式是一种特定于Sequencer的特殊[动画蓝图](../../../skeletal-mesh-animation-system/animation-blueprints/index.md)，与在Gameplay中用于设置玩家动画的模式不同。若要在Sequencer与Gameplay之间混合角色，*不能* 使用 **自定义模式**，而必须改用角色在Gameplay中所用的同一动画蓝图。

为了确保这一点，可以[在序列中引用玩家角色蓝图](../how-to-reference-the-player-in-unreal-engine-cinematics/index.md)，这样应该会将"动画模式（Animation Mode）"设置为Gameplay动画蓝图。如果没有，则可以通过选择角色、导航到 **细节（Details）** 面板并执行以下操作来手动设置此属性：

- 将

  动画模式（Animation Mode）

  设置为

  使用动画蓝图（Use Animation Blueprint）

  。
- 将

  动画类（Anim Class）

  设置为Gameplay中使用的

  动画蓝图

  。对于第三方模板，设置为

  ABP_Manny_C

  。

显式设置动画蓝图后，Sequencer不会覆盖此属性以使用自定义模式。

### 插槽设置

使用动画蓝图在Sequencer中设置角色动画时，必须确保动画蓝图包含[插槽](../../../skeletal-mesh-animation-system/animation-blueprints/animation-slots/index.md)，这些插槽提供了一种将动画注入[动画图表（Anim Graph）](../../../skeletal-mesh-animation-system/animation-blueprints/graphing-in-animation-blueprints/index.md)的方法。虽然插槽主要用于播放[蒙太奇](../../../skeletal-mesh-animation-system/animation-assets-and-features/animation-montage/index.md)的动画，但也可以用于播放Sequencer的动画。

要创建新插槽，请打开要混合的角色的动画蓝图，然后执行以下操作：

1. 单击

   窗口（Window）

   并启用

   动画插槽管理器（Anim Slot Manager）

   （如果尚未启用）。
2. 在"动画插槽管理器（Anim Slot Manager）"中，单击

   添加插槽（Add Slot）

   。
3. 输入新插槽的名称并按

   Enter

   。

> [!NOTE]
> 插槽存储在[骨架](../../../skeletal-mesh-animation-system/animation-assets-and-features/skeletons/index.md)上，因此在创建或更改插槽时，也是在编辑骨架。在进行任何插槽更改时，单击"动画插槽管理器（Anim Slot Manager）"中的 **保存（Save）** 将保存骨架。

接下来，在动画图表中引用插槽。

1. 在图表中单击鼠标右键，然后添加一个

   插槽"DefaultSlot"

   节点。
2. 选择该节点，然后在

   细节（Details）

   面板中将

   插槽名称（Slot Name）

   设置为先前创建的插槽的名称。

除了创建插槽之外，还要考虑该插槽在动画图表中的插入 *位置*。对于大多数简单混合，最好将插槽放置为 **输出姿势（Output Pose）** 之前的最终节点，但是在某些情况下，建议放置在动画图表逻辑链中较前面的位置以便利用程序化效果。

以下示例将插槽节点连接在动画蓝图逻辑与"输出姿势（Output Pose）"之间。

## 混合到空闲姿势

最常见的无缝混合之一是将过场动画混合到Gameplay，使玩家角色以默认的空闲运动姿势结束。如[先决条件](#%E5%85%88%E5%86%B3%E6%9D%A1%E4%BB%B6)中所述，本指南假定已存在动画和Sequencer内容。这包括：

- [角色动画](../../how-to-make-movies/how-to-add-cinematic-animation-to-a-character/index.md)，其中的角色在组件根坐标处结束并与Gameplay空闲姿势匹配。

  > 动图已省略：2b6343bd851f43153c1ac37164ddb88d79172160dc0fb589285aed6a8130cca1
- [摄像机动画](../../how-to-make-movies/how-to-animate-cinematic-cameras/index.md)，以Gameplay摄像机的大致位置结束。

  > 动图已省略：164952a6dd3b2f7e95a84fac376de599f25e3e23c51af9cc3c893f10d8eeafae

### Sequencer中的角色设置

要使玩家角色正确混合，请在Sequencer中执行以下操作：

1. 右键单击[动画](../../unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/cinematic-animation-track/index.md)分段，导航到 **属性（Properties）** 菜单，然后将 **插槽名称（Slot Name）** 设置为先前创建的插槽的名称。
2. 拖动动画分段的右上角以便在动画结束处创建混出区域。尽管此动画的结束姿势可能与Gameplay姿势匹配，但这仍然有助于确保角色在Sequencer动画结束时不会"弹出"。

   > 动图已省略：86432e5b1d59ea8e32bf4a6b2383a9ad151bebe34ba1d89c118738fd53079a49
3. 右键单击角色的变换分段，导航到 **属性（Properties）** 菜单，然后将 **结束时（When Finished）** 设置为 **保持状态（Keep State）**。这是确保角色在Sequencer完成时保持在同一位置所必需的设置。

### Sequencer中的摄像机设置

要使过场动画摄像机正确混合到Gameplay摄影机，请在Sequencer中执行以下操作：

1. 右键单击[镜头切换轨道](../../unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/cinematic-camera-cut-track/index.md)并启用 **可以混合（Can Blend）**。
2. 与动画分段的混合类似，拖动镜头切换分段的右上角即可在摄像机动画结束处创建混出区域。

   > 动图已省略：e8206b75716886de53c0fab81fc79ed7bd278aaab5593ae81d4af752cf103566
3. 选择 **电影摄像机Actor（Cine Camera Actor）**，然后在 **细节（Details）** 面板中禁用 **约束宽高比（Constrain Aspect Ratio）**。

> [!NOTE]
> 如果Gameplay摄像机使用不同的轴约束，可能还需要选择 **关卡序列Actor（Level Sequence Actor）** 并禁用 **覆盖宽高比轴约束（Override Aspect Ratio Axis Constraint）**，以防止视野突然变化。

### 混合空闲状态结果

在运行时播放此序列时，应该会看到角色从Sequencer混合到Gameplay。再次强调，本指南假定你已熟悉如何在Sequencer中[引用玩家](../how-to-reference-the-player-in-unreal-engine-cinematics/index.md)。

> 动图已省略：56db71f51b2c9c1c4b3b679df3a5d36eae3a7deaaefe838a5fb2d2ccd7f55987

## 其他注意事项

要提高Sequencer混合质量，请考虑项目中的以下因素：

### 不平坦的地貌

在平坦表面上混合角色动画通常需要简单的混合逻辑并在动画图表中放置插槽。但是，如果Gameplay动画蓝图包含将IK脚放置在不平坦表面上的逻辑，则可能需要重新考虑混合插槽在动画图表中的放置位置。否则，在过场动画混出时，角色可能会对这种地貌表现出明显的调整行为。

例如，在第三人称模板中，人体模型使用Control Rig节点中的IK逻辑针对不平坦的表面进行程序化调整。

如果混合发生在不平坦的表面上，则可能需要移动或新建一个在动画图表中IK调整节点之前执行的插槽。后续进行IK调整时，会考虑该插槽中的动画。

如果Sequencer中的动画使用该插槽，应该会在播放动画时看到相应的程序化调整。

> 动图已省略：e8b5418528f617584deb69849642be257ec6bd2cbac07742e768d6a911c8b004

### 抑制和恢复输入

在大多数混合过程中，可能希望抑制控制器输入，以防止在播放混合序列时控制器和Sequencer之间发生冲突。实现此目标的主要方法是选择 **关卡序列Actor（Level Sequence Actor）**，然后在 **细节（Details）** 面板中启用以下选项：

- 禁用移动输入（Disable Movement Input）

  ，此选项会禁用角色的Gameplay移动。
- 禁用查看输入（Disable Look at Input）

  ，此选项会禁用角色的Gameplay摄像机控制。

这将抑制序列持续时间内的所有输入。

如果需要精确控制何时可以限制和释放玩家输入，还可以使用 **设置过场动画模式（Set Cinematic Mode）** 功能手动控制输入。

例如，为了进行更细致的输入管理，你可能希望在混合序列结束之前释放对玩家的控制。为此，可执行以下操作：

1. 右键单击角色的变换[分段](../../unreal-engine-sequencer-movie-tool-overview/creating-animation-keyframes/index.md#%E5%88%86%E6%AE%B5)，导航到 **属性（Properties）** 菜单，然后解锁 **分段范围结束（Section Range End）**。接着，将变换分段的结束时间拖动到要释放控制的位置。这是必要的，因为变换分段在序列播放过程中会不断进行评估，将角色保持在原位。提前结束会使其不再进行评估。

   > 动图已省略：a67719a2d118979ff4b46bc9ed372033cef7e4610af942ad5a60e954db834b66
2. 使用以下逻辑在变换分段结束时创建[事件跟踪](../../unreal-engine-sequencer-movie-tool-overview/sequencer-track-list/cinematic-event-track/index.md)关键帧：

   - 事件执行

     设置过场动画模式（Set Cinematic Mode）

     。
   - 目标（Target）

     连接到

     获取玩家控制器（Get Player Controller）

     ，后者再连接到

     获取玩家状态（Get Player State）

     。
   - 禁用

     处于过场动画模式（In Cinematic Mode）

     。
   - 同时启用

     影响移动（Affects Movement）

     和

     影响转弯（Affects Turning）

     。

现在，当播放过场动画时，玩家控制应该会在序列结束之前恢复。这有时可以为玩家提供更流畅、更自然的Gameplay体验。

> 动图已省略：1a9a4138070edc631d475fe741e17d11feb9db355a60c78a6062886299b0e119

### Gameplay摄像机方向

对于可自由移动以控制摄像机的游戏（例如第三人称模板中使用的摄像机），在混出时，Gameplay摄像机有时可能不会朝向所需的方向。

> 动图已省略：04e62f9255461844bd36cb2dd107d03a46d8af8f6ae55e7b7fed220c3382a314

可以使用 **获取玩家控制器（Get Player Controller）** 和 **设置控制旋转（Set Control Rotation）** 手动设置Gameplay摄像机的方向。

右键单击 **新旋转（New Rotation）** 引脚并选择 **拆分结构体引脚（Split Struct Pin）** 以查看所有可用的旋转轴并在节点上设置旋转值。对于此示例，创建以下逻辑：

- 在序列开始播放后执行

  设置控制旋转（Set Control Rotation）

  。
- 将

  新旋转Y（New Rotation Y）

  设置为

  -15

  ，以使摄像机略微向下俯视。
- 将

  新旋转Z（New Rotation Z）

  设置为

  -45

  ，以横向旋转摄像机并面向所需方向。

现在，当播放过场动画时，摄像机朝向所需方向混出。

> 动图已省略：56a4b85648cd7af0a83b36e29b02e6d12d2b1b0a7e802a4a1d13fdfebc0c1c95
