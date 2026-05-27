---
title: "游戏运行的性能分析"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/in-game-analytics-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "在线子系统和服务", "游戏运行的性能分析"]
---

# 游戏运行的性能分析

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 在线子系统和服务 / 游戏运行的性能分析

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/in-game-analytics-for-unreal-engine

要获得有关游戏性能的数据，会需要用到外部的分析软件，获取并处理游戏数据。对于没有自制解决方案的开发人员或团队而言，则可从各种 免费服务以及付费服务中选择。虚幻引擎提供简单的接口来供你与一个或多个分析软件进行数据交互。你的游戏使用该接口， 而分析软件对其实现提供支持。在某些情况下，Epic已经构建了支持软件。此前，Epic Games提供了一种实现方式来对分析事件进行多播，将其转发给多个提供商。此外，Epic还向支持[Swrve](http://www.swrve.com/)（付费服务）的软件提供支持，并支持Flurry。

随着时间的推移，我们将会提供更多软件的插件，如果需要，你还可以添加自己的软件支持。

## 实现游戏分析


- [检测游戏](instrumenting-your-game-with-analytics/index.md)

- [蓝图分析插件](blueprint-analytics-plugin/index.md) - 提供一组蓝图节点，以允许你用来分析服务通讯

## 外部分析软件


- [文件日志记录分析服务商](file-logging-analytics-provider/index.md)

- [Flurry分析供应商](flurry-analytics-provider/index.md) - 提供一组蓝图节点，以允许您用分析服务

- [多播分析服务商](multicast-analytics-provider/index.md) - 提供一组蓝图节点，以允许您与分析服务通讯。
