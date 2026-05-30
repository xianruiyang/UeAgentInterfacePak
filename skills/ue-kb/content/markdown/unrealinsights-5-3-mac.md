# 技术说明：UnrealInsights 在 5.3 中不会在 Mac 上自动跟踪数据

# 技术说明：UnrealInsights 在 5.3 中不会在 Mac 上自动跟踪数据

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/MLke/unreal-engine-tech-note-unrealinsights-will-not-trace-data-automatically-on-mac-in-5-3

## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 1103 字符。

## 摘要

描述：5.3 中发现了一个问题，这意味着在 Mac 上启动编辑器时不会自动生成跟踪数据 潜在影响：[有限] 无法从 e… 获得 Insights 跟踪数据。

## 中文整理

### 概览

**描述：** 5.3 中发现了一个问题，这意味着在 Mac 上启动编辑器时不会自动生成跟踪数据 **潜在影响：** **[有限]** Mac 上的编辑器会话将无法提供 Insights 跟踪数据 **解决方案：** UnrealInsights 依赖于 UnrealTraceServer 后台进程。在 Mac 上，编辑器当前不会自动启动此过程。您需要在启动编辑器之前手动运行 Insights 工具一次（跟踪服务器将在 Unreal Insights 关闭后继续运行），以便分析能够正常工作。您可以通过在 Engine/Binaries/Mac 中找到 UnrealInsights 可执行文件并打开它，或者从编辑器启动 UnrealInsights，然后重新启动编辑器来完成此操作。可以在[此处](https://issues.unrealengine.com/issue/UE-188183)跟踪此问题的状态。

