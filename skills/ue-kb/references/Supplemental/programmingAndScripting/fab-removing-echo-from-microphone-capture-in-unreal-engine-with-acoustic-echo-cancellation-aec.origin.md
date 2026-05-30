# 使用回声消除 (AEC) 消除虚幻引擎中麦克风捕获的回声

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/PeRZ/fab-removing-echo-from-microphone-capture-in-unreal-engine-with-acoustic-echo-cancellation-aec

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 7961 字符。

## 摘要

了解如何使用运行时音频导入器插件的回声消除 (AEC) 支持来消除虚幻引擎中扬声器播放引起的麦克风回声。本教程涵盖安装 WebRTC AEC3 扩展、在可捕获声波上启用 AEC、配置渲染声波以实现正确的帧传输，以及将所有内容绑定在一起以实现干净的实时语音捕获。

## 中文整理

### 概览

**注意：** 本教程需要 [运行时音频导入器](https://www.fab.com/listings/66e0d72e-982f-4d9e-aaaf-13a1d22efad1) 插件及其 Web RTC AEC3 扩展插件。有关全面的文档和高级功能，请参阅[完整文档](https://docs.georgy.dev/runtime-audio-importer/acoustic-echo-cancellation)。

### 介绍

在虚幻引擎中构建实时语音功能（例如语音聊天、语音命令或录音）时，会出现一个常见问题：麦克风拾取通过扬声器播放的音频，从而产生回声。这在用户不戴耳机的情况下尤其明显。 [运行时音频导入器](https://www.fab.com/listings/66e0d72e-982f-4d9e-aaaf-13a1d22efad1)插件在其[流媒体声音上支持**[回声消除 (AEC)](https://docs.georgy.dev/runtime-audio-importer/acoustic-echo-cancellation/)** Wave](https://docs.georgy.dev/runtime-audio-importer/sound-waves/streaming-sound-wave) 和 [可捕获声波](https://docs.georgy.dev/runtime-audio-importer/sound-waves/capturable-sound-wave) 类型。 AEC 的工作原理是对扬声器和麦克风之间的声学​​路径进行建模，然后从捕获的信号中减去回声，从而即使在背景中播放其他声音时也能产生干净的语音音频。在底层，它由 [WebRTC AEC3](https://webrtc.googlesource.com/src/) 提供支持，这是广泛的实时通信应用程序中使用的相同的高质量回声消除器。

### 先决条件

在开始之前，请确保您已： - 项目中安装了 **[运行时音频导入器](https://www.fab.com/listings/66e0d72e-982f-4d9e-aaaf-13a1d22efad1)** 插件 - 安装了 **WebRTC AEC3** 扩展插件（请参阅下面的安装） - C++ 项目，扩展需要 C++ 支持才能构建

### 安装

AEC 功能是通过轻量级扩展插件提供的，该插件仅提供相关的 AEC3 代码。要安装它： - 确保您的项目中已安装 **[Runtime Audio Importer](https://www.fab.com/listings/66e0d72e-982f-4d9e-aaaf-13a1d22efad1)** 插件 - 从以下位置下载 **WebRTC AEC3** 扩展插件**[此处](https://files.georgy.dev/Plugins/RuntimeAudioImporterWebRTCAEC3.zip)** - 将下载的存档中的文件夹解压到项目的 **Plugins** 文件夹中（如果不存在，则创建此文件夹） - 重建项目 该扩展支持 **Runtime Audio Importer** 支持的所有引擎版本：**UE 4.24-**UE 4.27 和任何 UE5 版本。如果您不熟悉手动构建插件，请参阅 Epic Games 开发者社区上的[构建插件教程](https://dev.epicgames.com/community/learning/tutorials/qz93/unreal-engine-building-plugins)。

### 它是如何运作的

在开始设置之前，有必要了解所涉及的两个音频流： - **捕获流** - 麦克风输入，由可捕获声波（或任何流式声波）表示。这是您要清理的信号。 - **渲染流** - 通过扬声器播放的音频，由导入的声波表示。这是引起回声的信号。 AEC 同时监听两个流，并从捕获信号中减去渲染音频，只留下用户的声音。

### 基本设置

该设置涉及三个步骤：在捕获声波上启用 AEC、配置渲染声波的块大小以及将它们绑定在一起。

### 第 1 步：在捕获声波上启用 AEC

创建可捕获声波后，调用 **Toggle AEC** 节点，传递 true 以启用它。您还需要指定 AEC 处理器的**采样率**和**通道数**。这些值会影响质量和性能，48000 Hz 会比 16000 Hz 产生更好的回声消除效果。如果传入的音频与这些值不匹配，它将自动重新采样，但选择与实际音频配置匹配的值可以避免不必要的开销。

支持的采样率为 **8000、16000、32000 和 48000 Hz**。您可以随时使用**是否已启用 AEC** 节点检查 AEC 当前是否处于活动状态。

### 第 2 步：配置渲染声波的块大小

WebRTC AEC3 以 **10 毫秒帧** 处理音频。为了确保渲染声波（通过扬声器播放的声波）以正确的帧大小提供音频数据，请对其调用 **Set Num Samples Per Chunk**。每个块的样本数计算如下： **每个块的样本数 = 采样率 ÷ 100** 例如，对于 48000 Hz 音频：48000 / 100 = 每块 480 个样本。

### 第三步：绑定渲染声波

最后，告诉捕获声波渲染声波用作回声参考。在您的可捕获声波上调用**将 AEC 绑定到声波播放**，传入正在通过扬声器播放的导入声波。

当您完成并想要停止回声消除时，您可以调用**Unbind AEC From Sound Wave Playback**。

### 附加配置

### 串流延迟

在某些情况下，渲染和捕获音频路径之间存在硬件或系统级延迟。您可以使用 **Set AEC Stream Delay** 节点手动指定此延迟（以毫秒为单位）。 WebRTC AEC3 可以在许多情况下自动估计这一点，因此这是可选的。

### 重置 AEC

如果您需要清除内部回声模型，例如在切换音频源或重新启动会话时，请使用 **重置 AEC** 节点。这会清除所有累积的状态并重新开始。

### 实际用例

### 语音聊天

AEC 对于通过扬声器向本地用户播放音频的任何语音聊天系统至关重要。如果没有它，远程参与者将听到自己的声音回响。在捕获本地麦克风的**[Capturable Sound Wave](https://docs.georgy.dev/runtime-audio-importer/sound-waves/capturable-sound-wave)**上启用AEC，将其绑定到播放远程参与者音频的声波，在信号传输之前自动消除回声。

### 语音命令

如果您的应用程序播放音频反馈（音效、TTS 响应、音乐），同时还监听语音命令，AEC 可确保您的语音识别系统仅接收用户的实际语音，而不是语音和播放音频的混合。与[运行时语音识别器](https://www.fab.com/listings/00ffc308-d7f9-4142-ac4c-4aeaa75ab54b)插件结合使用，以获得干净的语音命令管道。

### 像素流应用

如果您使用 [Pixel Streaming Audio Capture 扩展](https://docs.georgy.dev/runtime-audio-importer/pixel-streaming-audio-capture) 从 Pixel Streaming 客户端捕获麦克风音频，AEC 可以以完全相同的方式应用于捕获的音频，将其绑定到正在播放渲染音频的任何声波，并且回声消除可以透明地工作。

### 结论

运行时音频导入器中的 AEC 支持可以轻松构建专业品质的实时语音功能，而不会产生回声伪影。通过安装 **[WebRTC AEC3 扩展](https://docs.georgy.dev/runtime-audio-importer/acoustic-echo-cancellation)**，在可捕获声波上启用 AEC，并将其绑定到渲染声波，即使在通过扬声器播放音频的环境中，您也可以获得干净的麦克风捕获。有关完整的 API 文档和高级配置选项，请参阅[官方文档](https://docs.georgy.dev/runtime-audio-importer/acoustic-echo-cancellation)。如需其他帮助或自定义开发，请联系 [solutions@georgy.dev](mailto:solutions@georgy.dev) 或加入 [Discord 支持服务器](https://georgy.dev/discord)。
