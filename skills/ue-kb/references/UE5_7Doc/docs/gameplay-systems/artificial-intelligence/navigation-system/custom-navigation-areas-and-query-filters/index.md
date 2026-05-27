---
title: "自定义寻路区域和查询筛选器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/custom-navigation-areas-and-query-filters-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "寻路系统", "自定义寻路区域和查询筛选器"]
---

# 自定义寻路区域和查询筛选器

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 寻路系统 / 自定义寻路区域和查询筛选器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/custom-navigation-areas-and-query-filters-in-unreal-engine

**虚幻引擎的** **寻路系统（Navigation System）** 可以借助 **寻路网格体（Navigation Mesh）** 让代理（Agent）在关卡中进行寻路。

代理会比较寻路网格体中不同寻路多边形的成本，最终选出最优路线。如果路线中所有多边形的成本均等，那么代理就会选择到达目标的最短路线（通常是直线距离）。

你可以通过 **寻路调整器体积（Navigation Modifier Volumes）** 和 **寻路查询筛选器（Navigation Query Filters）** 来改变寻路多边形的成本。

准备指南能够帮助你创建[自定义寻路区域和查询筛选器](custom-navigation-areas-and-query-filters-quick-start/index.md) 指南所需的示例关卡。或者，你可以下载[完整示例项目](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/0eaab25a-0a79-44a7-87cc-0017f2391986/navsystemsample.zip)，其中已经包括了名为 **LevelCustomZones** 的完整关卡。

- [自定义导航区域和查询筛选器准备指南](custom-navigation-areas-and-query-filters-pre-4d36250e/index.md) - 本指南涵盖了解自定义导航区域和查询筛选器所需的初始步骤。

- [自定义寻路区域和查询筛选器概述](custom-navigation-areas-and-query-filters-quick-start/index.md) - 本指南将介绍如何在寻路系统中使用自定义区域和查询筛选器。
