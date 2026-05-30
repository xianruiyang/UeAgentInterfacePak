# 技术说明：世界分区空间加载的 Actor 始终加载

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/kjGB/unreal-engine-tech-note-world-partition-spatially-loaded-actors-are-always-loaded

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1828 字符。

## 摘要

本文由 Ryan Bickell 撰写 描述：世界分区 Actor 可以“提升”到网格层次结构的更高级别单元格（覆盖比设置的网格单元格大小更大的区域的单元格），具体取决于它们的...

## 中文整理

### 概览

*本文由 [Ryan Bickell](https://dev.epicgames.com/community/profile/23wL/RyanBickell) 撰写*

### 描述：

世界分区 Actor 可以根据其位置或边界“提升”到网格层次结构的更高级别单元（覆盖比设置的网格单元大小更大的区域的单元），并且当前运行时网格放置将为与网格轴相交的任何单元执行此操作。

### 潜在影响：

[高]：设置为空间加载的 Actor 似乎始终会加载并且永远不会流出，无论流距离或网格单元大小设置如何。它们可能被放置在顶层单元中，导致它们始终被加载，如果是这样，那么它们也不会生成 HLOD。

### 解决方案：

我们计划通过明确的解决方案来解决此问题，但目前，可以调整一些 CVar，这可能有助于缓解此问题： - wp.Runtime.RuntimeSpatialHashUseAlignedGridLevels - wp.Runtime.RuntimeSpatialHashSnapNonAlignedGridLevelsToLowerLevels - wp.Runtime.RuntimeSpatialHashPlaceSmallActorsUsingLocation - wp.Runtime.RuntimeSpatialHashPlacePartitionActorsUsingLocation - 这是从 5.1 中的[更改](https://github.com/EpicGames/UnrealEngine/commit/1c2ecdadeb5f6d1c562df938b7e4b1a7408d7259) 添加的：“添加wp.Runtime.RuntimeSpatialHashPlacePartitionActorsUsingLocation cvar 允许使用其边界枢轴而不是使用其边界将分区参与者放置在网格中，以避免网格升级。” - 注意：如果对此设置进行更改，则需要重建 HLOD。在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案

