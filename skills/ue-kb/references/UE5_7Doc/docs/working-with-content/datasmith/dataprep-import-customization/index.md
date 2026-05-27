---
title: "Dataprep导入自定义"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/dataprep-import-customization-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "Datasmith", "Dataprep导入自定义"]
---

# Dataprep导入自定义

> 路径：虚幻引擎5.7文档 / 管理内容 / Datasmith / Dataprep导入自定义

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/dataprep-import-customization-in-unreal-engine

Datasmith将场景导入虚幻引擎时，会尽量保留源应用程序中创建的几何体、材质和场景层级。但若为了实时渲染之外的用途而在专用应用程序中构建3D模型，则场景在导入虚幻这类实时渲染引擎时就可能会出现各种问题。例如，当你在Rhino中创建的模型主要用于制作或挤压物理部件时，或者在Revit或IFC应用中创建的场景主要用于记录建筑工程时，或者在Cinema 4D中使用程序化生成的元素创建场景时，你就可能遇到这种情况。

你大可导入原始场景数据，然后在导入之后利用虚幻编辑器提供的工具调整资源和Actor。但此法有一些限制。例如，若要重新导入场景以找出源应用程序中所做的更改，或以相同设置重新导入不同场景时，可能需要重复这些步骤。

Visual Dataprep系统能够创建可重复使用的导入"方式"，从而可在虚幻引擎项目中创建最终资源和Actor之前，整理、清理、合并和修改场景元素。方式只需创建一次，以后每次导入场景都可重复使用。即便是导入不同的源文件，也可以重复使用同一种方式，甚至可以跨不同项目重复使用。从而可按照需要有效地创建自己的标准化资源导入方式集。

利用Visual Dataprep系统，即可将此类一般数据制备任务构建到导入流程中：

- 将源场景中使用的材质替换为专为实时可视化制作的高质量材质。
- 识别并清除场景中不必要的几何体。
- 合并几何体，减少场景中单独对象的数量。
- 创建细节层级，更高效地渲染复杂几何体。
- 为需要碰撞网格体以提供运行时体验的对象（例如地板和墙壁）创建碰撞。

开始使用Visual Dataprep时，你会发现可以使用其他一些操作制作可重复使用的dataprep方式，用于实时场景。

## 入门

- [Dataprep概述](dataprep-overview/index.md) - 介绍Dataprep系统的原理及其使用方法。

## 教程

- [使用Dataprep实例](working-with-dataprep-instances/index.md) - 介绍如何创建父类Dataprep预案，并将有限的自定义参数公开给Dataprep实例。

- [创建自定义Dataprep块](creating-custom-dataprep-blocks/index.md) - 如何在蓝图中为Dataprep系统创建自定义过滤器和操作。

## 参考

- [Dataprep选择参考](dataprep-selection-reference/index.md) - 详细介绍Dataprep中过滤和选择场景元素的方法。

- [Visual Dataprep操作参考](dataprep-operation-reference/index.md) - 介绍如何对Visual Dataprep系统中的选定场景元素执行各种操作。

- [Dataprep选项变换参考](dataprep-selection-transform-reference/index.md) - 详细介绍如何在Dataprep系统中对需要修改的对象进行变换。
