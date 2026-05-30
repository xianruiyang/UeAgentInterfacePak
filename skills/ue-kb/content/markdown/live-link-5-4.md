# Live Link 输入设备：在虚幻引擎 5.4 中使用游戏控制器进行性能捕捉的新方法

# Live Link 输入设备：在虚幻引擎 5.4 中使用游戏控制器进行性能捕捉的新方法

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/xpV1/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 2230 字符。

## 摘要

本教程介绍了新的 Live Link 输入设备插件以及如何将其与游戏控制器一起使用。

## 中文整理

### 概览

在虚幻引擎 5.4 中，有一种新的简单方法可以从游戏控制器创建 Live Link 数据流。该输入可以重新广播到网络上的其他计算机，或者保留在内部并以与附加任何外部 Live Link 数据流相同的方式使用。当在虚拟制作、LED 墙或现场活动中使用编辑器工作时，能够通过游戏控制器轻松添加交互是非常强大的。如果需要，可以通过 Take Recorder 记录该动作。首先，在插件窗口中启用插件“LiveLinkInputDevice”。

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-01-jpeg.jpg)

然后，打开“虚拟制作”下拉列表中的“实时链接”窗口。

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-02-jpeg.jpg)

引擎重新启动后，Live Link 窗口应该有一个新的“LiveLinkInputDevice”源可供添加。

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-03-jpeg.jpg)

假设游戏控制器已连接到计算机，添加此源将显示类型为“输入设备”的新主题。

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-04-jpeg.jpg)

可以通过编辑器中的任何蓝图访问此实时链接输入设备，方法是首先添加“实时链接组件控制器”并右键单击“添加事件 => 添加 OnLiveLinkUpdated”

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-05-jpeg.jpg)

这将创建一个事件，每次 Live Link 系统获取数据时都会在编辑器中触发该事件。允许您创建评估实时链接帧函数来读取数据。

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-06-jpeg.jpg)

通过“分解”“数据结果”和“数据结果帧数据”，人们可以看到正在传输的所有可能的游戏控制器通道。

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-07-jpeg.jpg)

在下面的示例中，左模拟 X 通道的值被打印到屏幕上。这些值一旦读取，就可以在蓝图中使用浮点数的任何地方使用。

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-08-jpeg.jpg)

在此示例中，控制器的模拟触发值被发送到动画蓝图，然后发送到控制装备以对角色手指应用旋转。

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-09-jpeg.jpg)

![教程图片](assets/live-link-input-device-a-new-way-to-use-game-controllers-for-performance-capture-in-unreal-engine-5-4/image-10-jpeg.jpg)

该数据不仅限于动画目的，还可以应用于材质参数集合以修改材质属性。注意：对于游戏情况，当“在编辑器中玩”创建 Tick 时，最好依赖增强输入系统。 https://dev.epicgames.com/documentation/en-us/unreal-engine/enhanced-input-in-unreal-engine?application_version=5.3

