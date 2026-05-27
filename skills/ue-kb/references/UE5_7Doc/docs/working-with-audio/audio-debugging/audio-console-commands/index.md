---
title: "音频控制台命令"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/audio-console-commands-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "音频调试", "音频控制台命令"]
---

# 音频控制台命令

> 路径：虚幻引擎5.7文档 / 处理音频 / 音频调试 / 音频控制台命令

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/audio-console-commands-in-unreal-engine

在虚幻引擎中调试游戏或其他项目时，趁游戏或编辑器在运行时直接向其发送命令可有助于调试。对于音频来说尤其如此。如果你要追踪的漏洞仅在狭窄或未知环境中出现，控制台命令可以提供帮助，比如启用或禁用特定功能、实时更改重要参数。

## 如何使用控制台

默认情况下， **命令控制台（Command Console）** 在底部工具栏中，位于虚幻编辑器窗口的底部。在键盘上按 **波浪号** 键（ **~** ），可以直接跳到命令控制台条目字段。注意，英式英语键盘上使用的键是 **沉音符** 键( **`** )。

![底部工具栏中的命令控制台](../../../../assets/images/9b/9b3607c2bc75923b3d586413fc2e0e49e5e8220c43868afc122ff44b5577e087.png)

> [!NOTE]
> 如果波浪号键打不开控制台，或想要使用不同的键，可以转到 **项目设置（Project Settings）> 引擎（Engine）>输入（Input）>控制台键（Console Keys）** ，更改键盘绑定。

使用控制台命令时，可能还需要打开 **输出日志（Output Log）** 。点击位于命令控制台（Command Console）左侧的快捷键。按 **波浪号** 键（ **~** ）两次，将打开输出日志侧滑菜单。可在 **窗口（Window）> 输出日志（Output Log）** 进行设置。

大部分音频控制台命令涉及通过语法 `<CVar> <Value>` 将给定的 **控制台变量** （ **CVar** ）设置为所需值。

例如，要调试混音，可以在控制台中使用命令 `au.Debug.SoundMixes 1`（其中 `1`=true），将 CVar `au.Debug.SoundMixes` 设置为 **true** 。

你还可以通过输入命令 `<CVar> ?` 或使用 `help` 命令找到关于使用给定CVar的更多信息。

输入到控制台的命令会实时影响你的编辑器。控制台命令可以从游戏中执行，可以在编辑器中执行，还可以在游戏已经启动的情况下，从服务器控制台中使用服务器开关执行。

## 常用命令和用法

音频特定控制台命令和变量以 `au.` 开头，少数旧函数除外。由于控制台支持自我暗示功能，你可以在控制台中键入 `au.` 并滚动查看列示的命令，获取可用命令列表。

- `au.Debug.SoundMixes` - 设置为 **1** 时，此变量提供有关当前活动音效类混音的信息。由于混音是可以同时影响关卡中多个音效的对象，因此很难追踪它们的问题。通过显示有关混音的信息，可以轻松判断是否触发了任何意外的混音，混音是否未按预期推送并弹出混音调节器列表，或者同一混音的多个实例是否同时处于活动状态。对于尝试调试突然听不到某个类别的音效这类情况，这通常是重要的第一步。
- `au.DumpActiveSounds` - 设置为 `1` 时，此变量提供当前正在播放的所有音效列表。对于人耳听起来相同，但原因不同的问题，你可以使用此变量缩小可能的错误来源范围。例如，如果无法听到音效，转储活动音效有助于弄清楚是音效未播放，还是音效在以听不到的低音量播放。同样，该变量可以帮助区分将音量调节器设置为不合理的音量，而由此产生的响亮音效，和由于同一音效的多个实例同时播放而产生的响亮音效，后者可能会让你觉得是一个非常响亮的音效。
- `au.Debug.AudioMemReport` - 使用此命令，但不带额外参数，生成有关活动音效对象内存使用情况的详细文档。这适用于追踪音频系统中内存意外大量使用的情况。它还有助于一般音频优化。

## 音频控制台命令

| 命令 | 说明 | 参数 |
| --- | --- | --- |
| `au.3dVisualize.ActiveSounds` | 设置活动音效的可视化模式。 | `0` ：禁用，`1` ：音量（线性），`2` ：音量（dB），`3` ：距离，`4` ：随机颜色，`5` ：遮挡体积和滤波量 |
| `au.3dVisualize.ActiveSounds.Type` | 设置要可视化的音效类型。 | `0` ：全部，`1` ：仅限组件，`2` ：仅限非组件 |
| `au.3dVisualize.Attenuation` | 启用后，将可视化衰减球体。 | `0` ：禁用，`1` ：启用 |
| `au.3dVisualize.Enabled` | 启用后，将激活音频可视化。 | `0` ：禁用，`1` ：启用 |
| `au.3dVisualize.Listeners` | 启用后，将可视化监听器。 | `0` ：禁用，`1` ：启用 |
| `au.3dVisualize.SpatialSources` | 启用后，将可视化空间化音频源。 | `0` ：禁用，`1` ：启用 |
| `au.3dVisualize.VirtualLoops` | 启用后，将可视化虚拟化循环。 | `0` ：禁用，`1` ：启用 |
| `au.adpcm.ADPCMReadFailureTimeout` | 设置在完全停止声波之前的ADPCM解码尝试次数。 | `<Value>` ：尝试次数 |
| `au.adpcm.ChanceForIntentionalChunkMiss` | 启用后，将有意丢弃文件块。 | `0` ：禁用，`1` ：启用 |
| `au.adpcm.DisableSeekForwardOnReadMisses` | 启用后，将在等待查找时禁用转发文件扫描。 | `0` ：禁用，`1` ：启用 |
| `au.adpcm.DisableSeeking` | 启用后，将禁用ADPCM查找。 | `0` ：禁用，`1` ：启用 |
| `au.adpcm.OnlySeekForwardOneChunk` | 启用后，正向查找将在连续加载两个文件块失败后停止。 | `0` ：禁用，`1` ：启用 |
| `au.AllowAudioSpatialization` | 启用后，将空间化音频。禁用后，音效仍会衰减。 | `0` ：禁用，`1` ：启用（默认） |
| `au.AllowReverbForMultichannelSources` | 启用后，将允许对信道大于2个的源进行混响处理。 | `0` ：禁用，`1` ：启用 |
| `au.AllowUnsafeAudioMixerToggling` | 启用后，将允许 `au.IsUsingAudioMixer` 替换音频引擎（即使正在使用中）。 | `0` ：禁用，`1` ：启用 |
| `au.Ambisonics.VirtualIntermediateChannels` | 启用后，将在混音之前解码为虚拟7.1扬声器配置，而非直接解码为输出设备配置。 | `0` ：禁用，`1` ：启用 |
| `au.AnalysisTimeShift` | 设置烘焙分析播放的时间轴移动（以秒为单位）。 | `<Value>` ：时间轴移动 |
| `au.AudioThreadCommand.ExecutionTimeWarningThresholdInMs` | 设置阈值（以毫秒为单位），记录命令执行时间较长警告。 | `<Value>` ：阈值 |
| `au.AudioThreadCommand.LogEveryExecution` | 启用后，将记录每个音频线程命令调用者和执行时间。 | `0` ：禁用，`1` ：启用 |
| `au.BakedAnalysisEnabled` | 启用后，将查询音频组件的烘焙分析。 | `0` ：禁用，`1` ：启用 |
| `au.BypassAllSubmixEffects` | 启用后，将绕过所有子混合效果。 | `0` ：禁用，`1` ：启用 |
| `au.BypassAudioPlugins` | 启用后，将绕过音频插件处理。 | `0` ：禁用，`1` ：启用 |
| `au.BypassPlayWhenSilent` | 启用后，将忽略非程序源的静音播放标记。 | `0` ：禁用，`1` ：启用 |
| `au.ClearMutesAndSolos` | 清除任何独奏或静音音效。 | 不适用 |
| `au.CommandBufferFlushWaitTimeMs` | 设置命令缓冲区清空等待时间（以毫秒为单位）。 | `<Value>` ：等待时间 |
| `au.CommandBufferMaxSizeInMb` | 设置在忽略其他命令之前允许的最大命令缓冲区大小（以兆字节为单位）。 | `<Value>` ：缓冲区大小 |
| `au.compression.AsyncCompression` | 启用后，将压缩声波（当编解码器支持时）。 | `0` ：禁用，`1` ：启用 |
| `au.Concurrency.MinVolumeScale` | 设置音量缩放（线性）的静音音量阈值。 | `<Value>` ：音量阈值 |
| `au.Debug.Display.X` | 设置调试文本在视口中的X坐标。 | `<Value>` ：X（默认值 = `100`） |
| `au.Debug.Display.Y` | 设置调试文本在视口中的Y坐标。 | `<Value>` ：Y （默认值 = `-1`） |
| `au.Debug.Generator` | 启用后，将激活调试音效生成。 | `0` ：禁用，`1` ：正弦波，`2` ：白噪声 |
| `au.Debug.Generator.Channel` | 设置调试音频的通道输出索引。如果输入超出所支持的通道范围，则默认为0。 | `<Value>` ：通道索引（左 = `0`，右 = `1`，等等） |
| `au.Debug.Generator.Freq` | 设置调试音效生成频率。 | `0` ：禁用，`1` ：正弦波，`2` ：白噪声 |
| `au.Debug.PlaySoundCue` | 播放Sound Cue。 | `-名称` ：播放具有指定名称的音效（如果它在音频设置中）。 `-路径` ：播放指定路径的音效。 `-半径` ：（可选）：监听器和声源之间的径向距离。 `-方位角` ：（可选）听者和声源之间的方位角（以度为单位，其中0表示笔直向前，负向左，正向右）。 `-高度` ：（可选）监听器和声源之间的高度。 `-AllViews` ：（可选）通过所有视口播放。 `-LogSubtitles` ：（记录）记录音效的字幕。 |
| `au.Debug.PlaySoundWave` | 播放声波。 | `-名称` ：播放具有指定名称的音效（如果它在音频设置中）。 `-路径` ：播放指定路径的音效。 `-半径` ：（可选）：监听器和声源之间的径向距离。 `-方位角` ：（可选）听者和声源之间的方位角（以度为单位，其中0表示笔直向前，负向左，正向右）。 `-高度` ：（可选）监听器和声源之间的高度。 `-AllViews` ：（可选）通过所有视口播放。 `-LogSubtitles` ：（记录）记录音效的字幕。 |
| `au.Debug.SoundCues` | 启用后，将在视口中显示Sound Cue信息。 | `0` ：禁用 `1` ：启用 `-AllViews` ：（可选）将更改应用于所有视口。 |
| `au.Debug.SoundCues.Minimal` | 启用后，将使用Sound Cue调试紧凑视图。 | `0` ：禁用，`1` ：启用 |
| `au.Debug.Soundcues.ShowDistance` | 启用后，将显示Sound Cue距离。 | `0` ：禁用，`1` ：启用 |
| `au.Debug.Soundcues.ShowPath` | 启用后，将显示完整的Sound Cue路径。 | `0` ：禁用，`1` ：启用 |
| `au.Debug.SoundCues.Spacing.Char` | 设置紧凑视图字符大小（以像素为单位）。 | `<Value>` ：字符大小（默认值 = `7`） |
| `au.Debug.SoundCues.Spacing.Tab` | 设置紧凑视图选项卡大小（以字符为单位）。 | `<Value>` ：选项卡大小（默认值 = `5`） |
| `au.Debug.SoundMixes` | 启用后，将在视口中显示混音信息。 | `0` ：禁用 `1` ：启用 `-AllViews` ：（可选）将更改应用于所有视口。 |
| `au.Debug.SoundModulators` | 启用后，将在视口中显示调制信息。 | `0` ：禁用 `1` ：启用 `-AllViews` ：（可选）将更改应用于所有视口。 |
| `au.Debug.SoundReverb` | 启用后，将在视口中显示混响信息。 | `0` ：禁用 `1` ：启用 `-AllViews` ：（可选）将更改应用于所有视口。 |
| `au.Debug.Sounds` | 启用后，将在视口中显示音效信息。 | `0` ：禁用 `1` ：启用 `-AllViews` ：（可选）将更改应用于所有视口。 |
| `au.Debug.Sounds.Max` | 设置在完整的音效调试器视图中显示的最大音效数。 | `<Value>` ：最大数量（默认值 = `32`） |
| `au.Debug.Sounds.ShowPath` | 启用后，将在调试器列表中显示完整的音效路径。 | `0` ：禁用，`1` ：启用 |
| `au.Debug.Sounds.Sort` | 设置音效统计数据排序属性。 | `类`、`距离`、`名称`（默认值）、`时间`、`波形`、`音量`、`优先级`（每个音效的最高波形实例） |
| `au.Debug.Sounds.TextColor` | 设置音频调试视图中的正文文本颜色。 | `白色`、`红色`、`橙色`、`黄色`、`蓝色`、`洋红色`、`紫色`、`黑色` |
| `au.Debug.SoundWaves` | 启用后在视口中显示声波信息。 | `0` ：禁用 `1` ：启用 `-AllViews` ：（可选）将更改应用于所有视口。 |
| `au.Debug.StopSound` | 停止调试音效。 | `-AllViews` ：（可选）停止所有视口中的音效。 |
| `au.Debug.Streaming` | 启用后，在视口显示流送缓存信息。 | `0` ：禁用 `1` ：启用 `-AllViews` ：（可选）将更改应用于所有视口。 |
| `au.DecompressionThreshold` | 设置后，会覆盖音效组或平台运行时设置中的最大解压时长（以秒为单位）。 | `<Value>` ：最大时长 |
| `au.DefaultModulationPlugin` | 设置要加载和使用的默认调制插件（由配置中特定于平台的实现名称来覆盖）。 | `<Value>` ：插件名称 |
| `au.DisableAppVolume` | 启用后，将禁用外部音量变更。 | `0` ：禁用，`1` ：启用 |
| `au.DisableAutomaticPrecache` | 启用后，将在加载或启动时禁用预缓存，并将仅在播放时同步预缓存。 | `0` ：禁用（默认），`1` ：启用 |
| `au.DisableBinauralSpatialization` | 启用后，将禁用双耳空间化。 | `0` ：禁用，`1` ：启用 |
| `au.DisableDeviceSwap` | 启用后，将在Windows上禁用音频混合器的设备交换处理代码。 | `0` ：禁用，`1` ：启用 |
| `au.DisableDistanceAttenuation` | 启用后，将禁用距离衰减。 | `0` ：禁用，`1` ：启用 |
| `au.DisableEnvelopeFollowing` | 启用后，将禁止使用包络跟踪器进行源包络跟踪。 | `0` ：禁用，`1` ：启用 |
| `au.DisableFiltering` | 启用后，将禁止使用每源低通和高通滤波器。 | `0` ：禁用，`1` ：启用 |
| `au.DisableHPFiltering` | 启用后，将禁止使用每源高通滤波器。 | `0` ：禁用，`1` ：启用 |
| `au.DisableLegacyReverb` | 启用后，将在旧版音频后端禁用混响。 | `0` ：禁用，`1` ：启用 |
| `au.DisableOcclusion` | 启用后，将禁用音频遮挡。 | `0` ：禁用，`1` ：启用 |
| `au.DisableParallelSourceProcessing` | 启用后，将禁用用于处理源的异步任务。 | `0` ：禁用，`1` ：启用 |
| `au.DisableQuadReverb` | 启用后，将禁用环绕声中的四重混响。 | `0` ：禁用，`1` ：启用 |
| `au.DisableReverbSubmix` | 启用后，将禁用混响子混合。 | `0` ：禁用，`1` ：启用 |
| `au.DisableSourceEffects` | 启用后，将禁用源效果使用。 | `0` ：禁用，`1` ：启用 |
| `au.DisableStereoSpread` | 启用后，将忽略衰减设置中的3D立体声扩散属性，而是从奇点渲染音频。 | `0` ：禁用，`1` ：启用 |
| `au.DisableStoppingVoices` | 启用后，将禁用停止语音功能。 | `0` ：禁用，`1` ：启用 |
| `au.DisableSubmixEffectEQ` | 启用后，将禁用EQ子混合。 | `0` ：禁用，`1` ：启用（默认） |
| `au.DisableSubmixMutationLock` | 启用后，将禁用子混合音变锁定。 | `0` ：禁用（默认），`1` ：启用 |
| `au.dsp.FFTMethod` | 设置傅里叶变换方法。 | `0` ： 迭代快速傅立叶变换，`1` ：离散傅里叶变换 |
| `au.DumpActiveSounds` | 将有关所有当前活动音效的数据输出到日志。 | 不适用 |
| `au.DumpBakedAnalysisData` | 将烘焙的声波分析数据输出到.csv文件。 | 不适用 |
| `au.editor.CookOverrideCachingInterval` | 设置项目设置中的烘焙覆盖更改与应用到新音频源之间的最大延迟（缓存间隔以秒为单位）。 | `<Value>` ：最大延迟 |
| `au.editor.ForceAudioNonStreaming` | 启用后，将强制音频进行非流式播放。这可能导致DDC丢失。 | `0` ：禁用，`1` ：启用 |
| `au.EnableBinauralAudioForAllSpatialSounds` | 启用后，将进行所有空间音效的双耳音频渲染（如果双耳渲染可用）。 | `0` ：禁用，`1` ：启用 |
| `au.EnableDetailedWindowsDeviceLogging` | 启用后，将记录Windows设备细节。 | `0` ：禁用，`1` ：启用 |
| `au.EnableOcclusionFilterScale` | 启用后，遮挡将缩放0.25f，以便补偿音频混频器中滤波器截止频率的变化。 | `0` ：禁用，`1` ：启用 |
| `au.EnableReverbStereoFlipForQuad` | 启用后，将在环绕声中进行四路混响立体声翻转。 | `0` ：禁用，`1` ：启用 |
| `au.ExtraAudioMixerDeviceLogging` | 启用后，每500次回调就记录一次音频混合器设备。 | `0` ：禁用，`1` ：启用 |
| `au.ExtraResonanceLogging` | 启用后，将记录有关共振HRTF处理状态的额外信息。 | `0` ：禁用，`1` ：启用 |
| `au.FadeOutTimeoutMSec` | 设置等待FadeOut事件触发的时间（以毫秒为单位）。 | `<Value>` ：等待时间 |
| `au.FloatArrayMath.ISPC` | 启用后，将在音频浮点数组数学运算中使用ISPC优化。 | `0` ：禁用，`1` ：启用 |
| `au.FlushAudioRenderCommandsOnSuspend` | 启用后，确保在应用程序挂起时，将所有待处理的命令发送到音频线程和音频渲染线程。 | `0` ：禁用，`1` ：启用 |
| `au.FlushAudioRenderThreadOnGC` | 启用后，每次垃圾收集器运行时，都会清空所有待处理的音频渲染线程命令。 | `0` ：禁用，`1` ：启用 |
| `au.FlushCommandBufferOnTimeout` | 启用后，如果栅栏超时，则同步清空音频渲染线程。 | `0` ：禁用，`1` ：启用 |
| `au.FocusData.InitializeFocusFactorOnFirstUpdate` | 启用后，将在第一次更新时将焦点因子初始化为正确值，而不是从0插值到正确值。 | `0` ：禁用，`1` ：启用 |
| `au.ForceRealtimeDecompression` | 启用后，可以特意确保所有音频资产在播放时解压，而不是加载时完全解压。 | `0` ：禁用，`1` ：启用 |
| `au.ForceSyncAudioDecodes` | 启用后，将会禁用用于处理源的异步任务。 | `0` ：禁用，`1` ：启用 |
| `au.ForceSynchronizedAudioTaskKick` | 启用后，将强制在一个音频渲染帧中创建的所有音频任务进入队列，直到可以在帧末尾同时将它们踢出。 | `0` ：禁用，`1` ：启用 |
| `au.IgnoreUserResonanceSubmix` | 启用后，将绕过共振子混合效果项目设置。 | `0` ：禁用，`1` ：启用 |
| `au.InteriorData.UseAudioVolumes` | 启用后，将允许从音频体积（旧版）收集内部数据。 | `0` ：禁用，`1` ：启用 |
| `au.InteriorData.UseIActiveSoundUpdate` | 启用后，将允许从实现IActiveSoundUpdate接口的子系统收集内部数据。 | `0` ：禁用，`1` ：启用（默认） |
| `au.IsUsingAudioMixer` | 启用后，将使用音频混合器。这仅在当前未使用音频设备的情况下才会生效，除非 `au.AllowUnsafeAudioMixerToggling` 设置为1。音效将停止，并且循环音效将不会自动恢复。 | `0` ：禁用，`1` ：启用 |
| `au.LinearGainScalarForFinalOutut` | 设置将线性增益标量应用于最终浮点缓冲区，可支持可热修复的削波抑制。 | `<Value>` ：增益标量（默认值 = 1.0） |
| `au.LogRenderTimes` | 启用后，将记录音频渲染时间。 | `0` ：禁用，`1` ：启用 |
| `au.LogSubmixAutoDisable` | 启用后，将记录子混合启用和禁用状态。 | `0` ：禁用，`1` ：启用 |
| `au.MaxConcurrentStreams` | 设置后，将覆盖最大并行流送数。 | `<Value > 0>` ：最大流送数 |
| `au.MaxRandomBranches` | 设置任意随机节点要播放的最大分支数。其他分支将从内存中释放。 | `<Value>` ：最大分支数 |
| `au.MaxWorldDistance` | 设置用于音频相关计算（例如衰减）的最大世界距离。 | `<Value>` ：最大距离 |
| `au.MetaSound.AutoUpdate.NativeClassesOfEqualVersion` | 启用后，如果接口不同，则尝试自动更新对拥有同一版本号的原生类的节点引用。这会导致图形加载时间变慢。 | `0` ：禁用，`1` ：启用（默认） |
| `au.MetaSound.BlockRate` | 设置MetaSounds的块速率（块/秒）。 | `<Value>` ：块速率（默认值 = `100`，最小值 = `1`，最大值 = `1000`） |
| `au.MetaSound.DisableWaveCachePriming` | 启用后，将禁用MetaSound波缓存填充。 | `0` ：禁用，`1` ：启用（默认） |
| `au.MetaSound.Editor.AsyncRegistrationEnabled` | 启用后，将在编辑器加载时异步注册所有MetaSound资产类。 | `0` ：禁用，`1` ：启用（默认） |
| `au.MetaSound.EnableAllVersionsNodeClassCreation` | 启用后，将在编辑器中为已弃用的MetaSound类的主要版本创建节点。 | `0` ：禁用（默认），`1` ：启用 |
| `au.MetaSound.EnableAsyncGeneratorBuilder` | 启用后，将异步构建FMetaSoundGenerators。 | `0` ：禁用，`1` ：启用（默认） |
| `au.MetaSound.Frontend.DiscardStreamedRegistryTransactions` | 启用后，将在流送后丢弃MetaSound注册表事务。 | `0` ：禁用，`1` ：启用（默认） |
| `au.MetaSound.Parameter.EnableWarningOnIgnoredParameter` | 启用后，将在发送到MetaSound的参数被忽略时记录警告。 | `0` ：禁用（默认），`1` ：启用 |
| `au.MetaSound.WavePlayer.SimulateSeek` | 启用后，将通过读取和丢弃非可搜索格式的声波样本来模拟查找调用。 | `0` ：禁用，`1` ：启用 |
| `au.MinLogTimeBetweenUnderrunWarnings` | 设置欠载警告之间的最短时间（以毫秒为单位）。 | `<Value>` ：最短时间（默认值 = 10000） |
| `au.Modulation.SetPitchRange` | 设置最大音高调制范围（以半音为单位）。 | `<Value>` ：范围（默认值 = `96`） |
| `au.MultithreadedPatching.PushCallsPerOutputCleanupCheck` | 设置在调用多少次推送后（通常会与音频块更新相一致）检查输出是否准备好销毁。 | `<Value>` ：推送调用次数（默认值 = `256`） |
| `au.NeverMuteNonRealtimeAudioDevices` | 启用后，非实时音频设备将免于正常的音频设备静音，例如当窗口失去焦点时。 | `0` ：禁用，`1` ：启用 |
| `au.NumPrecacheFrames` | 设置后，覆盖音频缓冲区预缓存帧的默认值。 | `0` ：默认值，`<Value > 0>` ：要预缓存的帧 |
| `au.OverrunTimeoutMSec` | 设置交换到空设备之前等待渲染线程超时的时间。 | `<Value>` ：等待时间 |
| `au.Quartz.bAlwaysTakeVoiceSlot` | 启用后，将立即获取语音槽而不会尝试在组件上缓存请求。 | `0` ：禁用，`1` ：启用 |
| `au.Quartz.HeadlessClockSampleRate` | 当不存在混音器设备时，设置Quartz时钟的取样率。 | `<Value>` ：取样率 |
| `au.Quartz.MaxSubscribersToUpdatePerTick` | 设置每次函数更新的Quartz订阅者数量。 | `0` ：无限制，`<Value > 0>` ：限制 |
| `au.Quartz.SimulateNoAudioDevice` | 启用后，QuartzSubsystem假定没有音频设备并以无头模式运行新时钟。 | `0` ：禁用，`1` ：启用 |
| `au.RealtimeDecompressZeroDurationSounds` | 启用后，将实时解压缩时长为0的声音。 | `0` ：禁用，`1` ：启用 |
| `au.RecoverRecordingOnShutdown` | 启用后，如果在录制过程中关闭游戏，将尝试录制到.wav文件。 | `0` ：禁用，`1` ：启用 |
| `au.RecycleThreads` | 启用后，将重复使用线程而不是重新创建线程。 | `0` ：禁用，`1` ：启用 |
| `au.RenderThreadAffinity` | 启用后，将覆盖音频渲染线程亲疏度。 | `0` ：禁用，`<Value > 0>` ：线程亲疏度 |
| `au.RenderThreadPriority` | 设置音频渲染线程优先级 | `0` ：正常值，`1` ：高于正常值，`2` ：低于正常值，`3` ：最高值（默认值），`4` ：最低值，`5` ：略低于正常值，`6` ：时间要求严格 |
| `au.ReportAudioDevices` | 输出当前所有活动音频设备（音频引擎实例）。 | 不适用 |
| `au.resonance.quality` | 设置后，将覆盖共振声源的质量。此选项不会提升质量级别。采用的质量将是共振源设置和此覆盖间的最小值。 | `0` ：无质量覆盖，`1` ：立体声平移，`2` ：低，`3` ：中，`4` ：高 |
| `au.Resonance.UsingReverb` | 启用后，将允许共振查询音频体积，获取混响效果。 | `0` ：禁用，`1` ：启用（默认） |
| `au.SetAudioChannelCount` | 设置音频通道数。最大值由MaxChannelCount限制。 | `<Value>` ：通道数 |
| `au.SetAudioChannelScaleCount` | 设置音频通道缩放数（百分比）。最大生成值由MaxChannelCount限制。 | `<Value>` ：通道缩放数 |
| `au.SoundDistanceOptimizationLength` | 设置在一次性距离优化时进入剔除候选之列的音效的最大时长（以秒为单位）。 | `<Value>` ：最大时长（默认值 = `1.0`） |
| `au.SourceFadeMin` | 设置在声源停止时使用的最小消退长度（以样本为单位）。该值必须能被4整除。对于某些程序源类型，这点将被忽略。 | `<Value>` ：消退长度（默认值 = `512`，最小值 = `4`） |
| `au.spatialization.ListAvailableSpatialPlugins` | 输出可用空间化插件的列表。 | 不适用 |
| `au.spatialization.SetCurrentSpatialPlugin` | 设置当前空间化插件。 | `<Value>` ：空间化插件 |
| `au.SpoofFailedStreamChunkLoad` | 启用后，将处理传入的流送文件块，视同未能加载一样。 | `0` ：禁用，`1` ：启用 |
| `au.streamcache.BlockOnChunkLoadCompletion` | 启用后，将尝试在声波请求完成后同步加载文件块。 | `0` ：禁用，`1` ：启用 |
| `au.streamcache.DisableRetaining` | 启用后，将禁用保留声波自身音频的文件块。 | `0` ：禁用，`1` ：启用 |
| `au.streamcache.DispatchToGameThreadOnChunkRequest` | 启用后，只要声波请求完成，就会向游戏线程分派回调，而不是在加载音频文件块后捕获。这可能会导致音频文件块还没有用到就被清除。 | `0` ：禁用，`1` ：启用 |
| `au.streamcache.priming.BypassRetainFromSoundCues` | 启用后，将忽略直接在Sound Cue上设置的音效类的加载行为。 | `0` ：禁用，`1` ：启用 |
| `au.streamcache.priming.PrimeDelayNodes` | 启用后，当延迟节点被击中时，将音效加载到缓存中。 | `0` ：禁用，`1` ：启用 |
| `au.streamcache.priming.PrimeRandomNodes` | 启用后，当随机节点被击中时，将音效加载到缓存中。 | `0` ：禁用，`1` ：启用 |
| `au.streamcache.SoundWaveDefaultLoadingBehavior` | 设置默认声波加载行为。 | `0` ：按需加载（默认值），`1` ：加载时保留音频，`2` ：加载时填充音频 |
| `au.streamcaching.AlwaysLogCacheMisses` | 启用后，所有缓存未命中都将添加到 `au.Debug.AudioMemReport`。禁用后，在调用 `au.streamcaching.StartProfiling` 之前，不会记录缓存未命中。 | `0` ：禁用，`1` ：启用 |
| `au.streamcaching.BlockForPendingLoadOnCacheOverflow` | 设置即将播放但在缓存溢出时不在缓存中的音频文件块的默认请求优先级。 | `0` ：清除声波保持器，`1` ：取消进行中负载 |
| `au.streamcaching.ChunkSlotNumScalar` | 设置预分配文件块槽的数量（标量）。 | `<Value>` ：文件块槽标量（最小值 = `1.0`） |
| `au.streamcaching.DebugView` | 启用后，将在比较流送缓存文件块键时比较FObjectKey。这样可避免在声波名称相同时出现FName碰撞。 | `0` ：禁用（旧版），`1` ：启用（默认），`2` ：平均视图，`3` ：细节视图 |
| `au.streamcaching.EnableExhaustiveCacheSearches` | 启用后，在FindElementForKey中线性搜索缓存。禁用后，将依赖文件块偏移。 | `0` ：禁用，`1` ：启用 |
| `au.streamcaching.EnableTrimmingRetainedAudio` | 启用后，当流送缓存超过内存限制时，将修剪保留的音频。 | `0` ：禁用，`1` ：启用 |
| `au.streamcaching.FlushAudioCache` | 启用后，将从缓存中清空所有未保留的音频。 | `0` ：禁用，`1` ：启用 |
| `au.streamcaching.ForceBlockForLoad` | 启用后，将阻止获取加载的文件块，直到磁盘读取完成。 | `0` ：禁用，`1` ：启用 |
| `au.streamcaching.KeepCacheMissBufferOnFlush` | 启用后，则在调用 `au.Debug.AudioMemReport` 之后，保留已记录缓存未命中的缓冲区。 | `0` ：禁用，`1` ：启用 |
| `au.streamcaching.MaxCachesToDisplay` | 设置要在屏幕上显示的最大流送文件块数。 | `<Value>` ：流送文件块数 |
| `au.streamcaching.MemoryLimitTrimPercentage` | 设置当流送缓存超过内存限制时，每个修剪调用的内存缓存修剪百分比。 | `<Value>` ：修剪百分比 |
| `au.streamcaching.MinimumCacheUsage` | 设置限制文件块逐出的最小缓存使用百分比。这有助于在播放大量小音效时避免磁盘I/O。 | `0` ：将文件块数限制为缓存大小/最大文件块大小，`0.01` - `0.99` ：使用百分比 |
| `au.streamcaching.NumSoundWavesToClearOnCacheOverflow` | 设置缓存溢出时要释放的声波数。 | `0` ：保留缓存溢出时声效，`<Value > 0>` ：要释放的音效数 |
| `au.streamcaching.PlaybackRequestPriority` | 设置将要播放但不在缓存中的音频文件块的默认请求优先级。 | `0` ：高，`1` ：正常值，`2` ：低于正常值，`3` ：低，`4` ：最小值 |
| `au.streamcaching.PrimeSoundOnAudioComponents` | 启用后，当使用该音效生成音频组件或设置音频组件的音效时，将自动填充音效基类。 | `0` ：禁用，`1` ：启用 |
| `au.streamcaching.ReadRequestPriority` | 设置音频文件块的默认读取请求优先级。 | `0` ：高，`1` ：正常值，`2` ：低于正常值，`3` ：低，`4` ：最小值 |
| `au.streamcaching.ResizeAudioCacheTo` | 设置音频流送缓存大小（以兆字节为单位）。如有必要，音频文件块将被剔除，以便缩减或保持新大小。 | `<Value>` ：缓存大小 |
| `au.streamcaching.SaveAudiomemReportOnCacheOverflow` | 启用后，如果缓存溢出，则打印音频内存报告。 | `0` ：禁用，`1` ：启用 |
| `au.streamcaching.SearchUsingChunkArray` | 启用后，将使用文件块池（TArray）代替LRU（链表）来详尽地搜索缓存。 | `0` ：禁用，`1` ：启用 |
| `au.streamcaching.StartProfiling` | 将为此流送管理器启动性能占用分析模式。使用 `au.Debug.AudioMemReport` 输出分析统计信息。 | 不适用 |
| `au.streamcaching.StopProfiling` | 停止 `au.streamcaching.StartProfiling` 命令。 | 不适用 |
| `au.streamcaching.StreamCacheSizeOverrideMB` | 设置缓存大小覆盖（以兆字节为单位）而非使用项目设置。 | `<Value>` ：缓存大小 |
| `au.streamcaching.TrimCacheWhenOverBudget` | 设置后，将调用TrimMemory来控制预算。 | `0` ：禁用，`1` ：启用 |
| `au.submix.clearbrokensubmixassets` | 设置后，将验证子混合子项仍是子项，并从以前的子项清除以前的父项列表。 | `0` ：禁用，`1` ：启用 |
| `au.Submix.Effects.DynamicsProcessor.Bypass` | 启用后，将绕过所有活动的子混合动态处理器。 | `0` ：禁用，`1` ：启用 |
| `au.ThreadedSwapDebugExtraTime` | 启用后，将向交换任务添加额外时间，从而模拟缓慢的设备交换。 | `0` ：禁用，`1` ：启用 |
| `au.UnderrunTimeoutMSec` | 设置在提交欠载缓冲区之前生成下一个缓冲区的渲染线程等待时间。 | `<Value>` ：等待时间（毫秒） |
| `au.UseCachedDeviceInfoCache` | 启用后，将使用DeviceCache而不是OS缓存。 | `0` ：禁用，`1` ：启用 |
| `au.UseListenerOverrideForSpread` | 启用后，零将覆盖立体声平移的衰减距离，而非使用实际距离。 | `0` ：禁用，`1` ：启用 |
| `au.VirtualLoops.Enabled` | 启用后，将支持音频循环的虚拟化。 | `0` ：禁用，`1` ：启用 |
| `au.VirtualLoops.ForceUpdateListenerMoveDistance` | 设置强制更新虚拟化音效所需的距离阈值，以检查监听器是否在给定距离内单帧移动，以虚幻单位（UU）测量。 | `<Value>` ：距离（默认值 = `2500`） |
| `au.VirtualLoops.PerfDistance` | 设置虚拟循环距离，使更新速率在最小可听音效距离和最大可听音效距离之间缩放。 | `<Value>` ：距离（默认值 = `15000.0`） |
| `au.VirtualLoops.UpdateRate.Max` | 设置最大速率，以便检查音效是否再次可听（超出音效的最大可听距离+性能缩放距离）。 | `<Value>` ：速率（默认值 = `3.0`） |
| `au.VirtualLoops.UpdateRate.Min` | 设置最小速率，以便检查音效是否再次可听（在音效的最大可听距离处）。 | `<Value>` ：速率（默认值 = `0.1`） |
| `au.voip.AlwaysPlayVoiceComponent` | 启用后，保证VOIP组件不会通过将其优先级设置为高于所有其他音频源而被降低优先级和终止。 | `0` ：禁用，`1` ：启用 |
| `au.vorbis.ReadFailiureTimeout` | 启用后，将在解码失败多次后放弃解码Ogg Vorbis音频。 | `0` ：禁用，`1` ：启用 |
| `au.WaitForSoundWaveToLoad` | 启用后，除非已加载声波，否则拒绝播放音效。 | `0` ：禁用，`1` ：启用 |
| `au.WorldlessGetAudioTimeBehavior` | 设置当音频组件不属于世界时GetAudioTime的返回值。 | `0` ：0.0（默认值），`1` ：应用的当前时间 |
