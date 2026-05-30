# “我可以在没有音频中间件的情况下执行[空白]吗？”的常见问题解答

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/R8Bm/unreal-engine-faq-for-can-i-do-blank-without-audio-middleware

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 12583 字符。

## 摘要

在考虑是否使用 Unreal 的内置音频混合器时，人们经常会疑问 Unreal 有哪些功能，以及如何通过 Wwise 和 FMod 等中间件完成他们熟悉的行为……

## 中文整理

### 概览

在考虑是否使用 Unreal 的内置音频混合器时，人们经常会疑问 Unreal 具有哪些功能，以及如何通过 Unreal Engine 内的 Wwise 和 FMod 等中间件来实现他们熟悉的行为。

虽然 Unreal 的音频混合器和中间件并不相互排斥（请查看 [音频链接](https://dev.epicgames.com/community/learning/talks-and-demos/eXmE/unreal-engine-unreal-audio-engine-unreal-fest-2022-and-gamesoundcon-2022-summaries-and-faq)），但它们具有不同的架构和不同的优缺点。

为了帮助人们就哪些音频工具最适合他们的项目做出明智的决定，我们整理了一些最常见的“虚幻可以在中间件中做我熟悉的事情吗？”的答案和上下文。问题。

**我可以让声音在距离较远时更安静/在玩家左侧时偏向左耳/等等吗？** 是的 - 事实上，Unreal 默认情况下会这样做。

只需将声音拖到您的关卡中就足以使其正常工作。

如果您想要更多地控制声音的空间化方式，您想要的设置将位于[声音衰减资源](https://docs.unrealengine.com/4.27/en-US/WorkingWithAudio/DistanceModelAttenuation/)中。

这包括对衰减半径和曲线等内容的控制、用于传达声源相对于听众的位置的算法、遮挡行为、通过空气吸收进行过滤等。

可以为每个声音实例选择声音衰减资源，因此您可以在项目中以不同的方式对不同类型的声音进行空间化。

**HRTF 怎么样？** Unreal 没有 HRTF 作为开箱即用的空间化方法。

我们使用平移或双耳间时间延迟，具体取决于声音衰减的“空间化方法”设置。

也就是说，Unreal 附带了一些基于 HRTF 的第三方空间化插件：查看编辑器中“插件”下的“音频”选项卡。

**我可以进行复杂的音频事件吗？** 可以。

有时，游戏引擎因只允许基本波形文件播放而闻名，例如“根据此命令，读取此波形文件”。当然，在游戏音频中，实现通常比“事件发生 = 播放波形”更复杂。这可能会让习惯中间件的人感到紧张，因为使用 Unreal 会涉及大量重复实现、高级蓝图或 C++ 知识要求以及繁琐的迭代。

实际上，Unreal 通过 [MetaSounds](https://docs.unrealengine.com/5.0/en-US/metasounds-in-unreal-engine/) 和 [Sound Cues](https://docs.unrealengine.com/5.0/en-US/sound-cues-in-unreal-engine/) 等对象提供音频事件的封装。

如果您想随机或基于内部标志从多个波形文件中进行选择，同时播放多个相互关联的声音或连接多个声音以响应同一游戏事件，添加一些音调或音量的随机变化等，您可以在单个资源中执行此操作。

而且因为在游戏玩法方面，Unreal 被告知“播放该资产定义的音频事件”，因此您可以从根本上改变资产的行为，而无需更改任何游戏玩法挂钩。

**我可以将相关声音组合在一起吗？** 可以。

如果您正在寻找应具有相同设置的关联声音（即加载行为、默认子混合和音量调整等），[声音类](https://docs.unrealengine.com/5.0/en-US/sound-classes-in-unreal-engine/)是一个不错的选择。

声音类可让您立即更改所有分配的声源的设置，一旦您开始获取大量资源，这将非常有用。

如果您想一次性将音量变化或效果等应用到整组声音，[Submixes](https://docs.unrealengine.com/5.0/en-US/overview-of-submixes-in-unreal-engine/) 可能是最佳选择。

子混合将不同来源的音频混合在一起，允许您在混合音频的单个缓冲区而不是每个单独的来源上进行 DSP。

[调制系统](https://docs.unrealengine.com/4.27/en-US/WorkingWithAudio/AudioModulation/) 可用于对大量声音的参数进行细致入微、强大的更改。

调制可以直接用于声音类和子混音，以便通过 LFO、包络跟踪和调制补丁等方法对参数进行更高级的控制。

此外，相同的调制源可用于驱动单独音频对象上的多个参数，让您可以更精细地控制哪些声音应共享相同的参数。

**我可以对资源进行批量编辑吗？** 因为声音衰减资源和并发资源等设置是封装的，通过巧妙的分配，您只需更改它们之间共享的单个资源即可测试大量相关声音的行为变化。

但是，如果您想要一次性对大量音频资源进行更改，而超出了共享设置所能实现的范围，则可以使用 Unreal 的 [属性矩阵编辑器](https://docs.unrealengine.com/4.27/en-US/Basics/UI/PropertyMatrix/) 批量编辑和比较大量音频资源的设置。

**我可以在虚幻引擎中进行混合吗？** 可以，并且有几种不同的方法可以实现。

我们最强大的方法可能是我们的[调制系统](https://docs.unrealengine.com/5.0/en-US/overview-of-audio-modulation-in-unreal-engine/)，它通过混合分析提供快速迭代和测试，以及先进的技术，如侧链和类似 patch-bay 的路由行为。

如果您想同时影响大量相关声音的音量、音高或滤波器截止频率，您可以将调制应用到声音类。

您还可以使用 [Submixes](https://docs.unrealengine.com/5.0/en-US/submixes-in-unreal-engine/) 来实现此目的。

您可以将默认子混合分配给单个声源或整个声音类。

子混合还可以与调制系统配对，这样做可能会导致性能提升，因为它仅将输出音量和湿/干电平应用到单个混合音频缓冲区一次，而不是将其单独应用到多个单独的声源。

子混合也可以输入到其他子混合中，并且单个声源可以发送到多个子混合，从而允许更高级的混合技术。

**我可以在不重建所有内容的情况下更改音频吗？** MetaSounds 和 Sound Cues 等音频资源可以直接在各自的编辑器中预览。

如果您不想在玩游戏时听到音频，则可以在更改设置和移动声音对象时打开 RTA（实时音频）以在关卡编辑器中听到音频。

运行 PIE（在编辑器中播放）时，您可以在游戏实时运行时更改大多数音频资源的设置。

这可以包括更改混音、源效果参数、波形资源上的音高滑块等 - 当您更改资源上的参数时，您将立即在游戏中听到效果。

对于无法即时更改的设置，停止并重新启动“在编辑器中播放”就足以听到更改。

值得注意的是，在编辑器中启动 Play 不需要完全重建资源 - 进出 PIE 的转换通常只需几秒钟。

**我可以为我的声音添加效果吗？** 是的！

您可以通过[源效果](https://docs.unrealengine.com/5.0/en-US/audio-engine-overview-in-unreal-engine/)将效果直接应用于单个声音。

一般工作流程是创建源效果资源，并将其添加到源效果链资源中。

顾名思义，许多源效果可以添加到一个源效果链中 - 源效果在链中的顺序很重要，因为效果是从上到下按顺序处理的。

然后，源效果链可以附加到任何音频源，无论是声波、MetaSound、源总线等。

如果您想一次将效果应用于大量声音，[Submix Effects](https://docs.unrealengine.com/5.0/en-US/overview-of-submixes-in-unreal-engine/)可能会更好。

子混合效果将应用于已经混合的音频缓冲区，允许您通过单个 DSP 通道改变多个声源。

巧妙地使用子混音进行效果处理可以极大地提高性能。

**我可以进行高级语音管理吗？** 您可以 - 查看 [Concurrency](https://docs.unrealengine.com/5.0/en-US/audio-engine-overview-in-unreal-engine/) 资产。

这些可让您控制一次允许播放多少给定声音类型，以及达到限制时引擎应如何运行。

这可以帮助防止玩家被可能同时产生多个实例的声音淹没。

**我可以使用“当此声音结束时”之类的事件来触发非音频事件吗？** 可以。

音频组件具有常见事件的委托，例如“完成时”和“虚拟化更改时”，可以在蓝图中订阅这些事件。

为了使用更复杂的音频数据（例如音量或频率内容）驱动游戏，您可以使用 Envelope Followers 或 [Synesthesia](https://docs.unrealengine.com/5.0/en-US/audio-synesthesia-in-unreal-engine/) 等插件。

您甚至可以通过[音频引擎与我们的粒子效果系统 Niagara 的集成](https://docs.unrealengine.com/4.27/en-US/RenderingAndGraphics/Niagara/HowTo/AudioEffects/) 对音频数据进行高级可视化 - 例如，它内置了示波器和频谱分析仪。

**有工具可以帮助我调试音频吗？** Unreal 的音频引擎有大量的[控制台命令](https://docs.unrealengine.com/4.27/en-US/WorkingWithAudio/AudioConsoleCommands/)，用于分析音频引擎中发生的情况。

这可用于确认给定时间游戏中哪些声音资源处于活动状态、跟踪流缓存性能、可视化 3D 衰减曲线等。

同样，有许多控制台命令允许您执行诸如启用或禁用特定功能或隔离给定声音资产之类的操作，从而允许快速进行游戏内测试。

对于更详细的数据，您还可以使用诸如对单个声波应用烘焙 FFT 分析和幅度包络跟踪、对 [Submixes](https://docs.unrealengine.com/4.27/en-US/WorkingWithAudio/Submixes/) 进行实时频谱和包络分析以及记录各个 Submixes 的输出以进行播放和调试等技术。

**我可以使用音乐概念来安排事件吗？** [Quartz](https://docs.unrealengine.com/5.0/en-US/overview-of-quartz-in-unreal-engine/) 可以准确地采样安排音乐边界上的事件，例如给定 BPM 上的节拍和小节。

它最常用于安排播放命令，但它的委托也可用于触发节奏中的非音频事件。

**我可以在引擎中编辑波形吗？** 从 5.1 开始，现在有一个[波形编辑器](https://docs.unrealengine.com/5.1/en-US/waveform-editor-quick-start-in-unreal-engine/)。

这使您可以查看导入的声音资源的波形，并进行简单的更改，例如修剪文件的长度、更改淡入和淡出参数以及标准化音量。

这使您可以快速迭代波形更改，而无需在虚幻和外部软件之间切换。

**虚幻中的声音设计可以跨不同平台进行扩展吗？**虚幻有很多跨平台扩展音频的选项，这些平台可能具有非常不同的内存和性能需求，其中大部分可以在特定于平台的项目设置的“音频”选项卡中找到。

除此之外，您还可以更改采样率和回调缓冲区大小等参数、调整压缩质量和编解码器、更改语音管理限制、剔除更昂贵的 Sound Cue 分支等等。

这使您可以制作带有音频的游戏，这些游戏可以在从高端下一代游戏机到移动设备的任何地方发布，而无需为每个平台重新实现声音设计。

**TL;DR** 许多 AAA 游戏都使用虚幻的内置音频，包括我们内部制作的许多游戏和演示。

它是一个完整的音频引擎，旨在使其成为在虚幻中创建高质量游戏而不依赖外部软件的选项。

希望这有助于评估基础虚幻引擎已提供哪些音频功能。
