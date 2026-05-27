---
title: "蓝图样条组件概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/blueprint-spline-components-overview-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "蓝图样条", "蓝图样条组件概述"]
---

# 蓝图样条组件概述

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 蓝图样条 / 蓝图样条组件概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/blueprint-spline-components-overview-in-unreal-engine

本质上说，**蓝图样条组件（Blueprint Spline Component）** 是一条可用于定义和使用位置数据的路径。你可以让场景中的 **角色**（或其他 **组件**）沿样条移动，或者沿着样条放置一系列 **角色**（或其他 **组件**）。它们可以直接在蓝图视口和关卡编辑器中编辑，包括添加/删除/复制样条点，改变切线类型，甚至实现逐帧动画。此外，它们还可以通过 **蓝图构建脚本（Blueprint Construction Script）** 进行编辑，例如获取你在蓝图视口或关卡编辑器中的编辑，并做进一步修改。

**蓝图样条网格体组件（Blueprint Spline Mesh Components）** 的功能则完全不同。该组件允许 **静态网格体** 沿着一个由两点构成的样条线执行动画。你无法为蓝图样条网格体组件添加更多样条点，不过这两个点可以通过蓝图控制。

虽然它们的用途截然不同，但在蓝图中的添加过程是相同的，并且使用相同的编辑工具。
