# 虚幻引擎中正确的 TPS 音频监听器 | CN

# 虚幻引擎中正确的 TPS 音频监听器 | CN

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/4l3G/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 5358 字符。

## 摘要

虚幻引擎中正确的 TPS 音频监听器 为什么“Listener = Camera”会破坏第三人称音频 - 以及如何正确执行此操作

## 中文整理

### 虚幻引擎中正确的 TPS 音频监听器

**为什么“Listener = Camera”会破坏第三人称音频——以及如何正确地做到这一点**

### 问题

在第三人称游戏中，摄像机几乎总是偏离角色（肩部摄像机）。它还会因碰撞处理、缩放和过场动画而移动。如果您保留将**音频监听器放置在摄像机上**的默认设置，则您的“监听器”通常会**出现在**而不是角色实际所在的位置**。这通常会导致： - 3D/空间声音感觉偏移（就好像音频不是来自角色的空间） - 随着摄像机移动，方向和响度以奇怪的方式变化 - 在虚幻引擎中，通常从主音频侦听器位置（默认情况下是摄像机）评估遮挡 ⚠️ **重要说明：** 我在项目中对此进行了测试 - 即使使用 **衰减覆盖**，仍从 **音频侦听器** 评估遮挡，不是来自衰减覆盖点。因此，主要的修复是将**音频监听器位置**移动到角色的头部。

### 解决方案：正确的 TPS 方法

这个想法很简单： - 听者位置 = 头部（角色的头部） - 听者旋转 = CameraRotation 或 ControlRotation（视图/目标方向） - 可选：平滑以避免跳跃 - 如果头部插槽丢失，则可以安全回退 这为您提供： - 自然的“听觉点”（就好像玩家从角色的头部听到声音） - 能够使听者方向与摄像机视图或瞄准方向保持一致

![设置音频监听器和监听器覆盖](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-01.jpg)

![AudioListener_Bad_ENG](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-02.jpg)

![AudioListener_Fix_ENG](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-03.jpg)

![AudioListener_Corright_ENG](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-04.jpg)

### 它是如何运作的

这是一个 **Actor 组件**，您可以将其添加到您的角色（或任何您想要的演员）。它提供了一小组功能来管理“正确的 TPS”音频侦听器设置。

### 缓存引用

此函数缓存系统所需的关键引用： - 角色/Pawn - 骨架网格体（用于头部插槽） - 玩家控制器 - PlayerCameraManager （或您的自定义相机引用）

![缓存参考第 1 部分](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-05.jpg)

![缓存参考第 2 部分](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-06.jpg)

![缓存参考](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-07.jpg)

**重要（多人游戏）：** 仅在 **本地控制器** 上应用侦听器/衰减覆盖。否则，您可能会影响错误的 pawn 或远程玩家的音频。

### 获取HeadWorldPos

此函数返回角色的 **头部世界位置**： - 如果头部插槽存在 → 使用 GetSocketLocation(HeadSocketName) - 如果插槽丢失 → 回退到：ActorLocation + HeadFallbackOffset（矢量偏移，通常是 Z 上的粗略头部高度）

![(纯)获取头部世界位置+后备](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-08.jpg)

即使网格没有头部插槽或使用不同的骨架，这种后备也可以保持系统稳定。

### 选择听者位置、选择听者旋转、选择衰减位置

这是三个小的“选择器”功能。每个都使用 **enum** 来选择侦听器设置的特定部分的源： - 侦听器位置：摄像头或头部 - 侦听器旋转：CameraRotation 或 ControlRotation - 衰减位置：摄像头或头部

![Pure（选择音频收听者位置）](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-09.jpg)

![纯（选择音频侦听器旋转）](assets/epic-for-indies-correct-tps-audio-listener-in-unreal-engine-en/image-10.jpg)

目标是方便和清晰：您无需重新连接蓝图逻辑，只需切换枚举值即可为 TPS / ADS / 过场动画构建预设。

### 平滑监听器转换

这是一个可选的辅助函数，用于**平滑监听器变换**（位置/旋转）。它主要是为了解决两个实际问题： - 第一帧捕捉：在第一次更新时，它立即捕捉到目标，因此它不会从 (0,0,0) 或旧的/未初始化的值进行插值。 - 传送/切换安全：如果 pawn 传送或者您切换摄像机/监听器源，它可以捕捉而不是“缓慢追逐”新目标。在许多情况下，**无需平滑**就可以了，特别是如果你有一个稳定的摄像机并且没有硬传送。 **如何使用它：** - 首先，使用选择器逻辑构建目标值（侦听器 pos/rot 和衰减 pos）。 - 然后将这些目标输入 SmoothListenerTransforms。 - 最后，将平滑后的结果发送到ApplyListenerOverrides。 **如果你根本不需要平滑：**只需跳过此函数并将**Target**值直接传递到ApplyListenerOverrides中。这基本上是一个**包装函数** - 它不会添加新的逻辑，它只是使蓝图图表更清晰且更易于阅读。 **重要提示：**不要**为本系统中的侦听器使用*附加到组件*。附加将使行为不正确/不可预测，因为此设置希望您使用显式的世界空间目标（相机/头部/控制旋转）来驱动侦听器，而不是通过组件附加。还有两个主要入口点： - 初始化（设置 + 缓存引用） - 更新（计算目标 → 可选平滑 → 应用覆盖） 系统可以在 **Tick** 上运行，但如果您想要更便宜的更新率，它也可以与 **定时器** 配合使用。完成设置和连接逻辑后，您只需将此组件添加到您的 **Character**，在 **BeginPlay** 上从组件调用 **Initialize**，然后在 **Tick** 上或通过 **Timer** 调用 **Update**。一切都应该正常工作，并且您可以自由调整设置以匹配特定相机设置所需的结果。这并不意味着是一个完美的通用解决方案——我的目标主要是让声音设计师和其他开发人员清楚地了解**为什么正确的音频监听器放置很重要**、UE 的关键怪癖是什么以及哪里可能出现问题。我希望这可以帮助您理解该方法并在您自己的项目中使用它 - 因为当基础知识设置正确时，虚幻听起来会很棒。祝你好运！

