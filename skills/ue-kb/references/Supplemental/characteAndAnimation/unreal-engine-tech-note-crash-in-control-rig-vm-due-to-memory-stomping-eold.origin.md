# 技术说明：由于内存占用，Control Rig 虚拟机崩溃

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/EoLd/unreal-engine-tech-note-crash-in-control-rig-vm-due-to-memory-stomping

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 878 字符。

## 摘要

文章由 Euan C 撰写。摘要：由于内存占用问题，在非编辑器版本中发现 Control Rig VM 崩溃。该问题在 FMallocBinned2::GetAllocationSizeExternal() 中重现为致命日志：“FMalloc...

## 中文整理

### 概览

*文章由 [Euan C.](https://dev.epicgames.com/community/profile/lxJJ/euancarmichael) 撰写* **摘要：** 由于内存占用问题，在非编辑器版本中发现 Control Rig VM 崩溃。该问题在 FMallocBinned2::GetAllocationSizeExternal() 中重现为致命日志：“FMallocBinned2 尝试 GetAllocationSizeExternal 无法识别的块”。 **潜在影响：** 中等：使用 Full Body IK 解算器节点的 Control Rig 图的某些配置将在非编辑器版本中崩溃。 **解决方案：** 该问题已在 CL 16020071 中修复。这些更改可以在本地集成。它们也将包含在 4.27 版本中。 UE版本
