---
title: "寻路系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/navigation-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "寻路系统"]
---

# 寻路系统

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 寻路系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/navigation-system-in-unreal-engine

**虚幻引擎寻路系统** 允许人工智能代理通过寻路功能在关卡中走动。

该系统会从关卡中的碰撞几何结构生成寻路网格体，并将网格体划分为图块。这些图块接着划分为多边形，以构成代理在前往目的地时使用的图表。每个多边形都指定有成本，可供代理用于确定总体成本最低的最优路径。

寻路系统包含各种组件以及可修改寻路网格体生成方式的设置，例如指定给多边形的成本。这进而影响代理在你的关卡中寻路的方式。你还可以将寻路网格体中不连续的区域连接起来，如平台和桥梁。

寻路系统包含三种 **生成模式（Generation Modes）**：**静态（Static）**、**动态（Dynamic）** 和 **仅限动态修改器（Dynamic Modifiers Only）**。这些模式控制了项目中生成寻路网格体的方式，并提供了各种选项来满足你的需要。

该系统还为代理提供了两种规避方法：**相对速度障碍物(RVO)（Reciprocal Velocity Obstacles (RVO)）** 和 **大规模人群绕行避让管理器（Detour Crowd Manager）**。这些方法允许代理在游戏过程中绕行，避让动态障碍物和其他代理。

在以下指南中，你将学习寻路系统的不同组件和设置，以及如何使用它们为项目创建互动式人工智能代理。

> [!NOTE]
> 你可以在此处下周寻路系统示例：[示例](https://d1iv7db44yhgxn.cloudfront.net/documentation/attachments/3aa1013f-bbc6-420a-9a4c-cfcd9d1b7e07/navsystemsample.zip)。其中的关卡示例涉及下述指南中的内容。

- [基本寻路](basic-navigation/index.md) - 本指南将介绍如何使用虚幻引擎中的寻路系统。

- [如何修改寻路网格体](modifying-the-navigation-mesh/index.md) - 介绍在虚幻引擎中修改寻路网格体的不同方法。

- [自定义寻路区域和查询筛选器](custom-navigation-areas-and-query-filters/index.md) - 本指南介绍如何使用寻路系统中的自定义区域和查询筛选器。

- [在寻路系统中使用避障机制](using-avoidance-with-the-navigation-system/index.md) - 本指南介绍如何使用寻路系统中的避障。

- [使用寻路调用程序](using-navigation-invokers/index.md) - 本指南将介绍如何使用寻路调用程序。

- [优化寻路网格体的生成速度](optimizing-navigation-mesh-generation-speed/index.md) - 关于如何优化寻路网格体生成速度的入门指南。

- [寻路网格体分辨率用户指南](navigation-mesh-resolutions-user-guide/index.md) - 本指南旨在帮助你了解在虚幻引擎中，如何在同一寻路网格体内应用多种分辨率。

- [世界分区寻路网格体](world-partitioned-navigation-mesh/index.md) - 介绍如何通过世界分区使用寻路网格体。

- [自动生成寻路链接](automatic-navigation-link-generation/index.md) - 了解如何在虚幻引擎中自动生成寻路链接。

- [寻路组件](navigation-components/index.md) - 概述如何使用寻路组件来修改或扩展寻路功能。
