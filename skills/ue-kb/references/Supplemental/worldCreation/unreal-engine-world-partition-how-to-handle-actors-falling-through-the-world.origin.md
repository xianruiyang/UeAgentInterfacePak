# 世界分区 - 如何处理掉入世界的演员

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/4yOE/unreal-engine-world-partition-how-to-handle-actors-falling-through-the-world

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1462 字符。

## 摘要

世界分区 - 如何处理从世界中坠落的 Actor 本文由 Ryan B 撰写，当世界分区单元格的加载顺序导致它们坠落时，如何处理为我的演员激活物理...

## 中文整理

### 概览

*本文由 [Ryan B](https://dev.epicgames.com/community/profile/23wL/RyanBickell) 撰写* 当世界分区单元格的加载顺序导致演员掉落到世界中时，如何处理激活物理效果？为了解决角色在物理激活之前依赖其他角色加载的问题，应先将 FWorldPartitionStreamingQuerySource 与 UWorldPartitionStreamingSourceComponent::IsStreamingCompleted 一起使用，以验证给定区域是否已完全激活。 UMassRepresentationSubsystem::IsCollisionLoaded 中可以看到这样的示例：

```cpp
bool UMassRepresentationSubsystem::IsCollisionLoaded(const FName TargetGrid, const FTransform& Transform) const
{
	if (!WorldPartitionSubsystem)
	{
		// Assuming that all collisions are loaded if not using WorldPartition.
		return true;
	}

	// @todo optimize by doing one query per cell
	// Build a query source
```

使用 FWorldPartitionStreamingQuerySource，您可以向 IsStreamingCompleted 提供位置、半径甚至特定数据层等信息，当 IsStreamingCompleted 返回 true 时，演员的物理功能已准备好被激活。在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案

