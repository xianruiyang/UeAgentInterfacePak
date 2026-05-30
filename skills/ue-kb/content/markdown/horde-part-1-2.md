# Horde 的实用调试技巧 (Part 1/2)

# Horde 的实用调试技巧 (Part 1/2)

Source file: `unreal-engine-practical-debugging-tips-for-horde.origin.md`.

This document was split during ue-kb import to keep source chunks buildable.

## 来源与状态

- 原始 URL：https://dev.epicgames.com/community/learning/knowledge-base/oWG6/unreal-engine-practical-debugging-tips-for-horde
## 运行时分类

- 类型：图文教程
- 判断：API 未识别到核心视频信号，可整理正文约 42836 字符。
## 摘要

Horde 的实用调试技巧以及一般程序大纲。
## 中文整理
### 先决条件

1. 对 [ASP.net](http://asp.net/) 服务有较高的了解 1. 了解 [MVC](https://dotnet.microsoft.com/en-us/apps/aspnet/mvc) 的概念 2. 有基本的 Horde 服务器和代理设置 3. 了解现有的 Horde [GitHub文档](https://github.com/EpicGames/UnrealEngine/tree/5.6/Engine/Source/Programs/Horde/Docs)，以及相应的[虚幻引擎文档](https://dev.epicgames.com/documentation/en-us/unreal-engine/horde-in-unreal-engine)。 1. *（可选）* 查看 Horde 文档的 [Glossary.md](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Docs/Glossary.md)。 4.（*可选*）[Remote Worker API](https://docs.google.com/document/d/1s_AzRRD2mdyktKUj2HWBn99rMg_3tcPvdjx3MPbFidU/edit?tab=t.0) - 这是 Horde 如何与代理相关的基本核心概念 5. *（可选）* 如果您尝试以下操作，请了解 JavaScript (TypeScript) 和 React 的概念调试仪表板中的问题。
### 高级调试策略

调试 Horde 时，删除尽可能多的参数是有帮助的，并扩大调试工作中涉及的系统组**仅在必要时**。对于任何基于服务器代理的系统，如果可能的话，将问题空间沿着**环境**和**应用程序**特定问题一分为二非常重要。 1. **如果问题不一致...** 1. 通过删除与基础设施相关的工具来排除环境因素 1. 负载均衡器 2. 数据包监控软件 3. 病毒扫描程序 1. 与存储服务吞吐量问题特别相关 2. 与使用中的文件吞吐量问题特别相关 4. 容器化部署 5. Perforce 代理或边缘服务器 2. 在电子表格中绘制错误以查看是否存在形成的模式 1. 涉及问题的代理（及其操作系统配置） 1. 使用 **{HORDE_URL}/agents** 视图对代理进行内省 1. 是否存在需要更彻底检查的问题代理？ 2. 问题发生时间 1. 这段时间是否有计划任务发生？ IT 驱动的活动？ 3. 评估 [Windows 事件查看器](https://learn.microsoft.com/en-us/shows/inside/event-viewer)（或相关）以查看错误期间是否出现环境警告或错误 1.（*相关*）检查代理或服务器内存和 CPU 负载以查看错误期间是否存在可疑模式 2.（*相关*）检查网络使用情况以查看错误期间是否存在可疑模式 3. （*相关*）检查 Process Explorer（或相关）以查看构建工具链或 Unreal 中的悬空进程是否间歇性地导致文件锁定或资源争用 2. **如果问题是确定性的，则隔离参与组件的数量最少** 1. 对于服务或配置问题 1. 尝试在 **HordeServer.*.Tests** 中练习场景 1. 有足够的示例说明如何模拟集合、与服务和控制器交互、生成配置等。 2. 如果它在当前实例（即 MongoDB）中存在的状态上运行效果最佳，**使用 [Swagger](https://swagger.io/) **(*HORDE_URL/swagger/index.html*)** 或 **使用 **[Postman](https://www.postman.com/)** 执行 API 端点 1. 您还可以附加 Visual Studio 调试器 2. 对于与代理步骤执行相关的问题，请查看是否可以将问题隔离到叶操作1. 日志包含有关构建图调用期间确切环境变量状态的大多数详细信息 愿望应该始终是使用日志（服务器和代理 + 衰减冗长）、Horde 仪表板视图（**HORDE_URL/Agents**、**HORDE_URL/serverstatus**）和 **HORDE_URL/swagger/index.html** 来缩小与问题相关的组件范围。本知识库文章的后续部分将描述更高级别的服务器组件及其功能**，以便您可以将症状映射到较小的系统集**。本文还将概述“使用 Visual Studio 设置本地服务器和代理+附加调试器”或“通过 IP 连接到 Intranet Horde Server”的最后手段。
### 部落代理和服务器状态

能够内省部落代理和服务器状态以追踪环境问题和应用程序问题非常重要。为此，收集正确的日志、减少其冗长性以及了解如何收集所有相关部分的性能和跟踪数据至关重要。
### 基线上下文

当开始调查部落问题时，获取基线信息非常重要： - 服务器和代理日志。足够的历史记录和日志上下文窗口很重要 - 问题通常是日志中发生的事件的结果，而不仅仅是错误行 - Horde Installer 上下文 - 您使用的是 Docker 映像还是 Windows 安装程序？安装程序是什么版本？ - 引擎的确切版本是什么？ Horde 服务器和代理确实与 EpicGames.* C# 命名空间有一些耦合，这是共享的。在极少数情况下，Horde Server & Agent **与** EpicGames.* C# 库的安装程序版本不匹配可能会导致问题。 - 后续：这是一个普通的 5.X 版本，还是一个具有项目分歧的变体？如果是后者，上述观点就更值得反思。 - 这是在什么操作系统环境上执行的？ Linux/Windows？ - 如果适用，此操作在什么云环境上执行？基线上下文越完整，就越容易理解 Horde 的哪些组件（或其依赖项）可能出现故障或配置错误。
### 日志
### 视窗

1. **C:\ProgramData\Epic\Horde\Server\Logs\** - 提供日期隔离日志 2. ***C:\ProgramData\Epic\Horde\Agent\*** - 此处提供所有会话日志 3. *C:\Users\[user]\AppData\Local\Epic Games\Unreal Toolbox*
### 配置日志详细程度

1. 通过应用程序设置控制： - [Serilog](https://github.com/serilog/serilog/wiki/configuration-basics)

**appsettings.json 中的 Serilog 配置**

```
{
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "MongoDB": "Warning",
        "Redis": "Warning",
        "HordeServer.Authentication": "Warning",
        "HordeServer.Issues.IssueService": "Debug",
        "HordeServer.Issues.IssueTagService": "Debug",
```

*覆盖* JSON 对象包含键值对，用于指定不同命名空间限定符的日志记录级别。 Key 指的是完全限定的类名（包括命名空间）。
### 事件与追踪

通过事件和跟踪检查代理和服务器的运行状况可以帮助诊断系统问题。您可以通过 **HORDE_URL/agents** URL 查看所有代理： 您可以通过 **HORDE_URL/agents?agentId=AGENT_ID** URL 查看各个代理：

![代理租赁视图。](assets/unreal-engine-practical-debugging-tips-for-horde/image-01.jpg)

在此视图中，您可以： 1. 远程桌面以获取完整的上下文 1. 查看租约（和相应的日志）以评估错误模式 2. 遥测以概览 CPU 和 RAM 使用情况 1. 审核以查看折叠视图

![代理遥测时间轴视图。](assets/unreal-engine-practical-debugging-tips-for-horde/image-02.jpg)

对于服务器，您可以远程执行完整的 cpu 跟踪和内存转储，以便反思与 **进程本身** 相关的性能问题和问题。 1. **CPU **/api/v1/debug/profiler/cpu/start 后跟 /api/v1/debug/profiler/cpu/stop & /api/v1/debug/profiler/cpu/download 2. **内存** /api/v1/debug/profiler/mem/snapshot 这两个都使用 [DotTrace](https://www.jetbrains.com/guide/tags/dottrace/) 库来分析服务器。
### 应用程序配置、切换和选项

Horde 有许多可配置点，可以帮助调整体验、启用功能或切换不同模式。能够以直观的方式与配置系统交互非常重要（特别是当有多种方法来配置 ASP.NET 服务时 - 环境变量、应用程序设置和许多 Horde *.json 文件）。
### 应用程序配置

Horde 遵循 [ASP.net](http://asp.net) 配置的基本原则。可以在[此处](https://learn.microsoft.com/en-us/aspnet/core/fundamentals/configuration/?view=aspnetcore-9.0)观察基本原理。
### 应用程序设置 JSON

[Appsettings.json](https://learn.microsoft.com/en-us/iis-administration/configuration/appsettings.json) 是将配置注入 Horde（服务器和代理）的最标准方法。部落官方文档描述了如何在部落上下文中完成此操作的详细信息。 1. [服务器](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Docs/Deployment/Server.md#general) 2. [代理](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Docs/Deployment/Agent.md#general)

**服务器的 appsettings.json**

```
{
    "Horde":
    {
        // Don't use shared system-wide folders for storing data
        "Installed": false,

        // Don't allow agents to try to upgrade; the assembly was built locally
        "EnableUpgradeTasks": false,

        // Don't allow conforms to run
```
### 环境变量

[Export Horde__PROPERTY](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Docs/Deployment/Server.md?plain=1#L81) 是环境变量的标准注入语法。您可以使用它来设置部落服务器的属性（将促使部落服务器重新启动）。主要入口点（带有感兴趣的代码行），您可以在其中调试和检查已解析的配置： 1. ****[ServerApp.cs](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/HordeServer/ServerApp.cs#L4)- IConfiguration configuration = builder.Build 2. **[AgentApp.cs](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/HordeAgent/AgentApp.cs#L4)** - configuration = CreateConfig(...) 在这里您可以看到配置的层次结构如何应用于应用程序使用的配置。这是一个常见的问题点，其中应用了意外的覆盖。
### 有用的调试选项

1. OidcDebugMode ([ServerSettings.cs](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/HordeServer/ServerSettings.cs#L4)) - 调试模块，记录 JWT 令牌无法验证的原因 2. EnableDebugEndpoints ([ServerSettings.cs](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/HordeServer/ServerSettings.cs#L4)) - 启用 DebugController 端点 3. MongoReadOnlyMode ([ServerSettings.cs](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/HordeServer/ServerSettings.cs#L4)) - 以只读模式访问数据库；没有创建索引并且对于内省产品数据库有用。为了安全起见，请与 ReadOnly 用户一起使用。 4. UseLocalStorageClient ([AgentSettings.cs](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/HordeAgent/AgentSettings.cs#L4)) - 将代理存储切换到本地而不是存储服务。这在诊断存储服务问题时非常有用。 5. EnableGcVerification ([StorageConfig.cs](https://github.com/EpicGames/UnrealEngine/blob/5.6/Engine/Source/Programs/Horde/Plugins/Storage/HordeServer.Storage/StorageConfig.cs#L4)) - 允许您为存储服务运行 GC，而不删除任何内容。

