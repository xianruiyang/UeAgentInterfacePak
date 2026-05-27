# Submix介绍

---
title: "Submix介绍"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/overview-of-submixes-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "子混音", "Submix介绍"]
---

# Submix介绍

> 路径：虚幻引擎5.7文档 / 处理音频 / 子混音 / Submix介绍

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/overview-of-submixes-in-unreal-engine

**Submix（子混音）** 是一种 **DSP（数字信号处理）图表**，即便没有音频发送，它也始终运行。

作为 **虚幻引擎** 中音频渲染器的基本组件，Submix有两重用途：

- 将单个资源生成的音频混合到单个输出缓冲区中；
- 优化数字信号处理（DSP）效果，同时应用于多个声源。

可以将Submix想象成一条流淌的河流——声音播放时，它就像水一样倒入Submix河流。一个Submix连接另一个时，相当于一条河汇入另一条河。所有倒在一起的声音汇聚成一条声音的河流，流淌下去。和河流一样，声音流也只朝着一个方向流淌。

每个Submix **端点**（硬件输出）都从单个图表读取内容。例如，主Submix（即单个默认Submix端点）定义单个Submix图表。

**Sound Cue** 和其他 `USoundBase` 一样，可以发送到Submix。

你可以使用 **蓝图** 修改Submix上的属性，更改Submix处理音频的方式。

## 创建Submix

可以直接在内容浏览器中创建Submix，创建方式与其他音效相关资产差不多：右键点击内容浏览器中的资产区域，选择 **音效（Audio）> 混合（Mix）> 音效Submix（Sound Submix）** 。

## Submix图表编辑器

双击Submix资产，打开 **Submix图表编辑器（Submix Graph Editor）** 。

![Submix Graph Editor](../../../../assets/images/78/786c891a70c58d9d6b7c3231bb9b53ae10070a2d43cc6cf296b7cf3a113bfdd3.png)

点击查看大图

你可以将子组合连接到图表结构，并将一个Submix的输出设置为另一个Submix的输入。

![连接Submix](../../../../assets/images/52/52b196d0a0a5e5b1125dc565ecf7d85d5f5f81dd32f4f79d8ee87bef65ebe5a8.png)

要从图表编辑器中新建Submix，将输出或输入引脚拖到图表中，然后命名该新Submix（名称不可包含空格）。该新Submix将添加到内容浏览器。

![有多个输入的Submix](../../../../assets/images/b1/b1005c469e3d9a7f4830ade298fd2af99a125fc3e2324fb571998100a8348691.png)

> [!NOTE]
> 一个Submix可以有多个输入，但仅有一个输出。

### 主Submix

**主Submix（Master Submix）** 参数可从项目设置（Project Settings）（**编辑（Edit）>项目设置（Project Settings）>引擎（Engine）>音频（Audio）>混合（Mix）**）中设置。

![The Master Submix Parameters](../../../../assets/images/66/667c71df5b163b9e2e7679857754a99c23fe2d4453e19da7176e5be52831f333.png)

点击查看大图

双击 **Submix（submix）** 图表访问 **主Submix（Master Submix）** 属性。

![Master Submix Default Properties](../../../../assets/images/69/695a35ca3eea8979a5d7606a75540828780f9bc28e5c1248c6914b22d7e469bd.png)

点击查看大图

主Submix直接连接到输出端点（例如硬件扬声器）。这是音频混合器的第一个渲染阶段，之后音频会传递到平台音频后端，然后传递到平台使用的音频设备上。

如果Submix输出引脚未连接到任何地方，会将输出发送到主Submix。

### 主混响Submix

主混响Submix在 **音效类（Sound Class）** 中设置。

![主混响Submix设置](../../../../assets/images/bc/bcb4fb9e0c62050a97e289b9a4f18cc5dc83a3911c924f3a940c911e4bf71fea.png)

- **发送到主混响Submix（Send to Master Reverb Submix）** - 将音效发送到主混响。
- **默认2D混响发送量（Default 2DReverb Send Amount）** - 设置2D音效发送到主混响时的发送级别。

### 主EQSubmix

**主EQSubmix（Master EQ Submix）** 在 **音效类（Sound Class）** 的 **旧有（Legacy）** 下设置。

![主EQ Submix设置](../../../../assets/images/61/61a131b5572b01318fa8ee541e0df86df73716504801254e5f1c7f74b11db79f.png)

必须启用 **输出到主EQSubmix（Output to Master EQ Submix）** 设置，才能使 **音效类混合（Sound Class Mixes）** 上的 **EQ设置（EQ Settings）** 正常工作。

## 发送音频到Submix

有几种方法可以将音效源发送到Submix：

- 在音效源资产中手动设置发送。
- 使用衰减（Attenuation）设置。
- 在蓝图中动态设置。
- 通过音频音量（Audio Volumes）设置。

### 手动设置Submix发送

要在Submix上运行音效源，或将其生成的音频发送到Submix，将新的Submix资产分配到音效源上的 **Submix（Submix）** 属性。音效资产上的Submix（Submix）属性被视为该音效的 **基本Submix** ，音频全部发送到该Submix。

![Manually Set Up a Submix Send](../../../../assets/images/3e/3ef9bdc3cd6dd474d4c5593803f16c57a81414da8c3a0e8b6920c44aef92c166.png)

点击查看大图。

属性：

- **Submix发送（Submix Sends）** ：音效资产上的Submix发送数组是音效源会向其发送部分音频的一组后续Submix。可手动或远程完成发送；例如，声音越远，发送到Submix的音频越少。
- **发送级别控制方法（Send Level Control Method）** ：源将其音频发送到指定Submix的方法：
- **手动（Manual）** ：音效直接使用发送级别（Send Level）值发送音频。
- **线性（Linear）** ：音效使用最小和最大发送级别以及最小和最大发送距离之间的线性映射，将音频发送到Submix。
- **自定义曲线（Custom Curve）** ：使用自定义发送级别曲线（Custom Send Level Curve）将音频发送到Submix，而非使用线性映射。
- **发送阶段（Send Stage）** ：确定源发送应该在应用距离衰减之前还是之后执行。
- **音效Submix（Sound Submix）** ：音效源使用此Submix发送条目向其发送音频的Submix。
- **发送级别（Send Level）** ：发送级别控制方法（Send Level Control Method）设置为手动（Manual）时所使用的发送级别。
- **禁用手动发送限制（Disable Manual Send Clamp）** ：使用手动发送级别控制方法时启用或禁用0-1限制。
- **最小发送级别（Min Send Level）：** 使用非手动发送级别控制方法时所使用的最小发送级别。
- **最大发送级别（Max Send Level）：** 应用线性控制方法时所使用的最大发送级别。
- **最小发送距离（Min Send Distance）：** 应用线性控制方法时所使用的最小距离。
- **最大发送距离（Max Send Distance）：** 应用线性控制方法时所使用的最大距离。
- **自定义发送级别曲线（Custom Send Level Curve）：** 用于映射最小和最大发送级别和距离的曲线。

### 使用音效衰减发送到Submix

Submix发送也可以通过 **衰减（Attenuation）** 设置进行设置。此方法可以简便地从同一处设置大量资产上的Submix发送。由于Submix发送可以根据距离将音频发送至监听器，因此在定义了距离衰减的情况下，此方法有用。

> 图片已省略：Send to Submixes Using Sound Attenuation

点击查看大图。

有关此方法的更多信息，请参见[音效衰减](../../spatialization-and-sound-attenuation/sound-attenuation/index.md)。

### 在蓝图中动态发动至Submix

利用此蓝图功能，音频组件可使用你选择的任何方法将音频动态路由至任意Submix。

> 图片已省略：在蓝图中动态发动至Submix

要设置Submix发送，你将需要：

- **目标（Target）** - 用于将音频发送到Submix的音频组件。
- **Submix** - 向其发送音频的Submix。
- **发送级别（Send Level）** - 发送的音频量，以总音量的百分占比表示。

另请参见本文档稍后的[蓝图API和Submix](#%E8%93%9D%E5%9B%BEapi%E5%92%8Csubmix)。

### 使用音频体积发送至Submix

音频音量功能支持将音频发送至Submix，具体设置方法类似于直接在音效源上设置发送的方法。主要的区别是，Submix发送基于与音频音量几何体的相对位置。

> 图片已省略：Send to Submixes using Audio Volume

点击查看大图

Submix发送数组中的属性与直接在音效源自身上设置的属性相同。

> 图片已省略：设置Submix发送设置

音效源将根据 **监听器位置状态（Listener Location State）** 显示监听器在音量范围内还是在音量范围外，将音频发送到给定Submix发送数组。

音频音量还支持 **Submix重载（Submix Override）** ，具体取决于监听器位置状态。Submix被指定效果链重载，具体取决于监听器在音量范围内还是音量范围外。

## Submix属性

在 **图表编辑器（Graph Editor）** 中，Submix图表中会显示选定Submix的 **属性细节（Property Details）** 面板。

> 图片已省略：Submix Properties

点击查看大图

属性：

- **后台运行时静音（Mute when Backgrounded）** - 应用程序在后台运行时，允许Submix通过在其输出上应用 **0.0** 的音量缩放器自动将自己静音。此功能默认允许游戏在后台继续播放音频，但仅适用于部分音频，不是全部。
- **Submix效果链（Submix Effect Chain）** - 这是一组Submix效果，通过它馈送混合的Submix音频。这些效果使用 **合成和DSP效果（Synthesis and DSP Effects）** 插件实现。其他虚幻引擎插件也可以扩展可用Submix效果的列表。
- **环境立体声插件设置（Ambisonics Plugin Settings）** - 通过此属性，插件可以选择性地允许Submix将发送给它的音频源编码为环境立体声声场。这些设置定义声场编码属性。

> [!NOTE]
> 此属性唯一接受的设置类型是Oculus环境立体声设置（启用Oculus插件后）。有关声场的更多信息，请参见[原生声场环境立体声渲染](../native-soundfield-ambisonics-rendering/index.md)。

- **父Submix（Parent Submix）** - 选定的Submix的父项。父Submix会将已渲染的输出作为输入来接收。
- **子Submix（Child Submixes）** - 一组将音频作为输入馈送到选定Submix的子Submix。
- **包络跟踪器（Envelope Follower）** - 这是一种DSP算法，将输出已经过平滑处理的音频信号在一段时间内的振幅。启动时间（Attack Time）值定义了算法对振幅增加（**启动**）和振幅减少（**释放**）的反应速度。

使用包络跟踪器推导音频信号的振幅要比使用原始音频数据有效得多，因为音频信号的速度（比如每秒48,000个样本）要比游戏帧（例如每秒60帧）快得多。

Submix还有[蓝图API](#%E8%93%9D%E5%9B%BEapi%E5%92%8Csubmix)，允许蓝图接收在Submix中渲染的音频的振幅包络体。以下属性定义包络跟踪器的行为方式。

- **Submix水平（Submix Level）** - 控制Submix的整体音量水平。可以选择将这一类的值设置为显示线性体积增益（例如 **0.0** 到 **1.0**），或分贝数（**-120 dB** 到 **0 dB**）。分贝是一种常见的音量度量方法，它揭示了一个事实，即音量是以对数方式感知的。
- **输出音量（Output Volume）** - 同时在干通道和湿通道控制整个Submix的整体输出音量。不建议使用此属性混合游戏音量，但可用其调整Submix中的音量。
- **湿度（Wet Level）** - 通过Submix效果链馈送的音频输出音量。此值默认设为 **1.0** ，因为假定大部分人使用Submix时都想要全湿，且所有音频通过效果发送。
- **干度（Dry Level）** - 不是通过Submix效果链馈送的音频输出音量。此值默认设为0.0，因为假定大部分人使用Submix时都想要全湿（所有音频通过效应发送）。
- **音频链接设置（Audio Link Settings）** ：可选的音频链接设置对象。
- **自动禁用（Auto Disable）** ：这将自动启用或禁用Submix，无论是静音还是可以听到。这很适合用于CPU优化。
- **自动禁用时间（Auto Disable Time）** ：这是禁用Submix前要等待的时间长度。

## Submix效果

使用 **合成和DSP效果（Synthesis and DSP Effects）** 插件可以实现许多Submix效果。此插件由Epic制作，经常会添加新的合成、源效果和Submix效果。第三方插件制作商也可以轻松添加新的可用Submix效果。

非声场Submix效果的一般要求是能够处理多个音频通道（最多8个通道）。

### 制作Submix效果预设

**Submix效果预设（Submix Effect Preset）** 是一种存在于内容浏览器中的资产，它挂接到Submix效果链。要创建Submix效果预设，在内容浏览器中点击右键，选择 **音效（Audio）>效果（Effects）>Submix效果预设（SubmixEffectPreset）** 。系统会提供类选取器，供你选择要创建预设资产的效果。

> 图片已省略：选取Submix效果类

> [!NOTE]
> 插件将自动扩展 **选取Submix效果类（Pick Submix Effect Class）** 列表中的可用选项。

## 蓝图API和Submix

Submix在 **蓝图** 中很有用。例如，可以创建 **音效Submix变量（Sound Submix Variable）** 引用来引用蓝图中的Submix。

> 图片已省略：Reference a Submix Effect in Blueprint

点击查看大图

## 在蓝图中录制Submix音频

Submix支持将Submix的音频输出录制到输出到磁盘的PCM（脉冲编码调制）.wav文件，或录制到声波资产。每个Submix同一时间仅可激活一个录制。

- 保存的 **.wav文件** 的默认路径是 `Saved\BouncedWavFiles` 。
- **声波（Sound Waves）** 保存到内容浏览器的根目录。

你可以在设置 **完成录制输出（Finish Recording Output）** （见下文）时更改任一路径。

> 图片已省略：开始录制Submix输出

**开始录制输出（Start Recording Output）** 属性：

- **预期时长（Expected Duration）** - 可选的高级参数，用于预分配预期时长内的内部音频缓冲区（以秒为单位）。
- **要录制的Submix（Submix to Record）** - 要录制的Submix。

**暂停录制输出（Pause Recording Output）** 暂停录制。

> 图片已省略：暂停录制Submix输出

**恢复录制输出（Resume Recording Output）** 恢复录制。

> 图片已省略：恢复录制Submix输出

**完成录制输出（Finish Recording Output）** 结束录制并保存。

> 图片已省略：完成录制Submix输出

属性：

- **导出类型（Export Type）** ：将Submix录制导出（或另存）为.wav文件还是声波(UAsset)。
- **名称（Name）** ：资产的名称。
- **路径（Path）** ：导出资产的路径。如果留空，则保存到该导出类型的默认路径。
- **要录制的Submix（Submix to Record）** ：录制的Submix。
- **要重载的现有声波（Existing Sound Wave to Overwrite）** - 若另存为声波，则可选择重载之前的资产。

## 蓝图中的实时分析

Submix支持通过 **包络跟踪** 或 **频谱分析** 在蓝图中检索实时分析，例如快速傅里叶变换（FFT）。

### 包络跟踪分析

当Submix上有新的包络数据可用时，将调用 **添加包络跟踪器委托（Add Envelope Follower Delegate）** 。

> 图片已省略：Add Envelope Follower Delegate

点击查看大图

使用 **每通道Submix的包络值（envelope value of the submix per channel）** （左、右、中央、左环绕、右环绕等）调用该委托。

**开始包络跟踪（Start Envelope Following）** 启动给定Submix上的包络跟踪器。如果挂接了委托，则该委托将触发。

> 图片已省略：启动Submix包络跟踪器

> 图片已省略：启动Submix包络跟踪器

> 图片已省略：停止Submix包络跟踪器

### 频谱分析

**添加频谱分析委托（Add Spectral Analysis Delegate）** 提供频谱分析。

> 图片已省略：添加频谱分析

属性：

- **带内设置（In Band Settings）** ：用于定义频谱分析器设置的结构体。
- **频带数量（In Num Bands）** ：要分析的频带数量。
- **最小频率范围（In Minimum Frequency）** ：频谱分析器中要考虑的最小频率范围（单位为Hz）。
- **最大频率范围（In Maximum Frequency）** ：最大频率范围。

使用设置中定义的各个频谱带的频谱数据调用委托。

**开始频谱分析（Start Spectral Analysis）** 启动频谱分析器。

> 图片已省略：开始频谱分析

**停止频谱分析（Stop Spectral Analysis）** 停止频谱分析。

> 图片已省略：停止频谱分析

## 蓝图中的音量控制

也可从蓝图为Submix设置音量控制。

**设置Submix输出音量（Set Submix Output Volume）** 直接设置Submix的输出音量。

> 图片已省略：设置Submix输出音量

## 蓝图中的Submix效果控制

**添加Submix效果（Add Submix Effect）** 将Submix效果预设动态地添加到Submix效果链的末尾。

> 图片已省略：添加Submix效果预设

**移除Submix效果预设（Remove Submix Effect Preset）** 移除Submix的Submix效果链中的Submix效果预设。

> 图片已省略：移除Submix效果预设

**移除索引处的Submix效果预设（Remove Submix Effect Preset At Index）** 类似于移除Submix效果预设，但会在Submix效果链中移除给定索引处的Submix效果预设（如果该索引处存在效果）。

> 图片已省略：在索引处添加Submix效果预设

**替换Submix效果（Replace Submix Effect）** 将给定索引处的Submix效果预设替换为新的效果预设。

> 图片已省略：替换Submix效果

**清除Submix效果（Clear Submix Effects）** 清除给定Submix上的Submix效果链。

> 图片已省略：清除Submix效果

**设置Submix效果链重载（Set Submix Effect Chain Override）** 可以一次性重载整个Submix效果链。

> 图片已省略：设置Submix效果链覆盖

属性：

- **音效Submix（Sound Submix）** - 要使用Submix效果预设链覆盖的Submix。
- **Submix效果预设链（Submix Effect Preset Chain）** ：一组Submix效果预设。
- **消退时间秒（Fade Time Sec）** - Submix效果链的交叉消退时间。这将从当前效果链消退至新效果链重载。

> [!NOTE]
> 还可通过[音频音量](../../audio-volume-actor/audio-volumes/index.md)设置Submix效果链重载。
>
> > 图片已省略：Add Volume Submix Override
>
> 点击查看大图

**清除Submix效果链重载（Clear Submix Effect Chain Override）** 清除已设置的任何Submix效果链重载集。

> 图片已省略：清除Submix效果链覆盖

属性：

- **音效Submix（Sound Submix）** - 要清除的Submix。
- **消退时间-秒（Fade Time Sec）** - 从当前Submix效果链重载到默认Submix效果链的交叉消退时间。

