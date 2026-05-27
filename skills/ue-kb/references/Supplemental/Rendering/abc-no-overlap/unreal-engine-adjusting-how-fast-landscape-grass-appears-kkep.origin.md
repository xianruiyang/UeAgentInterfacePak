# 调整景观草出现的速度

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/KKep/unreal-engine-adjusting-how-fast-landscape-grass-appears

## 运行时分类

- 类型：图文教程
- 判断：运行时未识别到核心视频信号，可整理正文约 2557 字符。

## 摘要

调整景观草出现的速度 Ryan B 撰写的文章。如果您发现景观草需要很长时间才能出现，有 3 个主要的 C...

## 中文整理

### 概览

文章由 Ryan B 撰写。如果您发现景观草需要很长时间才能出现，有 3 个主要的 CVar 控制草出现的速度，您应该尝试调整以下内容：

### 草.TickInterval

指定给定景观代理相对于草地的两次更新之间的时间间隔（帧数）。这意味着每个景观代理将每 n 帧更新一次（n =grass.TickInterval）。默认情况下，grass.TickInterval 为 1，每个景观代理将每帧更新一次。在撰写本文时，Fornite 使用的草刻度间隔为 10。

### 草.MaxAsyncTasks

限制在一次草滴答答期间可以生成多少个异步任务来生成草。由于草地，景观组件在给定帧期间未更新。TickInterval 不会生成任何任务。这些任务深深嵌套在 ALandscapeProxy::UpdateGrass (LandscapeGrass.cpp) 的 4 个独特的循环中，并且根据草类型的数量、草品种和分段的数量，一旦异步任务完成，只有少数任务可能被允许生成 HISM（分层实例静态网格物体）组件，由于grass.TickInterval，这很可能至少在“一个时钟周期后”发生。在 ALandscapeProxy::UpdateGrass (LandscapeGrass.cpp) 中： for (ULandscapeGrassType* GrassType : LandscapeGrassTypes) { ... for (auto& GrassVariety : GrassType->GrassVarieties) { ... for (int32 SubX = 0; SubX < SqrtSubsections; SubX++) { for (int32 SubY = 0; SubY <SqrtSubsections;

### 草.MaxCreatePerFrame

设置每帧可以创建的最大 HISM 组件。默认值为 1，因为创建组件的成本很高。这也意味着，在所有景观代理、草地类型、草地品种和分区中，每帧只允许创建一个 HISM 组件。这可能会阻止该帧生成任何内容，从而严重延迟给定草模型的处理。如需进一步说明，请查看 LandscapeGrass.cpp 中的这部分代码： if (!bRebuildForBoxes && !bForceSync && (InOutNumCompsCreated >= GGrassMaxCreatePerFrame || AsyncFoliageTasks.Num() >= MaxTasks)) { continue; // 每帧一个，但我们仍然想要触及现有的，并且我们必须进行重建，因为我们更改了标签} 当存在多种草类型或品种时，这些因素的组合可以极大地限制草出现的速度，特别是在具有许多景观代理的较大景观上，并且是调查草出现较晚的良好起点。请参阅知识库了解更多信息。 - 虚幻引擎

## 相关链接

- [Knowledge Base](https://forums.unrealengine.com/docs?category=)
- [grass.TickInterval](https://dev.epicgames.com/community/learning/knowledge-base/KKep/unreal-engine-adjusting-how-fast-landscape-grass-appears#grasstickinterval)
- [grass.MaxAsyncTasks](https://dev.epicgames.com/community/learning/knowledge-base/KKep/unreal-engine-adjusting-how-fast-landscape-grass-appears#grassmaxasynctasks)
- [grass.MaxCreatePerFrame](https://dev.epicgames.com/community/learning/knowledge-base/KKep/unreal-engine-adjusting-how-fast-landscape-grass-appears#grassmaxcreateperframe)

