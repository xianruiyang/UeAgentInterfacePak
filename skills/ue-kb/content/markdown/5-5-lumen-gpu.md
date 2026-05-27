# 🛠️ 技术说明：修复虚幻引擎 5.5 中 Lumen 中的 GPU 崩溃问题

# 🛠️ 技术说明：修复虚幻引擎 5.5 中 Lumen 中的 GPU 崩溃问题

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 1998 字符。

## 摘要

虚幻引擎 5.5 中已发现 GPU 崩溃问题，该问题影响使用 Lumen 的项目，并且主要影响英特尔硬件上的项目。问题源于一个大...

## 中文整理

### 🛠️ 技术说明：修复虚幻引擎 5.5 中 Lumen 中的 GPU 崩溃问题

### 概述

虚幻引擎 5.5 中已发现 GPU 崩溃问题，该问题影响使用 Lumen 的项目，主要是在英特尔硬件上。该问题源于 ScreenProbeConvertToIrradianceCS 中发散分支内的组障碍。 CL#42412951 (215041) 可用于修复该问题。

### 受影响的版本

✅ 受影响：虚幻引擎 5.5 的所有单点版本

### 公开发行

https://issues.unrealengine.com/issue/UE-273972

### 技术根本原因

在虚幻引擎 5.5 中，Lumen ScreenProbeConvertToIrradianceCS 计算着色器在发散分支内包含组屏障，这是规范所不允许的，该规范规定：线程组发散分支内对此函数 (GroupMemoryBarrierWithGroupSync) 的调用行为未定义。

### 解决

现在提供了一个修复程序，可确保不再从发散分支内部调用 GroupMemoryBarrierWithGroupSync。此修复已集成到虚幻引擎 5.6 版本的 CL#42412951 (215041) 中。 🛠️ 集成说明： - 通过您首选的代码集成实用程序（p4、gitcherry-pick 等）集成 CL#42412951 (215041) 通过您首选的代码集成实用程序（p4、gitcherry-pick 等）集成 CL#42412951 (215041) - 集成后，重建完整项目以应用更改。集成后，重建完整项目以应用更改。

### 验证步骤

集成变更列表后： - 完全重建您的项目。完全重建您的项目。 - 在受影响的英特尔硬件或其他受影响的硬件上启动您的项目，并安装最新的驱动程序。在受影响的英特尔硬件或其他受影响的硬件上启动您的项目，并安装最新的驱动程序。 - 监控稳定性并确认之前的不稳定不再发生。监控稳定性并确认之前的不稳定不再发生。

### 未来修复

此修复包含在虚幻引擎 5.6 中。计划升级到该版本的项目可能会选择等待正式版本。

### 支持

如需补丁集成或故障排除方面的帮助，请联系 Epic Pro 支持。 - 引擎源代码 - GPU 崩溃 - 技术说明

## 相关链接

- [215041](https://github.com/EpicGames/UnrealEngine/commit/2150414522cc0922d9fe4b188787ff96132bd08a)
- [https://issues.unrealengine.com/issue/UE-273972](https://issues.unrealengine.com/issue/UE-273972)
- [🛠️ Tech Note: Fix for GPU Crash in Lumen in Unreal Engine 5.5](https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5#%F0%9F%9B%A0%EF%B8%8Ftechnote:fixforgpucrashinlumeninunrealengine55)
- [Overview](https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5#overview)
- [Affected Versions](https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5#affectedversions)
- [Public Issue](https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5#publicissue)
- [Technical Root Cause](https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5#technicalrootcause)
- [Resolution](https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5#resolution)
- [Verification Steps](https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5#verificationsteps)
- [Future Fix](https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5#futurefix)
- [Support](https://dev.epicgames.com/community/learning/knowledge-base/6XP2/tech-note-fix-for-gpu-crash-in-lumen-in-unreal-engine-5-5#support)


