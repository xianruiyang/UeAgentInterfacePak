# Audio Engine Overview

---
title: "Audio Engine Overview"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/audio-engine-overview-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "虚幻引擎中的音频", "Audio Engine Overview"]
---

# Audio Engine Overview

> 路径：虚幻引擎5.7文档 / 处理音频 / 虚幻引擎中的音频 / Audio Engine Overview

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/audio-engine-overview-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

该 **Unreal Audio Engine（虚幻音频引擎）** 是一个健壮的 audio engine，在 Unreal Engine 支持的所有平台上提供广泛功能。 **Unreal Engine**.

结合 Blueprint 的能力以及新的多平台 [audio mixer（音频混音器）](../audio-mixer-overview/index.md) ，该 mixer 支持 audio digital-signal-processing（数字信号处理）（DSP）、procedural synthesis、可定制 submix graph 和灵活的 C++ API，使音频引擎能够在任意规模项目中交付高质量音频。

本概览简要介绍用于解决高层音频问题的多个 subsystem 与 feature。

## Source Asset Management（源资产管理）

整体资产管理较直接。资产管理的指导原则是尽可能直接地完成操作，并在可行时自动处理。

### Importing Assets（导入资产）

Unreal Engine 支持通过文件导入对话框，或直接把 audio asset 拖入 Content Browser，从桌面直接导入音频资产。

可以导入多种 asset type 和 channel format（参见 [Importing Audio Files（导入音频文件）](../../sound-source/sound-waves/importing-audio-files/index.md)).

在内部，Unreal Engine 会以 16-bit、未压缩的 `.wav` format 存储导入的音频文件。

包含导入数据的 `UAsset` 称为 `USoundWave`，可以直接通过所有 Unreal Engine audio gameplay API 播放。导入资产也可在 Content Browser 中预览：点击资产上的 Play 按钮，或在选中资产时按空格键。

当 audio asset 导入到 Content Browser 时，引擎会以 16-bit、未压缩的 .wav 格式存储它。

## Asset Management Tools（资产管理工具）

除了组织良好的 Content Browser 文件夹结构、设计合理的 bookmark 和通用 Content Browser 工具之外，audio asset 尤其能从 **Property Matrix（属性矩阵）** 工具中显著受益。若要在 Unreal Engine 中批量编辑 audio asset，请选择要编辑的资产，然后打开 Property Matrix 工具；它可以一次性对多达数百个资产进行大范围调整。

Property Matrix 工具可用于同时对多个资产进行大范围修改。

## Sound Cues（声音提示）

在 Unreal Audio Engine 中，把多个 sound asset 概念性聚合成抽象 Sound Object 的资产是 **Sound Cue（声音提示）**。它并不等同于声音本身，而是 *该声音的抽象概念。*.

Sound Cue 会在运行时求值，也就是说，它是一组“潜在声音”，而不是固定的实际声音。每次播放 Sound Cue 时，结果都可能因使用上下文而不同。

Sound Cue 是 Unreal Engine 中最早期的工具之一。Sound Cue Editor 让 sound designer 可以创建自己的 sound-design topology，把简单的播放声音事件转换为任意复杂且细致的声音设计事件。

从高层看，Sound Cue 支持 asset randomization、gameplay 驱动的 parameter mapping、用于 distance attenuation 的 custom logic 和 branching、volume attenuation、pitch shifting，以及大量其他功能。

Sound Cue Editor 提供一种方式，可将简单的播放声音事件转换为复杂、细致的声音设计事件。

Sound Cue 也可以使用 **Sound Cue Templates（声音提示模板）** plugin 构建。该插件提供简单的 C++ interface，sound designer 可用它命名特定 sound cue、graph topology 和逻辑，并让它们从 Matrix Property Editor 与 Content Browser 中自动构建和使用。通过这种方式，可以定义通用 Sound Cue graph，并用它优化工作流。

请参阅 [Sound Cue Editor（声音提示编辑器）](../../sound-source/sound-cue/sound-cue-editor/index.md) 了解更多信息。

## Spatialization and Attenuation（空间化与衰减）

游戏中的 spatialization 和 attenuation 很重要。在 Unreal Audio Engine 中，可以定义自定义 spatialization 与 attenuation 行为。

自定义 spatialization 与 attenuation 可以通过多种方式实现。

通常，sound 与 attenuation setting 使用 **Sound Attenuation Settings（声音衰减设置）** 资产定义，并由 *关联* 到声音上。sound attenuation 可以在多个位置关联：

- 直接在 sound asset 上
- 在 Sound Cue 内
- 在 Blueprint 中覆盖

更多信息请参阅 [Sound Attenuation（声音衰减）](../../spatialization-and-sound-attenuation/sound-attenuation/index.md).

### Non-Spatialized Sounds（非空间化声音）

非空间化声音在 audio engine 语境中通常称为 **2D sounds（2D 声音）** 。Unreal Audio 可通过在声音的 attenuation setting asset 中禁用 spatialization，或不提供 sound attenuation asset，来播放 2D asset。这类 2D sound 适合音乐、UI feedback 声音，以及其他 listener 位置固定的场景。

即使 sound asset 播放时没有使用特殊 spatialization method，该资产本身也可以包含已烘焙进去的空间信息。

- **Multichannel sound sources（多声道声源）** （例如 quad、5.1 和 7.1 sound source）仅支持 2D 播放，通常用于音乐或环境铺底。
- **Stereo sound sources（立体声声源）** 可以按 2D 播放，也可以进行 spatialization。

### Spatialized Sounds（空间化声音）

默认情况下，当 attenuation settings 启用 spatialization 时，声音会使用 panning 进行空间化。

**Panning（声像移动）** 是根据声音相对于 listener 朝向的角度，改变物理输出扬声器声道中声音 amplitude 的过程。

Unreal Audio 支持多种 output configuration 的 panning：stereo、5.1 和 7.1，并支持 mono 与 stereo source asset。

对于 stereo asset，stereo-spread 参数会定义声源左右 input channel 之间的虚拟距离。这样，stereo source 的左右声道会类似 mono source 一样相对于 listener 进行 panning。

There are two **global panning modes（全局声像模式）** 可供 sound designer 在项目中配置使用：linear panning 和 equal-power panning。

- **Linear panning（线性声像）** 会在 output channel 之间执行简单的线性 crossfade。
- **Equal-power panning（等功率声像）** 会在 output channel 之间保持 power（amplitude 的平方）。

由于音量感知基于声音 power，panning 时保持 equal power 会带来感知上更稳定的音量变化。linear panning 会让声音越接近物理扬声器位置越响，位于扬声器之间时更安静。

Unreal Audio 还通过稳健灵活的 C++ API 支持使用 third-party plugin 进行 spatialization。第三方插件可以按自身方式对声音进行空间化，包括 binaural/HRTF spatialization 或 ambisonics（soundfield）编码与解码。插件也可以提供自己的 asset setting，并将其关联到 attenuation setting asset。

### Distance Attenuation（距离衰减）

**Distance-based sound attenuation（基于距离的声音衰减）** 也在 Sound Attenuation Settings asset 中定义。除了提供多个预设 function 和 shape 用于 distance-based sound attenuation，sound designer 还可以设计自己的 custom distance-attenuation curve。

### Spatialization/Attenuation Orthogonality（空间化/衰减正交性）

Unreal Audio spatialization 与 attenuation 功能有一个细微点：它们被视为正交属性。这意味着 sound designer 可以独立于 spatialization，按距离（或 source-listener 朝向）衰减声音，反之亦然。

Spatialization 与 attenuation setting 定义在 Sound Attenuation Settings asset 上。

在此图中，当 listener 位于 non-spatialized radius（绿色球体表示）内时，声音会渗入 speaker configuration 的所有 channel。超出该半径后，声音会按常规方式 spatialize。

### Distance Filtering（距离滤波）

Sound Attenuation setting 还提供按距离对声音进行 filtering 的选项。low-pass 与 high-pass filter 的独立 curve 让 sound designer 可以模拟空气吸收效果（low-pass filter），或建模频率相关的 distance attenuation（high-pass filter）。

### Occlusion（遮挡）

Unreal Audio 提供开销极低的默认 async trace，用于对声音执行 occlusion check。sound attenuation setting 提供选项，让 sound designer 启用 occlusion，并根据声音是否 [occluded（被遮挡）](../../spatialization-and-sound-attenuation/sound-attenuation/index.md)来设置多种 filtering 参数。更高级的 occlusion 方案可由第三方插件通过 Unreal Audio 的 Occlusion C++ API 实现。

### Listener-Based Attenuation（基于 Listener 的衰减）

Sound Attenuation setting 还提供一个选项，让 sound designer 可根据声音相对于 listener 的朝向编写 volume attenuation、prioritization scaling 和其他效果。这样，当声音进入 listener 视野时，可以变得更“in-focus”或“out-of-focus”。

更多信息请参阅 [Attenuation and Listener Focus（衰减与 Listener 焦点）](../../spatialization-and-sound-attenuation/sound-attenuation/index.md).

### Distance-Based Reverb Sends（基于距离的混响发送）

Unreal Audio 还支持按距离改变发送到 master reverb submix 的音频量。此映射的定义方式类似其他基于距离的 parameter curve。

更多信息请参阅 [Attenuation Reverb Send（衰减混响发送）](../../spatialization-and-sound-attenuation/sound-attenuation/index.md).

## Gameplay Audio API（玩法音频 API）

Unreal Audio 提供简单且灵活的 gameplay API，允许 Blueprint 与 C++ 代码自定义音频引擎行为。

### PlaySound 与 SpawnSound Blueprint API

可以使用多种 Blueprint function 从 Blueprint 和 gameplay C++ code 播放声音，大致分为两类：

- **PlaySound function：** 包括 PlaySoundAtLocation、PlaySound2D、PlayDialogue2D 等。
- **SpawnSound function：** 包括 SpawnSoundAtLocation、SpawnSound2D 和 SpawnSoundAttached。
- **PlaySound API：** 这些 API 会以 fire-and-forget 模式播放指定声音。声音开始播放后，无法从 Blueprint 修改其 playback，也无法将其附加到对象。这种播放类型适合不需要动态控制的简单 one-shot 声音。
- **SpawnSound function：** 可以创建 audio component，动态控制声音参数、把声音附加到其他 actor，并控制 looping sound。Audio component 是 Unreal Engine 中处理声音的有用对象，可用于构建复杂的交互式 Blueprint 音频系统。

大多数 Unreal Engine audio system 都有关联的 Blueprint API，可从 Blueprint 中进行自定义和控制。例如，每个 source 与 submix DSP effect 都可从 Blueprint 修改和控制，sound mix 与 sound class 也同样可以。

## Game Volume Mixing（游戏音量混音）

game mixing 是 game audio 中更具挑战性的方面之一。Unreal Audio 提供多种功能，供 sound designer 定义和控制 game mix。影响整体 volume mix 的因素很多。

### Direct Volume Adjustments（直接音量调整）

单个资产（如 Sound Cue 和 Sound Wave）具有用于 volume control 的参数。Audio component 也允许从 Blueprint 修改 sound volume。PlaySound 与 SpawnSound audio gameplay API 可在播放时选择音量。Sound Cue 可以根据动态 gameplay parameter 或其他 Sound Cue graph logic 修改声音音量。资产音量也可以通过多种 distance attenuation 选项设置，包括基于 listener 朝向的 attenuation。

### Sound Classes（声音类别）

Sound Class 是一种资产，为具有相同语义含义的资产提供一组通用设置。把声音归入共同分类的主要动机之一，是作为一个组控制这些声音的音量。 [Sound Classes（声音类别）](../../audio-mixing/sound-classes/index.md) 会在单独的 Sound Class graph editor 中创建和修改。除了 volume 之外， Sound Classes（声音类别） 还可用于控制 class group 中声音的其他参数。

### Sound Mixes（声音混音）

Sound Mix 是一种 asset type，可向 Sound Class 应用动态 Sound Class volume 与 pitch adjuster。Sound Mix 是游戏中执行基于 Class 的 volume control 的传统方法，包括 ducking。

**Volume ducking（音量闪避）**通过 Passive Mix Modifier 实现；这是一种在给定 Sound Class 上播放声音时，间接应用 mix 的机制。这样，例如当玩家说话或枪械开火时，游戏可以让背景环境音发生 ducking。

### Sound Parameter Modulation（声音参数调制）

控制 game mix 的较新方法是使用 audio **Parameter Modulation（参数调制）** plugin。该插件泛化了通过 mix 改变 audio parameter 的概念。现在声音可以把自身参数关联为 parameter bus 的 **modulation destinations（调制目标）**。**parameter bus（参数总线）** 是一种对象，允许任意 parameter modulation source 写入 bus。例如，modulation source 可以来自 Blueprint、由 parameter mix 派生、来自某个交互系统，或来自 LFO 等 parameter modulation oscillator。

Parameter Modulation plugin 不只控制声音的 volume parameter，它还泛化了 parameter modulation 概念，允许同一范式控制任意数量的 output parameter（例如 filter frequency cutoff 和 pitch modulation）。

更多信息请参阅 [Audio Modulation Overview（音频调制概览）](../../audio-mixing/audio-modulation/index.md).

## Concurrency Management（并发管理）

game mixing 中常被忽略的一点是管理 **sound concurrency（声音并发）**，本质上就是某一类型的声音能同时播放多少个。如果不仔细管理，游戏很容易生成大量同类型声音，例如枪械声和其他敌方武器声。

Unreal Audio Engine 提供工具，让 sound designer 通过 Sound Concurrency Asset 控制 concurrency group。该资产定义组内允许多少声音，以及达到限制后应执行什么操作。

Sound concurrency 是管理特定类型声音可同时播放数量的方式。

例如，sound designer 可以选择在新声音进入时停止最旧的声音；也可以拒绝新声音，继续播放已有声音。

Sound Concurrency 还允许 group 形成链式结构，其中一层 **Concurrency Resolution（并发解析）** hierarchy 必须通过，声音才能播放。

例如，脚步声可能位于一个 concurrency 中，用于限制脚步声总数。该 concurrency 又可能位于 Foley 声音的 concurrency group 中，再进一步位于 SFX 声音的 concurrency group 中，以此类推。

更多信息请参阅 [Make Sound Concurrency Settings（制作声音并发设置）](https://dev.epicgames.com/documentation/unreal-engine/BlueprintAPI/Utilities/Struct/MakeSoundConcurrencySettings?application_version=5.5).

### Global Polyphony/Management/Prioritization（全局复音管理与优先级）（全局复音管理与优先级）

管理游戏中可同时播放的声音数量称为 **polyphony management（复音管理）** 或 **voice management（声部管理）**。audio engine 的主要成本是解码和渲染 sound source，因此降低 CPU 成本的主要工具之一是限制可同时播放的声音数量。

在 Unreal Engine 中，此数量通过项目设置指定，并可根据目标平台更改。该数量也可以在游戏运行时动态改变，因此在性能受限或紧张的情况下，音频引擎可以动态减少需要渲染的 sound source 数量。

当 audio engine 达到可渲染声音数量上限后，需要决定哪些声音播放，哪些声音拒绝或停止。这会结合 sound 的 total volume（考虑所有阶段后的最终音量）和 sound priority 完成。更多信息请参阅 [Priority（优先级）](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Sound/USoundBase/Priority?application_version=5.5).

## DSP Effects and Synthesis（DSP 效果与合成）

Unreal Audio Engine 还具有稳健的 **digital-signal-processing（数字信号处理）（DSP，数字信号处理）** effects processing pipeline。

单个 sound source 可以指定要应用到各个 source instance 的 DSP effect chain。这些 effect 的设置可以在运行时通过 Blueprint 更改，并支持在 Play in Editor（PIE）session 运行期间实时预览变化。

Unreal Audio 还提供 Submix Graph Editor，让 sound designer 可以对 sound source 的 mix 应用 DSP effect 并执行分析。可以在 submix effect chain 中构建 submix effect。sound source 可指定在任意给定 submix 上播放，并将其音频 *send（发送）* 作为 **send effects（发送效果）** 发送到任何其他 submix graph。任意 sound source 都可以从 Blueprint 动态地把 audio route 到任意 submix。此外，Sound Attenuation Settings 支持按距离把 audio 发送到 submix effect，可用组合非常多。

Unreal Audio Engine 足够灵活，既允许 Master EQ、Master Compression 和 Master Reverb 等典型 master-effect 设置，也支持探索更自定义的 DSP graph 和 routing scheme。

Synthesis and DSP Effects plugin 已实现多种 source 与 submix effect，并且还在持续添加新 effect。随着 Signal Processing Module 中 DSP C++ library 的扩展，可以很容易通过 Unreal Audio Engine 的 DSP and Synthesis C++ API 添加新效果。

结合 Unreal Engine 中 automatic property reflection 与 hot-loading DLL 等其他稳健工具和技术，Unreal Audio Engine 是学习编写 DSP effect 的理想场所，也可作为 game audio technology 前沿实验与研究的平台。

## Asset Cooking（资产 Cook）

为目标平台 cook 时，资产会使用同时匹配目标平台和声音所用功能的 codec 进行压缩。例如，在支持的平台上，Unreal Engine 会自动编码为 hardware-accelerated codec。

包装导入资产的 `USoundWave` 带有 quality slider，用于让 cook-time compression scheme 匹配 sound designer 为该资产设定的质量目标。该 quality value 会根据目标平台使用的具体 codec 以不同方式解释。

### Asset Compression Overrides：Automatic Quality Reduction（资产压缩覆盖：自动质量降低）

Unreal Engine 提供多种工具，让 sound designer 和 engineer 控制任意目标平台上的自动 cook-time down-sampling 与 quality scale reduction。这样项目可以尽可能发布到更多平台，同时尽量减少特定平台内容重做。

例如，一个发布到 PC 的项目在面向移动平台时，可以自动降低资产内存占用。

## Debugging and Profiling（调试与分析）

Unreal Audio Engine 与 Unreal Engine 其余部分完全集成，因此可受益于用于分析 CPU 使用率和内存的所有现有 profiling tool。引擎中还加入了对 **LLM（low level memory）tracking** 的 hook，以及 **CSV CPU profiling（CSV CPU 分析）**。此外， [Unreal Insights tool（虚幻洞察工具）](../../../testing-and-optimizing-content/unreal-insights/index.md) 可以访问全部 audio CPU usage。

除了所有 Unreal Engine developer 都可使用的综合 CPU 与 memory profiling 外，还有多种 debugging tool 可用于查看和分析游戏内实时发生的 audio event。例如：

- 要查看所有正在播放的 Sound Wave instance（正在主动生成声音的对象），请输入 **stat soundwave** 到 dev console window 中。
- 要查看正在播放的 Sound Cue，请输入 **stat soundcues** 到 console window 中。
- 要可视化游戏中正在播放的 3D sound，请输入 **Audio3DVisualize** 到 console window 中。

还有多种 console variable 可切换，用于启用或禁用音频引擎的不同 component、启用 mute 和 solo 等。请参阅 [FAudioDevice](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/FAudioDevice?application_version=5.5) 了解更多调试信息。

