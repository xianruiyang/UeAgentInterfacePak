---
title: "多播分析服务商"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/multicast-analytics-provider-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "游戏运行的性能分析", "多播分析服务商"]
---

# 多播分析服务商

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 游戏运行的性能分析 / 多播分析服务商

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/multicast-analytics-provider-for-unreal-engine

多播服务商向多个服务商发送分析事件。这可让你轻松使用多个分析服务商，因为它可将调用轮流交给每个注册的分析服务商， 无需你手动执行此分派工作。拥有多个分析服务商是可取的做法，因为每个服务商 拥有不同的优势和劣势。通过使用多个服务商，你可以获取运营应用程序业务所需的所有功能。

## 配置

配置服务商非常直接。只需要知道你要发送数据至的服务商列表即可。此列表的以逗号分隔的列表形式提供， 其中列出了服务商的模块名称。在以下示例中，AnalyticsMulticast服务商被指定为应用程序的默认服务商。之后，它采用上述逗号分隔的列表形式指定 发送数据至的服务商列表。对于所有分析服务商，配置数据将保存到 `DefaultEngine.ini`文件。

[Analytics] ProviderModuleName=AnalyticsMulticast ProviderModuleNames=FileLogging,IOSFlurry,IOSApsalar
