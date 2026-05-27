---
title: "寻路组件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/navigation-components-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "寻路系统", "寻路组件"]
---

# 寻路组件

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 寻路系统 / 寻路组件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/navigation-components-in-unreal-engine

寻路组件是一种可以在虚幻引擎中修改或扩展 **NavMesh** 寻路系统的组件。

## 寻路修改器组件

**寻路修改器组件（Nav Modifier Component）** 本身没有任何功能。不过，假如你有一个Actor，并且用一个基本形状作为它的根节点，根组件的体积会根据寻路修改器组件的 **Area Class** 属性来修改 NavMesh 的生成效果。每个 Actor 只能带有一个寻路修改器组件，因为多个修改器组件是无效的。此外，这些（多余的）组件将出现在"组件"选项卡的层级结构之外，不能作为其他组件的父组件，也不能包含任何子组件。

这些区域类（Area Class）可定义一些基本设置，例如进入某个区域的 **成本（Cost）**，或者一些高级设置，例如蹲伏角色可移动的区域。

成本是 NavMesh 系统中的一个重要概念。简单来说，在 NavMesh 中，从一个点移到另一个点的总成本等于路径经过的所有的区域成本总和（单个区域的大小在项目的偏好设置中定义）。解算器会始终寻找成本最低的路径，因此，你可通过增加通过该区域的成本来让它避免某些区域（比如湿滑或崎岖不平的区域）。不过要注意，假如某个区域成本很高，但只要属于成本最低的路径，解算器仍然会通过它。

例如，通过红色区域的成本非常高，但是 Pawn 没有其他选择，只能从中通过：

但是，如果你移除了墙壁：

Pawn 将避免经过红色区域，即使它要绕更长的路线。
