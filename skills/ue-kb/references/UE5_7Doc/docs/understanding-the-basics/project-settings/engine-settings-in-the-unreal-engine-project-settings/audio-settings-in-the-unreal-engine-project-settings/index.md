---
title: "音频"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/audio-settings-in-the-unreal-engine-project-settings"
breadcrumbs: ["虚幻引擎5.7文档", "理解基础知识", "项目设置", "引擎", "音频"]
---

# 音频

> 路径：虚幻引擎5.7文档 / 理解基础知识 / 项目设置 / 引擎 / 音频

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/audio-settings-in-the-unreal-engine-project-settings

## 音频

### 对话

| **分段** | **说明** |
| --- | --- |
| **对话文件名格式（Dialogue Filename Format）** | 为对话声波中的情境生成文件名时要使用的格式字符串。 这必须为你的项目生成唯一名称。 可用的格式标识如下： **{DialogueGuid}** ：对话声波的GUID。保证在资产重命名时唯一且稳定。 **{DialogueHash}** ：对话声波的哈希。不保证在资产重命名时唯一或稳定，但与对话名称相结合可能足够唯一。 **{DialogueName}** ：对话声波的名称。不保证在资产重命名时唯一或稳定，但与对话哈希相结合后可能足够唯一。 **{ContextId}** ：情境的ID。保证在其对话声波中唯一。不保证在情境更改时稳定。 **{ContextIndex}** ：其父对话声波中的情境索引。保证在其对话声波中唯一。 |

### 音频

| **分段** | **说明** |
| --- | --- |
| **默认音效类（Default Sound Class）** | 分配到新建音效的 `SoundClass` 。 |
| **默认媒体音效类（Default Media Sound Class）** | 分配到媒体播放器资产的 `SoundClass` 。 |
| **默认音效并行（Default Sound Concurrency）** | 分配到新建音效的 `SoundConcurrency` 。 |
| **默认基础混音（Default Base Sound Mix）** | 在没有其他系统指定过基础混音时要用作基础的 `SoundMix` 。 |
| **VOIP音效类（VOIP Sound Class）** | 要用于VOIP音频组件的音效类。 |
| **VOIP采样率（VOIP Sample Rate）** | 用于IP语音（VOIP）的采样率。 VOIP音频会在接收器端按应用程序的采样率重新采样。 你可以从以下选项中选择： **较低16000 Hz** **正常24000 Hz** |
| **最大并行流送数（Maximum Concurrent Streams）** | 定义可以同时播放的流送音效数（如果播放数量超过此值，将按优先级对其进行排序）。 |
| **全局最小俯仰比例（Global Min Pitch Scale）** | 要用于限制最小俯仰比例的值。 |
| **全局最大俯仰比例（Global Max Pitch Scale）** | 要用于限制最大俯仰比例的值。 |

### 混合

| **分段** | **说明** |
| --- | --- |
| **主子混音（Master Submix）** | 所有音效在路由时都要经过的默认子混音。 输出到音频硬件的根子混音。 |
| **混响子混音（Reverb Submix）** | 所有被设置为使用混响的音效在路由时都要经过的子混音。 |
| **默认音频总线（Default Audio Buses）** | 在初始化 `AudioEngine` 时自动初始化的 `AudioBus` 的数组。 |
| **基础默认子混音（Base Default Submix）** | 如果在子混音发送期间未指定子混音，音频引擎将使用的默认子混音。 |
| **EQ子混音（旧版）（EQ Submix (Legacy)）** | 所有被设置为使用旧版均衡器（EQ）系统的音效在路由时都要经过的子混音 |

### 质量

| **分段** | **说明** |
| --- | --- |
| **质量级别（Quality Levels）** | 音频的质量级别。 |
| **允许在静音时播放（Allow Play when Silent）** | 允许在音量为0时播放音效。 |
| **禁用主EQ（Disable Master EQ）** | 在音频DSP图表中禁用主EQ效果。 |
| *允许中心声道3D平移（Allow Center Channel 3DPanning）** | 启用环绕声空间化计算以包含中心声道。 |
| **停止源数量（Num Stopping Sources）** | 要为“停止”音效预留的最大源数量。 “停止”音效可在DSP渲染中实现快速消退，防止在停止源时出现不连续的情况。 |
| **平移方法（Panning Method）** | 执行非双耳或基于对象的平移时要使用的方法。 你可以从以下选项中选择： **线性（Linear）** **等功率（Equal Power）** |
| **单声道上混法（Mono Channel Upmix Method）** | 单声道源的上混法。 定义单声道如何上混到立体声声道。 你可以从以下选项中选择： **线性（Linear）** **等功率（Equal Power）** **全音量（Full Volume）** |

### 调试

| **分段** | **说明** |
| --- | --- |
| **调试音效（Debug Sounds）** | 只应在非发布版本中打包的音效列表，通常用于调试目的。 |
