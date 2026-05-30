# 关卡流媒体连接指南

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/tutorials/qpll/unreal-engine-level-streaming-hitching-guide

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 80643 字符。

## 摘要

用于识别 Unreal Insights 捕获中的常见级别流媒体故障的指南以及解决这些问题的提示和资源链接。故障是指游戏线程或渲染线程上的任何工作导致帧超出其时间预算，从而妨碍平滑的帧速率。关卡流处理涉及许多任务，包括环境和游戏角色加载、物理和渲染设置、垃圾收集和游戏代码，每项任务都可能导致帧超出预算。

## 中文整理

### 一、简介

加载和卸载地图内容时，由于多种原因可能会出现故障。本指南旨在帮助您诊断关卡流式传输故障的原因：当任何帧超出其时间预算时，这是通过世界分区流进或流出世界部分的直接或间接结果。尽管本指南涵盖了从开发之初就适用的良好实践，但其主要重点是帮助您对项目中当前遇到的问题进行分类和解决。我们将查看 Unreal Insights 捕获的屏幕截图，帮助您识别常见的嫌疑点，剖析导致计算成本的因素，并检查现有的虚幻引擎解决方案或行业标准方法来提高性能。第 2 部分涵盖**常见建议**：值得注意的主题和功能。第 3 节介绍**分析注意事项**：了解在哪些情况下分析结果可能不具有代表性。在第 4 节中，我们**仔细研究游戏项目遇到的关卡流故障**。我们不会介绍如何优化每帧发生的任务；仅由关卡流触发的故障。有关更多优化主题的文章，请查看 [虚幻性能优化学习路径](https://dev.epicgames.com/community/learning/paths/Rkk/unreal-engine-unreal-performance-optimization-learning-path) 和 [技术开发人员关系](https://dev.epicgames.com/community/profile/organization/wqN3/tdr-3251a757) 团队关于 Epic 开发人员的文章社区。 **引擎版本** 本文基于 UE 5.7。某些功能和选项在较旧的引擎版本中可能不可用。快速概述最近与关卡流相关的重大变化： - UE 5.6 对关卡流进行了重要优化，包括实验功能：[异步物理状态创建]（https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#:~:text=un%2Dnecessary%20calls-,Asynchronous%20physicals%20state%20creation,-/destruction）和[快速Geo](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#:~:text=s.PriorityLevelStreamingActorsUpdateExtraTime-,Fast%20Geometry%20Streaming%C2%A0,-The%20FastGeo%20Streaming)。默认情况下，实验性功能处于禁用状态。 - UE 5.5 通过利用选择性 FlushAsyncLoading 使 UWorld::BlockTillLevelStreamingCompleted 更快。例如，当玩家太接近仍在加载的关卡时，世界分区会根据流性能回退到阻塞关卡流。 - UE 5.2 引入了 [PSO 预缓存](https://dev.epicgames.com/documentation/en-us/unreal-engine/pso-precaching-for-unreal-engine) 作为选择加入功能。 UE 5.3 默认启用它。案件覆盖率不断提高。 - UE 5.2 引入了[程序内容生成 (PCG)](https://dev.epicgames.com/documentation/en-us/unreal-engine/procedural-content- Generation-overview) 框架作为实验。自 UE 5.7 起，PCG 已做好生产准备。 - UE 5.1 通过 ZenLoader 的选择性 FlushAsyncLoading 同步加载游戏代码中的资源 [少得多](https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-5.1-release-notes?application_version=5.1#:~:text=When%20sync%20loading%20a%20package)。在关卡流传输期间，最好避免同步加载。

![教程图片](assets/unreal-engine-level-streaming-hitching-guide/image-01.jpg)

### 2. 共同建议

在深入讨论特定主题之前，每个团队都必须了解以下常见建议。

### 文档和演示文稿

建议您在分析和优化时阅读和观看以下资源： - [虚幻性能优化学习路径](https://dev.epicgames.com/community/learning/paths/Rkk/unreal-engine-unreal-performance-optimization-learning-path)：Epic Games 的许多优化教程的集合。 - [The Great Hitch Hunt](https://dev.epicgames.com/community/learning/tutorials/6XW8/unreal-engine-the-great-hitch-hunt-tracking-down-every-frame-drop)：一场 Unreal Fest 演讲，涵盖了造成卡顿的许多原因，包括关卡流卡顿。 - [《巫师 4 UE5 技术演示中密集世界的流媒体改进》](https://www.youtube.com/watch?v=BdopUm1_1_E)：与 [CD Projekt Red](https://www.cdprojektred.com/en) 合作的 Unreal Fest 演讲，讨论了您应该考虑提高关卡流媒体性能的功能，包括 FastGeo 和统一流媒体预算。 - [环境性能优化](https://www.youtube.com/watch?v=ZRaeiVAM4LI)：Inside Unreal 直播，从技术艺术的角度提供了无数技巧，其中一些（LOD 和合并 Actor）与关卡流性能相关。 - [关卡流媒体深入探究](https://dev.epicgames.com/community/learning/knowledge-base/qB5K/unreal-engine-level-streaming-deep-dive)：UE的关卡流媒体系统、流媒体状态和调试技巧的说明。 - [世界构建指南](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide)：一篇包含引擎历史、快速入门指南和世界构建工具良好实践的文章。 - [分析游戏内存和性能](https://dev.epicgames.com/community/learning/tutorials/opWW/unreal-engine-profiling-game-memory-and-performance)：一篇包含许多常规分析技巧的文章。 - [有目的的分析：来自真实虚幻项目的性能课程](https://dev.epicgames.com/community/learning/tutorials/qEzo/unreal-engine-profiling-with- Purpose-performance-lessons-from-a-real-unreal-project)：Unreal Fest 上展示的示例分析会话。 - [UE5 中的碰撞数据：管理碰撞设置和查询的实用技巧](https://www.youtube.com/watch?v=xIQI6nXFygA)：[Studio Gobo](https://www.studiogobo.com/) 的有关优化碰撞设置的 Unreal Fest 演示。

### 洞察渠道

将足够的相关数据捕获到 Unreal Insights 跟踪中对于诊断故障非常重要。以下命令行参数将启用必要的通道来捕获本文中讨论的问题： -trace=default,counter,stats,file,loadtime,assetloadtime,task,chaoslocks,contextswitch [context switch](https://dev.epicgames.com/documentation/en-us/unreal-engine/context-switches-in-unreal-engine-5) 通道可让您查看线程何时没有获得 CPU 周期。要捕获 Windows 上的上下文切换，您必须以管理员身份运行 UE 应用程序。否则，请禁用上下文切换通道以防止日志垃圾邮件。

### 关卡创建

团队必须决定一种以高性能方式表示静态网格物体的方法。当您有数千个网格体时，关卡中每个网格体的 StaticMeshActor 将不会执行。大量加载它们的效率很低，因为 StaticMeshActor 和 StaticMeshComponent 都是 UObject，会带来开销。对于较大的级别，请用更有效的表示形式替换它们。有一些解决方案可以在编辑时以不同的方式表示网格，在烹饪时转换它们，或者在运行时按程序生成它们。解决方案包括 World Partition 运行时单元转换器（包括 FastGeo）、Packed Level Actors、Foliage 工具和运行时 PCG。分层细节层次网格 (HLOD) 是一种将远处的静态环境网格组合成更少网格的方法。 UE 提供了通过 commandlet 生成这些的方法；有关此信息，请参阅 [HLOD 文档](https://dev.epicgames.com/documentation/en-us/unreal-engine/hierarchical-level-of-detail-in-unreal-engine)。 UE 5.6+：考虑 **FastGeo（实验性）** 在烹饪时转换环境静态网格物体，以大幅减少对象数量，从而改善异步加载时间、物理和渲染状态创建时间以及垃圾收集时间。

### 框架预算

UE具有各种时间分片系统：执行任务直到超出某些配置的时间预算。其余任务在后面的帧中处理。关卡流传输期间时间切片任务的示例包括组件 RegisterComponent() 调用、actor BeginPlay() 调用和对象 PostLoad() 调用。 **超出预算：** 由于整个 UE 实施时间切片的方式，当使用整个预算时，最后一个任务预计会稍微超出预算。每当这些功能对单个参与者或组件来说成本高昂时，无论是由于自定义游戏逻辑还是处理大数据，都可能导致时间切片系统显着超出其预算。本文通篇给出了示例。确定每个对象的时间限制并监控您的游戏内容是否不超过此限制非常有用。例如，强制执行 actor BeginPlay() 的最大允许运行时间。 **流式传输的统一时间预算：** s.AsyncLoadingTimeLimit 和 s.LevelStreamingActorsUpdateTimeLimit 是与关卡流式传输相关的游戏线程任务的两个可配置时间预算。 UE 5.6 引入了一项选择加入的实验性功能，允许任一任务利用另一个任务的未使用时间。这使得未使用的游戏线程时间更少，并且与固定预算相比可以更快地完成关卡流。要启用，请设置 cvar s.UseUnifiedTimeBudgetForStreaming 1。还有更多可配置设置，请参阅[世界构建指南](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#:~:text=Shared%20Time%20Budget%20for%20ProcessAsyncLoading)了解概述。
