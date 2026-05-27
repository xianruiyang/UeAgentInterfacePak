---
title: "分层材质"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/layering-materials-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质", "分层材质"]
---

# 分层材质

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质 / 分层材质

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/layering-materials-in-unreal-engine

虚幻引擎主要提供了两种方法来为材质进行分层，以便在不同表面类型之间创建复杂的混合效果。这些方法使你能够在单个网格体的不同区域上应用不同的材质属性。虽然你可以使用纹理遮罩和其他基于像素的逻辑，在普通材质中实现类似效果，但本文中的两个系统能够生成更加可读的材质图表，并且在需要对材质进行修改时，其编辑流程对美术师更加友好。

分层材质的两个工作流程如下：

作为材质函数系统扩展的 **分层材质**。 在材质实例编辑器中实现的 **材质层**。

## 用材质函数分层材质

这种分层材质方法是[材质函数](https://dev.epicgames.com/documentation/404)的扩展。所有要作为一个层使用的材质类型，都在其材质函数中通过[材质属性](../unreal-engine-material-expressions-reference/material-attributes-expressions/index.md)表达式定义。然后你创建一个基类材质——它会包含在各个层之间进行混合所需的所有逻辑。阅读下面的两个页面，了解如何使用这种方法。


- [分层材质概述](layered-materials/index.md)

- [创建分层材质](creating-layered-materials/index.md) - 介绍如何在虚幻引擎中使用分层材质技术。

## 材质层

[材质层](https://dev.epicgames.com/documentation/404)系统通过在[材质实例编辑器](https://dev.epicgames.com/documentation/404)中提供一个用户界面选项卡，使编辑分层材质更加容易。这个 **层参数（Layer Parameters）** 选项卡允许美术师直观在材质实例中切换材质层，改变材质层的堆叠顺序，并修改其混合方式，而无需编辑基本材质中的节点图表。

虽然上文中的分层材质函数流程仍然是一种有效方法，但 **材质层** 系统通常用于为美术师和设计师提供更快、更易迭代的用户体验（他们通常没有编辑节点图表的技术背景）。请在下文中学习如何使用材质层。


- [使用材质图层](using-material-layers/index.md)
