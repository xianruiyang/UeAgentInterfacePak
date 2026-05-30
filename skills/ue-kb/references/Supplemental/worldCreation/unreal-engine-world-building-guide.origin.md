# 世界建设指南

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 113813 字符。

## 摘要

本指南提供了每个功能的定义、需要掌握的主题、良好实践和陷阱、限制、特定于使用虚幻引擎的世界分区系统构建世界的用例。

## 中文整理

### 世界建设指南

本指南提供了每个功能的定义、需要掌握的主题、良好实践和陷阱、限制、特定于使用虚幻引擎的世界分区系统构建世界的用例。 **《世界建造指南》还提供包含附加信息的 .PDF 文件，可以[在此处查看/下载](https://epicgames.ent.box.com/s/vxyrkumwog8ikggqzysjvw3jjxojtux3)**

### 变更日志

**v.3 **- 更新了 UE 5.5 和 5.6 的开发以及对良好实践、限制和陷阱的相关更改 - 添加了策略部分，以帮助解决使用世界分区时重复出现的特定问题 **v.2 ** - 更新了 UE 5.2、5.3、5.4 的开发以及对良好实践、限制和陷阱的相关更改

### 功能列表

[世界分区](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#worldpartition) 世界分区是一个自动数据管理和基于距离的关卡流媒体系统，为大世界管理提供完整的解决方案。该系统通过将您的世界存储在分隔为网格单元的单个持久关卡中，消除了以前将大关卡划分为子关卡的需要，并为您提供了一个自动流系统，可以根据与流媒体源的距离加载和卸载这些单元。 [OFPA - 每个 Actor 一个文件](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#ofpa-onefileperactor) 每个 Actor 一个文件 (OFPA) 通过将每个单独的 Actor 保存为外部文件来减少用户之间的重叠，从而无需在更改 Actor 时保存主关卡文件。 [关卡实例和打包关卡 Actor](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#levelinstancesandpackedlevelactors) 关卡实例和打包关卡 Actor 都是“非破坏性”工作流程，允许在同一世界中实例化内容并进行上下文编辑，并具有各自的用例和优点。 [数据层](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#datalayers) 数据层是一个旨在有条件地加载世界数据以供运行时和编辑的系统。 Actor 和 World Partition 定义哪些流逻辑（空间加载、运行时网格和启用流）、数据层充当关卡流的过滤器。 [HLOD - 层次细节层次](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#hlods-hierarchicallevelofdetail(worldpartition)) 层次细节层次 (HLOD) 是一组演​​员的视觉表示，旨在从相当远的距离观看时替换这些演员，并且是自动生成的。 [编辑器和用户体验](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#editorsandux) 特定于世界分区的编辑器、大纲视图和用户体验，例如世界分区编辑器、数据层大纲视图和世界书签。 [世界分区外部的数据流](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#datastreamingoutsideofworldpartition) 数据流也由世界分区外部的其他系统处理，具体取决于...

### 其他资源

[策略](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#strategies) 使用世界分区时帮助解决特定重复问题的不同方法和策略 [生产管道和工作流程](https://dev.epicgames.com/community/learning/knowledge-base/r6wl/unreal-engine-world-building-guide#developmentpipelineandworkflow)其他与生产相关的建议，以提高与世界分区和大型团队合作时的整体稳定性。

### 特点详情

### 世界分区

### WP - 有用的链接

官方公开文档：[https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition-in-unreal-engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/world-partition-in-unreal-engine)

### WP-- 需要掌握的科目

世界构建、自动流媒体、网格设置和升级、演员流媒体设置、流媒体源、数据层、HLOD、关卡实例、打包关卡演员、OFPA、命令行开关、Cook 构建、服务器流媒体、生成流媒体

### WP-- 定义

World Partition 是一个自动数据管理和基于距离的关卡流媒体系统，为大型世界管理提供完整的解决方案。该系统通过将您的世界存储在分隔为网格单元的单个持久关卡中，消除了以前将大关卡划分为子关卡的需要，并为您提供了一个自动流系统，可以根据与流媒体源的距离加载和卸载这些单元。
