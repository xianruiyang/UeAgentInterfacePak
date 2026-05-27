---
title: "Gauntlet控制器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gauntlet-controller-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "Gauntlet自动化框架", "Gauntlet控制器"]
---

# Gauntlet控制器

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / Gauntlet自动化框架 / Gauntlet控制器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gauntlet-controller-in-unreal-engine

**Gauntlet控制器（Gauntlet Controller）** 是指各种可在自动化测试框架之外驱动自动化任务的C++对象。它们适用于运行时的功能测试，尤其是涉及网络时。

通常你可以在自定义插件中重新实现 `UGauntletTestController` 类，从而创建Gauntlet控制器。

你可以使用多种方法重新实现 `UGauntletTestController` ，从而控制测试流程，包括：

- OnInit()

  - 在控制器初始化时调用。
- OnPreMapChange()

  - 在地图变更前调用。
- OnPostMapChange(UWorld* World)

  - 在地图变更后调用。

  GetCurrentMap()

  返回新地图。
- OnTick(float TimeDelta)

  - 定期调用，以便控制器检查和控制状态。
- OnStateChange(FName OldState, FName NewState)

  - 在模块状态发生变化时调用。状态是由游戏驱动的。

测试结束时，调用 `EndTest(ExitCode)` 将其状态传递给游戏实例。虚幻自动化工具（UAT）Gauntlet会获取控制器的结果，并将其推送到测试中。

## Gauntlet角色

要让Gauntlet测试使用Gauntlet控制器，控制器的名称必须附到Gauntlet角色。你可以使用下列代码来实现这一目标，假定名称为 `UMyControllerName：

```
UnrealTestRole ClientRole = Config.RequireRole(UnrealTargetRole.Client);ClientRole.Controllers.Add("MyControllerName");
```

> [!NOTE]
> 多个角色可以有不同的控制器。
