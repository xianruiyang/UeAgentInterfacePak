---
title: "Harmonix插件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/harmonix-plugin-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "处理音频", "音乐系统", "Harmonix插件"]
---

# Harmonix插件

> 路径：虚幻引擎5.7文档 / 处理音频 / 音乐系统 / Harmonix插件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/harmonix-plugin-in-unreal-engine

**Harmonix** 插件为我们提供了用于制作《Patchwork》和《Fortnite Festival》的功能、[MetaSound](../../sound-source/metasounds/index.md)节点和组件。这些工具通过MIDI序列、音频分析和音乐合成等功能，让你可以自行创建独由音乐驱动的体验。

启用Harmonix插件的步骤如下：

1. 选择

   编辑（Edit）>插件（Plugins）

   ，打开

   插件（Plugin）

   面板。
2. 在

   插件（Plugins）

   面板中，使用搜索栏找到Harmonix插件。
3. 点击对应复选框。
4. 重启虚幻编辑器。

## 通用功能

### MIDI文件导入

将MIDI文件拖放到 **内容浏览器（Content Browser）** 中即可将其导入到项目。

### 融合配接资产

融合配接（Fusion Patch）资产会将一系列MIDI音符和速度映射为声波（Sound Wave）资产。融合配接资产会驱动MetaSound节点[Fusion Sampler](#fusionsampler)的乐器取样器功能。

要创建融合配接资产，请执行以下操作：

1. 转到

   内容浏览器（Content Browser）

   ，选择需要映射的声波。
2. 右键点击所选的声波。
3. 从上下文菜单中选择

   创建融合配接（Create Fusion Patch）

   。
4. 在

   新建融合配接选项（New Fusion Patch Options）

   窗口中设置所需选项。
5. 点击

   确定（OK）

   。

> [!TIP]
> `Engine\Plugins\Runtime\Harmonix\Content\Examples\Patches` 中有Fusion Sampler配接资产的样例。在内容浏览器的设置中启用 **显示引擎内容（Show Engine Content）** 和 **显示插件内容（Show Plugin Content）**，即可在内容浏览器中找到这些样例。

### 峰值平缓器

处理音频响应式的视觉效果或玩法时，最好能让音频能级或其他与声音相关的分析值保持在[0.0, 1.0]的平滑取值范围内。虽然在MetaSounds中使用Compressor或Envelope Follower节点也能实现这一点，但这种做法在音频线程中的开销很大。而峰值平缓器（Peak Tamer）则在游戏线程上工作，可以平滑并压缩MetaSound源的输出或其他值。

峰值平缓器有两种类型：

- Harmonix::AudioReactivity::FPeakTamer
- UHarmonixPeakTamer

两种类型的功能相似，但你可以通过蓝图使用 `UHarmonixPeakTamer` 。通过 `Configure` 方法，你可以使用 `FHarmonixPeakTamerSettings` 配置两种峰值平缓器的平滑和压缩设置。

## MetaSound节点

Harmonix插件包含一系列针对MIDI生成、筛选和操控的MetaSound节点。这些节点位于节点选择上下文菜单的 **函数（Functions） > Harmonix** 下。

将鼠标悬停在节点上并查看其提示文本，即可了解有关这些节点及其引脚的更多信息。下文给出了部分节点的额外信息。

### Fusion Sampler

Fusion Sampler节点会使用给定的Fusion Sampler配接来渲染输入MIDI流，从而起到乐器取样器的作用。该配接会将MIDI音符映射到键区，从而让音频样本根据输入流中相应的MIDI音符进行播放。

> [!TIP]
> Fusion Sampler节点支持多线程渲染。点击Fusion Sampler节点底部的展开箭头即可找到输入引脚。
>
> 要支持多线程，必须将节点的音频和渲染同步输出连接到Fusion Synchronizer节点，并在图表的其他位置引用该节点的音频输出。

### Step Sequence Player

Step Sequence Player节点会使用MIDI时钟（MIDI Clock）、音乐传输（Music Transport）和MIDI步进序列（MIDI Step Sequence）资产来创建MIDI事件流。 MIDI步进序列是由单元格组成的2D网格，其中横排代表音符，竖列则代表时间单位。

> [!NOTE]
> 你可以在Step Sequence Player节点运行时修改MIDI步进序列资产。

### Clock-Synced Delay

Clock-Synced Delay节点会对输入的音频信号应用与给定的MIDI时钟同步的延时效果。它与默认的Delay MetaSound节点不同，能产生与音乐同步的音频效果。

## 组件

Harmonix插件在 **MetaSoundMusic** 类别下提供了可通过蓝图访问的组件：

- 音乐时钟（Music Clock）
- 音乐节奏量表（Music Tempometer）

### 音乐时钟

音乐时钟（Music Clock）组件会用C++和蓝图格式驱动音乐的计时和同步，从而为节奏化的玩法系统和动画等提供支持。

音乐时钟主要用于将玩法事件和图形渲染与MetaSound图表中异步渲染的音乐时间同步，但你也可以用基本节奏和拍号进行同步。

当由MetaSound驱动时，时钟的时间相关Get方法会提供以下任一项时间上下文：

- AudioRenderTime

  — 提供音频渲染器经平滑处理后的位置。适合用于根据当前歌曲时间对音乐事件进行排队。该时间不包括被渲染的音乐到达玩家耳中所需的时间。
- ExperienceTime

  — 如果校准得当，能向你表明玩家所听到和看到的内容。适合用于对玩家的输入进行评分。
- VideoRenderTime

  — 如果校准得当，能向你表明现在应该绘制什么来与音乐同步显示。适合用于让动画、UI和其他视觉效果与音乐同步。

音乐时钟的传输与正在播放的MetaSound是分开的。这有助于在暂停与时钟同步的游戏系统时，继续播放底层音乐。例如，你可以在玩家与游戏UI交互时暂停时钟，然后在交互完成后让时钟继续运行。此时，当你继续时，时钟就会回到由MetaSound渲染的当前时间。

### 音乐节奏量表

音乐节奏量表（Music Tempometer）通过其Actor提供音乐时钟（Music Clock）组件的播放属性，并可选择是否更新材质参数集合。
