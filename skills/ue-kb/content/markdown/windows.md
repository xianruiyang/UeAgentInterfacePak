# Windows

---
title: "Windows"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/windows-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "平台", "Windows"]
---

# Windows

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 平台 / Windows

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/windows-settings-in-the-unreal-engine-project-settings

## Windows

### 目标RHI

| **设置** | **说明** |
| --- | --- |
| **默认RHI（Default RHI）** | 你可以在此处选择要使用的渲染硬件接口（RHI）。 确保你选择的RHI也选作目标RHI。 更改此设置需要重启编辑器。 你可以从以下选项中选择： **默认值（Default）** **DirectX 11** **DirectX 12** **Vulkan** |
| **DirectX 11和12（DirectX 11 & 12 (SM5)）** | 启用该设置以将DirectX 11和DirectX 12用作目标RHI。 |
| **DirectX 12（SM6，试验性）（DirectX 12 (SM6, Experimental)）** | 启用该设置以将DirectX 12用作目标RHI。 |
| **Vulkan (SM5)** | 启用该设置以将Vulkan用作目标RHI。 |
| **DirectX移动模拟（DirectX Mobile Emulation)）** | 启用该设置以将DirectX移动模拟用作目标RHI。 |

### 工具链

| **设置** | **说明** |
| --- | --- |
| **编译器版本（Compiler Version）** | 要用于此项目的编译器版本。 可能不同于所选IDE。 你可以从以下选项中选择： **默认值（Default）** **Visual Studio 2015（废弃）（Visual Studio 2015 (deprecated)）** **Visual Studio 2017** **Visual Studio 2019** **Visual Studio 2022** |

### 启动画面

| **设置** | **说明** |
| --- | --- |
| **编辑器启动画面（Editor Splash）** | 编辑器启动画面。 |
| **游戏启动画面（Game Splash）** | 游戏启动画面。 |

### 图标

| **设置** | **说明** |
| --- | --- |
| **游戏图标（Game Icon）** | 游戏图标。 |

### 音频

| **设置** | **说明** |
| --- | --- |
| **音频混合器采样率（Audio Mixer Sample Rate）** | 要用于运行音频混合器的采样率。 |
| **回调缓冲区大小（Callback Buffer Size）** | 要在每个回调块中计算的音频数量。 使用较低值会减少延迟，但可能增加CPU成本。 |
| **要排队的缓冲区数量（Number of Buffers To Enqueue）** | 要保持排队的缓冲区数量。 缓冲区越多，延迟越长，但可以补偿一些平台上的音频回调的可变计算可用性。 |
| **最大通道数量（Max Channels）** | 要为该平台限制的通道（语音）最大数量。 如果你在此处以及你的全局音频质量设置中指定最大通道数量，你的应用程序将使用两个值中的较小者。 如果设为0，虚幻引擎将使用所有可用通道。 |
| **源工作程序数量（Number of Source Workers）** | 要用于计算源音频的工作程序数量。 将仅使用不超过最大数量的源（"最大通道数量（Max Channels）"值）。 会将源均匀划分到每个源工作程序。 |
| **压缩覆盖（Compression Overrides）** | 请参阅下面的[压缩覆盖](#%E5%8E%8B%E7%BC%A9%E8%A6%86%E7%9B%96)表。 |
| **烘焙覆盖（Cook Overrides）** | 请参阅下面的[烘焙覆盖](#%E7%83%98%E7%84%99%E8%A6%86%E7%9B%96)表。 |
| **空间化插件（Spatialization Plugin）** | 定义要使用当前启用的哪个空间化插件。 如果在下拉菜单中找不到所需的空间化，请确保它在 **插件（Plugins）** 窗口（主菜单： **编辑（Edit）; 插件（Plugins）** ）中已启用。 你可以从以下选项中选择： **内置空间化（Built-In Spatialization）** **谐振音频（Resonance Audio）** **其他（Other）** |
| **混响插件（Reverb Plugin）** | 定义要使用当前启用的哪个混响插件。 如果在下拉菜单中找不到所需的混响插件，请确保它在 **插件（Plugins）** 窗口（主菜单： **编辑（Edit）; 插件（Plugins）** ）中已启用。 你可以从以下选项中选择： **内置混响（Built-In Reverb）** **谐振音频（Resonance Audio）** **其他（Other）** |
| **遮挡插件（Occlusion Plugin）** | 定义要使用当前启用的哪个遮挡插件。 如果在下拉菜单中找不到所需的遮挡插件，请确保它在 **插件（Plugins）** 窗口（主菜单： **编辑（Edit）; 插件（Plugins）** ）中已启用。 你可以从以下选项中选择： **内置遮挡（Built-In Occlusion）** **其他（Other）** |
| **Sound Cue烘焙质量（Sound Cue Cook Quality）** | 用于烘焙SoundCue的质量级别（设置后，烘焙器将剥离所有其他级别）。 |

#### 压缩覆盖

| **设置** | **说明** |
| --- | --- |
| **覆盖压缩时间（Override Compression Times）** | 启用后，将覆盖每个声波上的声音组，而改用时长阈值来确定声音是否应该在初始加载期间完全解压。 |
| **时长阈值（Duration Threshold）** | "覆盖压缩时间（Override Compression Times）"设为true后，低于此阈值（以秒为单位）的声音都将在加载时完全解压。 否则，此声音的第一个数据块会在加载时缓存，其余内容将实时解压。 如果设为0，将默认为相关声波上的声音组。 |
| **随机SoundCue节点上的最大分支数量（Maximum Branches on Random SoundCue Nodes）** | 在此平台上，Sound Cue上的所有随机节点将自动仅预先加载此数量的分支，并在加载时放弃所有其他分支。 这可大幅减少内存使用量。 如果设为0，不会剔除分支。 |
| **Sound Cue的质量索引（Quality Index for Sound Cues）** | 在该平台上，使用该索引处的指定质量来覆盖用于SoundCue的质量。 |

请返回[音频](#%E9%9F%B3%E9%A2%91)表。

#### 烘焙覆盖

| **设置** | **说明** |
| --- | --- |
| **为设备重新采样（Resample for Device）** | 在该平台上启用音频重新采样使用给定的重新采样质量采样率。 |
| **压缩质量修饰符（Compression Quality Modifier）** | 在烘焙到此平台时缩放所有压缩质量。 例如，使用0.5会将所有压缩质量减半，使用1.0会将其保持不变。 |
| **流送缓存（Stream Caching）** | 请参阅下面的[流送缓存](#%E6%B5%81%E9%80%81%E7%BC%93%E5%AD%98)表。 |
| **重新采样质量（Resampling Quality）** | 请参阅下面的[重新采样质量](#%E9%87%8D%E6%96%B0%E9%87%87%E6%A0%B7%E8%B4%A8%E9%87%8F)表。 |

请返回[音频](#%E9%9F%B3%E9%A2%91)表。

##### 流送缓存

| **设置** | **说明** |
| --- | --- |
| **最大缓存大小（Max Cache Size (KB)）** | 这将确定在任意给定时间应该用于缓存的最大内存数量。 如果设置很低（<= 8 MB），会降低烘焙期间音频的单独数据块的大小。 |
| **最大数据块大小覆盖（Max Chunk Size Override (KB)）** | 覆盖掉为流送缓存的音频分块时使用的默认最大数据块大小（< 0时忽略）。 |

请返回[烘焙覆盖](#%E7%83%98%E7%84%99%E8%A6%86%E7%9B%96)表。

##### 重新采样质量

| **设置** | **说明** |
| --- | --- |
| **最大采样率（Max Sample Rate）** | 重新采样质量最大采样率。 |
| **高采样率（High Sample Rate）** | 重新采样质量高采样率。 |
| **中采样率（Medium Sample Rate）** | 重新采样质量中采样率。 |
| **低采样率（Low Sample Rate）** | 重新采样质量低采样率。 |
| **最低采样率（Min Sample Rate）** | 重新采样质量最低采样率。 |

请返回[烘焙覆盖](#%E7%83%98%E7%84%99%E8%A6%86%E7%9B%96)表。

