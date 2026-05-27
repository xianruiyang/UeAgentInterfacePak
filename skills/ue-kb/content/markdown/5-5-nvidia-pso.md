# 技术说明：修复虚幻引擎 5.5 中 Nvidia 硬件上的 PSO 管理问题

# 技术说明：修复虚幻引擎 5.5 中 Nvidia 硬件上的 PSO 管理问题

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 3315 字符。

## 摘要

在虚幻引擎 5.5 及更高版本中发现了一个严重的稳定性问题，影响了在 Nvidia 硬件上运行的项目，特别是...

## 中文整理

### 概述

虚幻引擎 5.5 及更高版本中发现了一个严重的稳定性问题，影响了在 Nvidia 硬件上运行的项目，尤其是最新的驱动程序版本。该问题源于引擎未释放创建的 PSO，导致着色器堆内存过度分配。现在可以使用代码补丁来解决此问题，该补丁在 5.6 版本中发布，代码为 CL：42109459，Github 提交为：85c7940。建议 5.5 版本的用户手动集成代码补丁，因为 Epic 不会发布针对该版本的进一步修复。

### 受影响的版本

- ✅ 受影响：虚幻引擎 5.5 的所有单点版本 ✅ 受影响：虚幻引擎 5.5 的所有单点版本

### 问题详情

在虚幻引擎 5.5 中，引擎积极创建大量管线状态对象，但这些对象在使用后并未释放，从而耗尽了着色器堆。这种行为导致使用 Nvidia GPU 的系统出现稳定性问题，特别是在使用较新的驱动程序版本时。 Nvidia 驱动程序行为的变化加剧了这个问题，导致受影响的设置崩溃或性能下降。

### 技术根本原因

一旦使用（绑定）着色器，NVIDIA 驱动程序就会为其提交内存，并且在应用程序销毁关联的 PSO 对象之前不会回收它。问题的核心在于 D3D12RHI 模块，特别是它如何管理 PSO 生命周期。

### 解决

现在提供了一个修复程序，可确保正确释放创建的 PSO，从而减少 GPU 内存压力并提高稳定性。此修复已集成到 CL 42109315 和 Github 中的虚幻引擎 5.6 版本中，但无法升级到 5.6 的被许可人可以通过本文附带的补丁来应用该修复。下面将提供有关该补丁的更多信息。虽然此补丁确实捕获了将在 5.6 中发布的修复程序中的大部分功能，但用户应该注意一个关键区别：将计算 PSO 保留在内存中的选项不是补丁的一部分，因为这需要对公共 API 进行更改。需要此功能的用户应通过其首选支持渠道获取帮助。

### 补丁信息

📌 补丁位置：下载 pso-fix.patch 文件，可在此处找到。 🛠️ 集成说明： - 通过您首选的代码修补实用程序应用 pso-fix.patch 文件。通过您首选的代码修补实用程序应用 pso-fix.patch 文件。 - 集成后，重建完整项目以应用更改。集成后，重建完整项目以应用更改。

### 验证步骤

应用补丁后： - 完全重建您的项目。完全重建您的项目。 - 在安装了最新驱动程序的受影响的 Nvidia 硬件上启动您的项目。在安装了最新驱动程序的受影响的 Nvidia 硬件上启动您的项目。 - 监控启动和运行时 PSO 使用期间的稳定性（例如，场景转换或 FX 重的游戏）。监控启动和运行时 PSO 使用期间的稳定性（例如场景转换或 FX 重的游戏）。 - 确认先前的不稳定不再发生。确认之前的不稳定现象不再出现。

### 未来修复

该补丁将包含在虚幻引擎的未来版本中（预计在 5.6 或更高版本中）。计划升级到该版本的项目可能会选择等待正式版本。

### 支持

如需补丁集成或故障排除方面的帮助，请联系 Epic Pro 支持。 - 引擎源

## 相关链接

- [85c7940](https://github.com/EpicGames/UnrealEngine/commit/85c7940523d3605f149cf3c5fca917574a99655b)
- [here](https://epicgames.box.com/s/3ue5dxytnn33hibwugm3nrts3iebs2tx)
- [Overview](https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5#overview)
- [Affected Versions](https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5#affectedversions)
- [Issue Details](https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5#issuedetails)
- [Technical Root Cause](https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5#technicalrootcause)
- [Resolution](https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5#resolution)
- [Patch Information](https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5#patchinformation)
- [Verification Steps](https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5#verificationsteps)
- [Future Fix](https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5#futurefix)
- [Support](https://dev.epicgames.com/community/learning/knowledge-base/DBOL/tech-note-fix-for-pso-management-issue-on-nvidia-hardware-in-unreal-engine-5-5#support)


