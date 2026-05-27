---
title: "材质函数"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/material-functions-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "设计视觉、渲染和图形效果", "材质", "材质函数"]
---

# 材质函数

> 路径：虚幻引擎5.7文档 / 设计视觉、渲染和图形效果 / 材质 / 材质函数

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/material-functions-in-unreal-engine

**材质函数** 允许你将材质图表的一部分打包成可复用的资产，分享到一个函数库中，并轻松插入到其他材质中。它们旨在让你能够快速访问一些常用材质网络，实现简化材质创建。材质函数允许你将复杂的材质逻辑抽象成一个节点，使美术师更容易创建材质。

材质函数的另一个好处是，只要编辑单个函数，就会影响所有使用该函数的材质。因此，如果你需要修复某个材质函数，你不必再去修改其他使用该函数的许多个材质。下面两个页面介绍了如何在虚幻引擎中创建和使用材质函数。


- [材质函数概述](unreal-engine-material-functions-overview/index.md)


- [创建和使用材质函数](creating-and-using-material-functions/index.md)

## 函数参考

下面的参考页提供了虚幻引擎中所有默认材质函数的信息和使用示例。它们按照[材质函数](https://dev.epicgames.com/documentation/404)面板中的类别组织。

- [混合材质函数](unreal-engine-material-functions-reference/blend-material-functions/index.md) - 这些函数用于将一种颜色与另一颜色混合，这类似于流行图像编辑应用程序中的混合模式。

- [渐变材质函数](unreal-engine-material-functions-reference/gradient-material-functions/index.md) - 以程序方式生成要添加至材质的渐变，从而消除对纹理的需求并节省内存。

- [图像调整材质函数](unreal-engine-material-fun-26349ac1/image-adjustment-material-functions/index.md) - 这些函数用来对现有的图像纹理进行调整，例如改变对比度或色调。

- [数学材质函数](unreal-engine-material-functions-reference/math-material-functions/index.md) - 这些材质函数进行预先配置的数学运算，例如计算 π 以及将矢量分量相加等等。

- [杂项材质函数](unreal-engine-material-functions-reference/misc-material-functions/index.md) - 未归入现有类别的杂项材质函数。

- [不透明度材质函数](unreal-engine-material-functions-reference/opacity-material-functions/index.md) - 这些函数用于处理材质网络中的不透明值。

- [粒子材质函数](unreal-engine-material-functions-reference/particles-material-functions/index.md) - 这些专用函数用来帮助设置复杂粒子网络的外观。

- [程序化材质函数](unreal-engine-material-function-26349ac1/procedurals-material-functions/index.md) - 以程序方式生成的纹理和操作，例如根据现有的高度贴图来创建法线贴图。

- [反射材质函数](unreal-engine-material-function-26349ac1/reflections-material-functions/index.md) - 这些函数帮助计算各种反射类型的值。

- [明暗处理材质](unreal-engine-material-functions-reference/shading-material-functions/index.md) - 这些函数用于处理特殊的明暗处理类型，例如

- [纹理材质函数](unreal-engine-material-functions-reference/texturing-material-functions/index.md) - 各种用于帮助处理纹理的函数，例如重新投射 UV 以及裁切等等。

- [向量运算材质函数](unreal-engine-material-functions-reference/vector-ops-material-functions/index.md) - 这些函数用来处理向量数学运算，例如计算菲涅耳效果。

- [世界位置偏移函数](unreal-engine-materia-26349ac1/world-position-offset-material-functions/index.md) - 这些函数使用全局位置偏移来处理顶点操作。
