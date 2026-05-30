# 在虚幻引擎 (VAD) 中检测麦克风的语音活动

# 在虚幻引擎 (VAD) 中检测麦克风的语音活动

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/eGwZ/fab-detecting-voice-activity-from-microphone-in-unreal-engine-vad

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 9708 字符。

## 摘要

了解如何使用运行时音频导入器插件在虚幻引擎中设置语音活动检测 (VAD)。本教程涵盖在可捕获声波上启用 VAD、在内置 libfvad 和基于神经网络的 Silero VAD 扩展之间进行选择、配置语音开始和结束检测以及绑定事件以实时响应语音活动。

## 中文整理

### 概览

**注意：** 本教程需要 [运行时音频导入器](https://www.fab.com/listings/66e0d72e-982f-4d9e-aaaf-13a1d22efad1) 插件和 libfvad 或 Silero VAD 扩展插件。有关全面的文档和高级功能，请参阅[完整文档](https://docs.georgy.dev/runtime-audio-importer/voice-activity-detection)。

### 介绍

在虚幻引擎中捕获麦克风音频时，无论是用于语音聊天、语音命令还是录音，了解用户何时实际说话通常比连续处理静音非常有用。 [运行时音频导入器](https://www.fab.com/listings/66e0d72e-982f-4d9e-aaaf-13a1d22efad1)插件在其[流声音Wave](https://docs.georgy.dev/runtime-audio-importer/sound-waves/streaming-sound-wave) 和 [可捕获声波](https://docs.georgy.dev/runtime-audio-importer/sound-waves/capturable-sound-wave) 类型。启用后，VAD 会过滤传入的音频，以便仅在检测到语音时填充内部缓冲区，从而减少不必要的处理，并使构建响应式语音驱动功能变得更加容易。该插件提供两种 VAD 实现： - **默认 VAD** - 基于 [libfvad](https://github.com/dpirch/libfvad)，这是一个轻量级库，可以在运行时音频导入器支持的所有平台和引擎版本上高效工作。无需额外安装。 - **Silero VAD** - 基于神经网络的检测器，可作为[扩展插件](https://files.georgy.dev/Plugins/RuntimeAudioImporterSileroVAD.zip)。它提供了更高的精度，特别是在嘈杂的环境中，但代价是额外的计算资源。

### 先决条件

在开始之前，请确保您的项目中安装了 [运行时音频导入器](https://www.fab.com/listings/66e0d72e-982f-4d9e-aaaf-13a1d22efad1) 插件。默认 VAD 开箱即用，无需额外设置。如果您想使用 Silero VAD，您还需要一个 C++ 项目和下面介绍的一些额外安装步骤。

### 基本设置

### 启用什么

创建可捕获声波（或任何流式声波）后，调用 **Toggle VAD** 节点并传递 true 以启用它。

![切换“什么”节点](assets/fab-detecting-voice-activity-from-microphone-in-unreal-engine-vad/image-01.jpg)

您可以随时重置 VAD 状态，例如，在重新启动录制会话时，使用 **重置 VAD** 节点。

![重置VAD节点](assets/fab-detecting-voice-activity-from-microphone-in-unreal-engine-vad/image-02.jpg)

### 调整攻击强度（仅默认 VAD）

使用默认 VAD 提供程序时，您可以使用 **设置 VAD 模式** 节点来控制其过滤音频的积极程度。较高的攻击性意味着检测器的限制性更强，报告误报的可能性较小，但有时可能会错过较安静的语音。较低的值更宽松。

![设置VAD模式节点](assets/fab-detecting-voice-activity-from-microphone-in-unreal-engine-vad/image-03.jpg)

### 什么供应商

默认情况下，VAD 使用内置的 libfvad 提供程序。如果您需要更高的精度，可以在使用 **Toggle VAD** 节点启用 VAD 后切换到 Silero VAD。要切换提供程序，请使用 **设置 VAD 提供程序** 节点并选择所需的提供程序类。

![设置VAD提供商节点](assets/fab-detecting-voice-activity-from-microphone-in-unreal-engine-vad/image-04.jpg)

### Silero VAD 扩展

Silero VAD 使用神经网络更可靠地区分语音和背景噪音，使其成为默认 VAD 难以应对的环境的更好选择。要安装它： - 确保您的项目中已安装 **[Runtime Audio Importer](https://www.fab.com/listings/66e0d72e-982f-4d9e-aaaf-13a1d22efad1)** 插件 - **仅限 UE 5.5 及更早版本**：在继续之前，请确保在您的项目中禁用 NNERuntimeORT 插件。在这些引擎版本上启用它可能会因冲突而导致崩溃。特别是在 UE 5.3 中，还必须禁用 NNERuntimeORTCpu 和 NNERuntimeORTGpu - 从 **[此处](https://files.georgy.dev/Plugins/RuntimeAudioImporterSileroVAD.zip)** 下载 Silero VAD 扩展插件 - 将下载的存档中的文件夹提取到项目的 **Plugins** 文件夹中（如果不存在则创建此文件夹） - 仅适用于 UE 5.6 及更高版本：打开 **RuntimeAudioImporterSileroVAD.uplugin** 文件，并在 RuntimeAudioImporter 条目之后的“插件”字段中手动添加 **NNERuntimeORT** 依赖项 - 重新构建项目 Silero VAD 支持 Windows、Linux、Mac、Android（包括 Meta Quest）和 iOS，并且需要 **UE 4.27** 或任何 **UE5** 版本。如果您不熟悉手动构建插件，请参阅[构建插件教程](https://dev.epicgames.com/community/learning/tutorials/qz93/unreal-engine-building-plugins)。安装后，使用带有 Silero 提供程序类的 **Set VAD Provider** 节点将其选择为您的提供程序。

### 选择提供商

以下是一个快速概述，可帮助您确定哪个提供商适合您的用例： **默认 VAD (libfvad)** - 轻量级，无需额外安装 - 适用于运行时音频导入器支持的所有平台和所有引擎版本 - 非常适合安静环境、移动应用程序和性能优先的项目 **Silero VAD** - 更高的精度和更好的噪声容限 - 非常适合嘈杂的环境、语音识别系统以及检测可靠性比资源使用更重要的应用程序 - 需要 UE 4.27+ 和 C++ 项目

### 语音开始和结束检测

除了过滤音频之外，VAD 还可以让您检测语音开始和结束的精确时刻。这对于触发事件非常有用，例如，仅当用户开始说话时才启动语音识别请求，或者当用户静音时停止录音。

### 最短演讲时间

为了避免对非实际语音的短暂噪音做出反应，您可以设置 **最小语音持续时间**，即触发语音开始事件之前所需的连续语音活动量。默认值为 **300 毫秒**。

### 选择提供商

### 语音开始和结束检测

### 最短演讲时间

![设置最短语音持续时间节点](assets/fab-detecting-voice-activity-from-microphone-in-unreal-engine-vad/image-05.jpg)

### 沉默时间

为了避免在单词之间的自然停顿期间过早结束语音事件，您可以设置 **静音持续时间**，即在触发语音结束事件之前必须持续静音多长时间。默认值为 **500 毫秒**。

![设置静音持续时间节点](assets/fab-detecting-voice-activity-from-microphone-in-unreal-engine-vad/image-06.jpg)

### 绑定到语音事件

您可以使用 **Bind Event to On Speech Started** 和 **Bind Event to On Speech Ended** 节点直接绑定到在语音开始或结束时触发的事件。这些可让您触发任何自定义逻辑、启动计时器、启用录音指示器、将音频发送到语音识别器等。

![将事件绑定到“语音启动”节点](assets/fab-detecting-voice-activity-from-microphone-in-unreal-engine-vad/image-07.jpg)

![将事件绑定到语音结束节点](assets/fab-detecting-voice-activity-from-microphone-in-unreal-engine-vad/image-08.jpg)

### 实际用例

### 语音命令

在可捕获声波上启用 VAD 并绑定到语音开始/结束事件，以准确了解何时将音频发送到 [运行时语音识别器](https://www.fab.com/listings/00ffc308-d7f9-4142-ac4c-4aeaa75ab54b) 插件进行转录。这可以避免发送静音或背景噪音，并使识别更快、更准确。

### 语音聊天

使用 VAD 检测用户何时说话，然后再将其音频传输给其他播放器。这会减少带宽并避免广播连续静音或环境噪音，类似于一键通但全自动。

### 记录

录制用户音频时，VAD 可让您跳过无声间隙，仅捕获实际包含语音的片段，从而获得更干净的录音，而不会在开始或结束时出现长时间的无声。

### 像素流

与 [像素流音频捕获扩展](https://docs.georgy.dev/runtime-audio-importer/pixel-streaming-audio-capture) 一起使用时，VAD 的工作方式相同，允许您检测来自基于浏览器的远程客户端的语音活动，就像使用本地麦克风一样。

### 结论

运行时音频导入器中的语音活动检测为您提供了一种简单的方法来检测用户何时说话并做出相应反应，无论您是在构建语音命令、语音聊天还是录音功能。默认提供程序以最少的设置覆盖大多数用例，当您在具有挑战性的环境中需要更高的准确性时，可以使用 [Silero VAD](https://docs.georgy.dev/runtime-audio-importer/voice-activity-detection#silero-vad-extension)。有关完整的 API 文档，请参阅[官方文档](https://docs.georgy.dev/runtime-audio-importer/voice-activity-detection)。如需其他帮助或自定义开发，请联系 [solutions@georgy.dev](mailto:solutions@georgy.dev) 或加入 [Discord 支持服务器](https://georgy.dev/discord)。[完整文档](https://docs.georgy.dev/runtime-audio-importer/voice-activity-detection)

