# 世界分区 - 服务器流媒体

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/Xdj9/unreal-engine-world-partition-server-streaming

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1320 字符。

## 摘要

世界分区 - 服务器流式处理 本文由 Ryan B 撰写 UE 5.1 引入了一个新的 CVar，wp.Runtime.EnableServerStreaming，使服务器仅流式传输播放器源，而不是加载所有内容。替代…

## 中文整理

### 概览

*本文由 [Ryan B](https://dev.epicgames.com/community/profile/23wL/RyanBickell) 撰写* UE 5.1 引入了新的 CVar，wp.Runtime.EnableServerStreaming，让服务器仅流式传输玩家源，而不是加载所有内容。尽管此 CVar 是作为我们的服务器流计划的第一个实现添加的（请参阅我们的[世界建筑功能路线图](https://udn.unrealengine.com/s/article/World-Building-Features-Roadmap)），但应该注意的是，我们尚未积极致力于完成此功能，并且应将其视为实验性的（可能会发生变化，并且几乎没有支持）。 wp.​​Runtime.EnableServerStreaming 选项： - 0 - 禁用（默认） - 1 - 启用 - 2 - 启用（仅限 PIE） 此外，是否允许服务器流式输出级别的选项可以由 wp.Runtime.EnableServerStreamingOut 控制（仅在启用服务器流式传输时有效）。 - 注意：这些 CVar 不会对受运行时数据层影响的世界分区流单元产生任何影响。在[知识库！](https://forums.unrealengine.com/docs) 中获取更多答案

