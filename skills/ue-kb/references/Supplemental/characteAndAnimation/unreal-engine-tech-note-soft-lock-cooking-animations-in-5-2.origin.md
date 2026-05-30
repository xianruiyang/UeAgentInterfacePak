# 技术说明：5.2 中的软锁烹饪动画

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/zeXJ/unreal-engine-tech-note-soft-lock-cooking-animations-in-5-2

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1225 字符。

## 摘要

描述：5.2 版本中发现了一个错误，该错误可能会导致 UAnimSequence::IsCachedCookedPlatformDataLoaded 中出现罕见的软锁定。处理以前的动画的骨骼轨迹时会出现此问题......

## 中文整理

### 概览

**描述：** 5.2 版本中发现了一个错误，该错误可能会导致 UAnimSequence::IsCachedCookedPlatformDataLoaded 中出现罕见的软锁定。处理先前从骨架中删除的动画的骨骼轨迹时会出现此问题。 **潜在影响：** **[有限]** 烹饪偶尔会导致软锁 **解决方案：** 此问题将在 5.3 中修复。同时，我们建议在升级到 5.2 之前保存动画序列，以确保它们已针对已删除的任何骨骼轨迹进行更新。升级后，需要应用[以下代码更改](https://github.com/EpicGames/UnrealEngine/commit/a3e8a1d2fc08c04186ca2924f7b4bc20b0d46590)以避免该问题：

```cpp
==== //UE5/Release-5.2/Engine/Plugins/Animation/AnimationData/Source/AnimationData/Private/AnimSequencerDataModel.h#2 (text) ====

@@ -121,6 +121,12 @@
 	{
 		EvaluationLock.Lock();
 	}
+
+	virtual bool TryLockEvaluationAndModification() const override final
+	{
+		return EvaluationLock.TryLock();
```
