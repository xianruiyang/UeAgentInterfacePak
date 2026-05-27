---
title: "Gameplay摄像机系统概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/gameplay-camera-system-overview"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay摄像机系统", "Gameplay摄像机系统概述"]
---

# Gameplay摄像机系统概述

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay摄像机系统 / Gameplay摄像机系统概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/gameplay-camera-system-overview

## 简介

**Gameplay摄像机系统** 让开发者和设计人员能够直观地在编辑器中创建复杂的摄像机行为。

Gameplay摄像机系统不同于使用蓝图组件的传统工作流程，它是一个通用系统，包含一个或多个摄像机绑定，以及数据资产中的行为和过渡。这种资产可以被蓝图Actor或蓝图组件所摄取，在Gameplay过程中驱动摄像机的行为。

## 优势

相比使用蓝图摄像机组件的传统工作流程，Gameplay摄像机系统有多个优点。

这包括：

- 模块化的设计。
- 能更简便地创建复杂的摄像机行为。
- 能创建自定义的过渡行为。

该系统采用模块化设计，提供可以被一个或多个Gameplay摄像机Actor和组件摄取摄像机资产。这意味着你只需编写一次摄像机行为，就能将其用于场景中的多个Actor。

该系统使创建复杂的摄像机行为变得更容易，减少了在蓝图中编写行为脚本的需求。这让不熟悉编程的设计人员更容易上手。

Gameplay摄像机系统可以在摄像机之间创建自定义的过渡行为，而无需进行C++编程，从而提高了迭代速度，让程序员可以腾出手来做其他工作。

系统自带摄像机调试器工具，使在游戏过程中调试摄像机行为和过渡变得更为简易。

## 系统设计

Gameplay摄像机系统包含如下组件：

| 组件 | 说明 |
| --- | --- |
| Gameplay摄像机组件（Gameplay Camera Component） | 使用摄像机资产的蓝图组件。 |
| Gameplay摄像机Actor（Gameplay Camera Actor） | 包含Gameplay摄像机组件并使用摄像机资产的蓝图Actor。 |
| 摄像机资产（Camera Asset） | 包含摄像机绑定、过渡和摄像机指示器相关数据的资产。 |
| 摄像机绑定（Camera Rigs） | 通过节点网络定义摄像机的行为。 |
| 摄像机过渡（Camera Transitions） | 定义各摄像机绑定的进入和退出的过渡。 |
| 摄像机共享过渡（Shared Camera Transitions） | 如未指定过渡，则任何摄像机绑定都可用的进入和退出过渡。 |
| 摄像机指示器求值器（Camera Director Evaluator） | 对摄像机指示器求值器蓝图类的引用。 |
| 摄像机指示器（Camera Director） | 管理任何特定时间内活动的摄像机绑定。指示器可以是下列类型之一： 蓝图摄像机指示器、单个摄像机指示器、或状态树摄像机指示器。 |
| 蓝图摄像机指示器（Blueprint Camera Director） | 包含在Gameplay过程中选择活动摄像机绑定自定义逻辑的蓝图类。 |
| 单个摄像机指示器（Single Camera Director） | 激活指定的摄像机绑定。不包含选择逻辑。 |
| 状态树摄像机指示器（StateTree Camera Director） | 使用状态树选择活动的摄像机绑定。 |
| 摄像机变量集合（Camera Variable Collection） | 包含用于修改摄像机资产内部属性的变量集合。 |
