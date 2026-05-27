---
title: "混合动画"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/blending-animations-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画操作指南和示例", "混合动画"]
---

# 混合动画

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画操作指南和示例 / 混合动画

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/blending-animations-in-unreal-engine

作为一个概念，动画混合仅仅意味着在一个角色或骨架网格上的两个或多个动画之间进行平滑过渡。在虚幻引擎4中，有多种方法可以应用这种混合。在本文中，我们将概述每种方法以及如何将它们应用于您的角色。

## 混合空间

混合动画最常用的方法之一是使用混合空间。

有关混合空间的更多信息，请参阅[混合空间](../../animation-assets-and-features/blend-spaces/index.md)文档。

## 使用蓝图混合

还可以通过动画蓝图中的AnimGraph直接处理动画混合。AnimGraph通过一系列不同的节点绘制动画姿势数据流，每个节点以某种方式对姿势或动作的最终外观做出贡献。专门设计了各种节点，用于帮助以某种方式将多个姿势混合在一起。它们可以是添加式的，基于加权偏差或Alpha值按字面结合两个动画，也可以是现有姿势的直接覆盖。您还可以将动画直接发送到骨骼中的特定骨骼及其所有子项。例如，您可以从包含一个正在奔跑的角色的动画开始，然后有选择地在右臂上应用一个挥手的动画。最终的结果将是角色正在一边奔跑一边挥手。

要了解如何使用蓝图处理动画混合，请参阅[动画蓝图](../../animation-blueprints/index.md)和[混合节点](../../animation-blueprints/animation-blueprint-nodes/animation-blueprint-blend-nodes/index.md)。
