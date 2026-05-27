---
title: "检测游戏"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/instrumenting-your-game-with-analytics-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "游戏运行的性能分析", "检测游戏"]
---

# 检测游戏

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 游戏运行的性能分析 / 检测游戏

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/instrumenting-your-game-with-analytics-in-unreal-engine

> [!WARNING]
> 下文的介绍主要针对早期版本的虚幻引擎。在虚幻引擎5中，iOS Apsalar不再可用。但这些介绍仍适用于其他分析框架。

捕获玩家滞留数据的第一步是为游戏注册分析服务商。这可通过项目的 `DefaultEngine.ini`文件完成。你必须注册一个默认服务商。或者，你也可以针对游戏的不同构建类型（开发、测试和生产）注册不同的服务商和帐户详情。下面是配置Apsalar插件的示例：

```
	[Analytics]	ProviderModuleName=IOSApsalar	ApiKey=YourAnalyticsKey1	ApiSecret=YourAnalyticsSecret1	SendInterval=60 	[AnalyticsDevelopment]	ApiKey=YourAnalyticsKey2	ApiSecret=YourAnalyticsSecret2	SendInterval=60 	[AnalyticsTest]	ApiKey=YourAnalyticsKey3	ApiSecret=YourAnalyticsSecret4	SendInterval=60
```

`[Analytics]`部分是使用的默认项，你应在这里设置默认服务商模块的名称。在以上示例中，它被设置为属于4.5版本一部分的IOSApsalar插件。`ApiKey` 和 `ApiSecret` 字段来自Apsalar网站。创建帐户后，他们会向你提供密钥和使用秘诀。

项目配置完成后，你就可以开始记录分析事件。要仅获取基本玩家滞留数据，你需要在游戏启动时创建会话，并且在会话不再出现在前台时将其终止。可以使用以下所示的代码行或4.5及更高版本中提供的[蓝图分析插件](https://dev.epicgames.com/documentation/404)完成此操作：

```
	FAnalytics::Get().GetDefaultConfiguredProvider()->StartSession();	FAnalytics::Get().GetDefaultConfiguredProvider()->EndSession();
```

由于这些调用属于游戏的一部分，你将自动开始收集玩家滞留数据。获得基本玩家滞留数据后，你可以开始添加更多事件，以便进一步了解游戏中玩家的行为。
