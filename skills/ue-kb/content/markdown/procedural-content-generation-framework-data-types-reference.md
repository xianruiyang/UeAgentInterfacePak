# Procedural Content Generation Framework Data Types Reference

---
title: "Procedural Content Generation Framework Data Types Reference"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-framework-data-types-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "程序化内容生成框架", "PCG开发指南", "Procedural Content Generation Framework Data Types Reference"]
---

# Procedural Content Generation Framework Data Types Reference

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 程序化内容生成框架 / PCG开发指南 / Procedural Content Generation Framework Data Types Reference

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/procedural-content-generation-framework-data-types-reference-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

其中的数据 **程序化内容生成（PCG）框架** 分为以下类型：

- [空间数据](index.md#spatial-data)
- [组合数据](index.md#composite-data)
- [属性集](index.md#attribute-sets)

## 空间数据

空间数据包含对二维（2D）或三维（3D）空间的引用，可表示体积、高度场、样条和点数据。

### 体积

体积是一类表示 3D 形状的空间数据，常用于布尔集合操作，或通过 Volume Sampler 节点直接从关卡采样。

### 表面

表面是一类表示 2D 数据的空间数据，例如映射到 XY 平面的 Landscape，或在 2D 平面上生成点并将其投射到 3D 形状上的 Surface Sampler 节点。

### 线

线是一类表示 Spline 和 Landscape Spline 组件的空间数据。该数据会读取样条的关键点、切线和点缩放。Landscape Spline 会进行垂直投射，即使样条相对 Landscape 有偏移，也始终应用到表面。在 PCG 图表中，可以通过 Get Spline Data 和 Spline Sampler 节点引用此数据类型。

### 点

点云是一类空间数据，表示一组带有关联边界的点，可在 3D 空间中表示表面或体积。边界使这些点能够表示不同维度的形状。

例如，可以将 3D 球体采样为点，点大小决定这些点对球体形状的贴合程度。

此外，每个点都会获得一个限制在 0 到 1 之间的 Density 值。这些点及其密度值共同表示空间中的浮点函数。PCG 图表节点通常会先在空间中创建并操作采样密度值，然后再执行采样。

点可以包含以下信息：

| 数据 | 说明 |
| --- | --- |
| **变换** | 平移、旋转和缩放信息。 |
| **BoundsMin 和 BoundsMax** | 该点所表示体积的最小和最大范围。 |
| **颜色** | 每个点的四通道颜色值。 |
| **密度** | 在给定采样中，点相对于其他点的衰减浮点表示。用于确定采样密度。 |
| **陡峭度** | 点所表示体积的柔和程度。每个点都有 3D 边界并表示一个空间区域。每个点上的 Steepness 值可控制其影响形状。 |
| **种子** | 在各种操作中由随机数生成器消耗。可以操作该值以控制随机性的表现方式；它根据位置计算，以便与世界位置保持一致。 |

### Polygon 2D

Polygon 2D 类型将区域表示为闭合形状，可转换为表面或样条数据，用于采样或特定操作。

Polygon 2D 数据可以使用以下操作符修改：

| 操作符 | 说明 |
| --- | --- |
| **Create Polygon 2D** | 接收点数据或样条数据，并将其转换为 Polygon 2D。 |
| **Polygon Operations** | 多边形到多边形的操作，包括交集、并集和差集。此外，可以使用样条切割 Polygon 2D，以细分或隔离形状。例如，可以使用样条数据将较大区域切分为网格图案，然后在城市生成器图表中用该图案创建独立街区。 |
| **Clip Paths** | 用于将样条与 Polygon 2D 形状求交或求差。 |
| **Offset Polygon** | 对 Polygon 2D 形状应用偏移，使其变大或变小，并处理重叠。 |
| **Create Surface From Polygon 2D** | 将 Polygon 2D 转换为表面，可使用 Surface Sampler 节点在其区域上创建点。 |

## 组合数据

组合数据是集合操作的结果，例如并集、交集和集合差集。

可以将多个集合操作串联起来，然后再将结果转换回显式数据并应用该结果。

## 属性集

属性集是用户定义变量，并以 Metadata 形式存储在 PCG 图表中。这些变量可以通过各种属性操作节点进行操作，也可由节点消耗。

常见示例是展开节点上的高级引脚，并将属性连接到暴露引脚，以驱动节点设置。

![PCG Attributes Inputs](../../../../../assets/images/b6/b6f9661877c68f9176c4b43bb0f45073c2b7ffc0ef2ac417d50e358e233ef1d7.jpg)

PCG 属性输入

*Transform Points 节点上可用的 Attribute 输入。*

可以在 Attributes List 窗口中检查属性；该窗口属于 PCG Node Graph 界面的一部分。关于使用 PCG Framework 的更多信息，请参阅 [程序化内容生成概述](https://dev.epicgames.com/documentation/assets/building-virtual-worlds/procedural-generation/procedural-content-generation-overview).

