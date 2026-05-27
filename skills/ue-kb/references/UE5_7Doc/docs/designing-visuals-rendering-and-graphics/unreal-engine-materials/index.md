---
title: "材质"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-materials"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质"]
---

# 材质

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-materials

虚幻引擎中的 **材质（Materials）** 定义了场景中对象的表面属性。 从广义上来讲，你可以将材质视为涂在网格体上用来控制其视觉外观的"涂料"。

从更偏技术性的角度来讲，材质确切告知渲染引擎一个表面应该如何与场景中的光线交互。 材质定义了表面的每个方面，包括颜色、反射性、崎岖度、透明度，等等。 执行这些计算时使用了从各种图像（纹理）和基于节点的 **材质表达式（Material expressions）** 以及从材质本身固有的各种[属性设置](unreal-engine-material-properties/index.md)输入到材质的数据。

## 入门指南

材质创建是一个广泛的主题，基于节点的工作流程允许你创建几乎无限种类的表面类型。 建议初学者首先查看本分段中链接的页面。 "基本材质概念"和"基于物理的材质"页面介绍了构成虚幻引擎中材质创建的基础理论和思路。 《材质编辑器用户指南》是一组基于工具的文档，讲授了使用材质编辑器的实用方面。


- [材质基本概念](essential-unreal-engine-material-concepts/index.md)

- [基于物理的材质](physically-based-materials/index.md) - 基于物理的材质主要输入及其最佳使用方法的概述。

- [材质编辑器指南](unreal-engine-material-editor-user-guide/index.md) - 了解如何用虚幻引擎基于节点的材质编辑器创建材质，以定义场景中的对象外观和表面属性。

- [材质属性](unreal-engine-material-properties/index.md) - 关于虚幻引擎中材质属性的介绍文档。

- [材质输入](material-inputs/index.md) - 深入了解材质上可用的各种输入及其用途。

- [材质数据类型](essential-unreal-engine-material-concepts/material-data-types/index.md) - 介绍材质编辑器中的四种浮点数据类型

## Substrate材质框架

> [!WARNING]
> 该系统属于试验性系统。

%designing-visuals-rendering-and-graphics/materials/substrate-materials:topic%

## 材质工作流程概念

在你理解材质创建背后的基本原则之后，强烈建议接下来查看本分段中的文档。 **材质实例（Material Instances）** 和 **材质函数（Material Functions）** 是材质创建中的基础主题，有助于你优化工作流程，以节省时间，避免重复做相同的事情。 材质实例允许你或你团队中的其他美术师快速、轻松地自定义材质，以从单个父材质生成多个变体（或实例）。材质函数允许你将材质图表的各个部分打包为单个节点，并将其共享到公共库以供在其他材质中复用。

%designing-visuals-rendering-and-graphics/materials/material-instances:topic%


- [材质函数](material-functions/index.md)

- [分层材质](layering-materials/index.md) - 介绍两种材质分层方法，可用于创建复杂、独特的表面效果。

## 教程索引

本分段中的页面是基于项目的分步文档，引导你逐步学习虚幻引擎中材质创建的某个特定方面。 例如：[制作UV坐标动画](unreal-engine-materials-tutorials/animating-uv-coordinates/index.md)或[使用纹理遮罩](unreal-engine-materials-tutorials/using-texture-masks/index.md)。


- [材质教程](unreal-engine-materials-tutorials/index.md)

## 材质参考页面

[材质编辑器](unreal-engine-material-editor-user-guide/index.md)提供了几十个 **材质表达式（Material Expressions）** 和 **函数（Functions）** ，其中每一项都旨在执行材质图表中的某个特定任务。 如果你要查找关于如何及何时使用特定节点的信息，请首先查看下面链接的页面。 材质表达式和函数参考页面根据其在材质控制板中的类别进行组织，例如：混合、梯度、数学、坐标，等等。


- [材质表达式参考](unreal-engine-material-expressions-reference/index.md)

- [材质函数参考](material-functions/unreal-engine-material-functions-reference/index.md) - 各种默认材质函数的参考页面，按类型排序 。

- [材质编辑器UI](unreal-engine-material-editor-user-guide/unreal-engine-material-editor-ui/index.md) - 介绍材质编辑器用户界面的各个部分。

- [材质实例编辑器用户界面](instanced-materials/unreal-engine-material-instance-editor-ui/index.md) - 使用材质实例编辑器修改材质实例常量的指南。

## 更多概念和工具

下方归纳了无法更精确归入其他类别的材质页面。其中许多页面是中高级主题，允许你超越材质创建的基础知识，并开始为你的项目开发更复杂的材质。


- [环境法线贴图](bent-normal-maps/index.md)

- [不基于切线空间的凹凸贴图](bump-mapping-without-tangent-space/index.md) - 如何从无法使用经典切线空间的3D程序化着色器中实现凹凸贴图。

- [材质曲线图集](curve-atlases-in-unreal-engine-materials/index.md) - 曲线图集保存了一组曲线资产，允许你通过材质访问曲线线性颜色数据。

- [自定义UV](customized-uvs-in-unreal-engine-materials/index.md) - 一种在顶点着色器中运行计算的功能，相比逐像素运行计算，这有助于提升性能。

- [材质分析器](unreal-engine-material-analyzer-tool/index.md) - 本页介绍如何找到和使用材质分析器工具。

- [使用像素法线偏移实现折射](refraction-using-pixel-normal-offset/index.md) - 介绍材质中的像素法线偏移以及折射模式。

- [在材质中按图元存储自定义数据](storing-custom-data-in-unreal-engine-materials-5286ff29/index.md) - 介绍自定义图元数据工作流，以及如何按图元存储自定义数据，并通过蓝图访问此类自定义数据。

- [光照半透明](lit-translucency/index.md) - 说明如何对半透明表面施以光照，并投射包括自身阴影在内的阴影。
