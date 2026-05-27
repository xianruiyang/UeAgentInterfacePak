---
title: "Gauntlet自动化框架"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gauntlet-automation-framework-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "自动化系统概述", "Gauntlet自动化框架"]
---

# Gauntlet自动化框架

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / 自动化系统概述 / Gauntlet自动化框架

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gauntlet-automation-framework-in-unreal-engine

**Gauntlet** 是在 **虚幻引擎** 中运行项目会话，以执行测试并验证结果的框架。它是专门为在各种平台上运行虚幻会话而设计的，但不仅限于此。虚幻 **会话** 是虚幻引擎中执行游戏所需的所有进程。例如，多人游戏可能需要四个客户端和一个服务器。

Gauntlet不需要任何特定的游戏端自动化代码或测试框架——您的游戏如何执行测试完全取决于您自己。不过，Gauntlet插件提供了一个有用的 `TestController` 类来帮助操纵和监控游戏实例。它非常适合需要执行多个步骤的冒烟测试，但它完全是可选的。


- [Gauntlet自动化框架概述](gauntlet-automation-framework-overview/index.md)

- [运行Gauntlet测试](running-gauntlet-tests/index.md) - 学习如何运行Gauntlet测试。
