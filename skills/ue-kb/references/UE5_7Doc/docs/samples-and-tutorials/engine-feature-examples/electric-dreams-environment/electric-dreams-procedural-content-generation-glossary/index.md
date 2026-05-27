---
title: "Electric Dreams PCG术语"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/electric-dreams-procedural-content-generation-glossary"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "引擎功能示例", "Electric Dreams场景", "Electric Dreams PCG术语"]
---

# Electric Dreams PCG术语

> 路径：虚幻引擎5.7文档 / 示例与教学 / 引擎功能示例 / Electric Dreams场景 / Electric Dreams PCG术语

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/electric-dreams-procedural-content-generation-glossary

在Electric Dreams环境示例项目中，我们会使用一些专业术语指代PCG框架中的不同内容。本文对这些术语进行了介绍。这有助于你熟悉本项目的文档。

## 术语

### PCG图表

**PCG图表** 是PCG的核心。该图表以图形化数据流的形式，描述了如何执行一系列操作。PCG图表可以作为子图表在其他图表中使用。

### PCG元素

**PCG元素** 是[PCG图表](#pcg%E5%9B%BE%E8%A1%A8)中使用的节点。该元素可以通过C++代码创建，也可以使用PCG Blueprint Element类在数据中创建。

### PCG设置

**PCG设置** 是节点相关的设置（包括它的类和设置属性）。

### 空间数据

**空间数据** 与空间有关，可以表示：

- 三维（3D）格式的体积。
- 二维（2D）格式的平面，如高度场和纹理。
- 一维（1D）格式的线条，如样条线和点云。

### 点数据

**点数据** 表示3D空间中的点，包括其相关的边界、属性、特性。这是最常见的PCG数据类型。

### 属性

点 **属性** 是一种预先定义的属性集，可以在PCG的[点数据](#%E7%82%B9%E6%95%B0%E6%8D%AE)中找到。属性可用于特性相关的操作。属性必须以美元符号（$）开头，例如 `$Density` 、 `$Position.x` 和 `$Rotation.forward` 。

属性包括：

- Transform

  ：由位置（vec3）、旋转（旋转体）和缩放（vec3）组成。
- Density

  （float）：一个范围在0到1之间的点密度函数。可用于多种操作，例如 differences、unions、noise，以及 filter。
- BoundsMin/Max

  （vec3）：点包围框的下限和上限。
- Color

  （vec4）：点的颜色值。
- Steepness

  （float）：一个范围从0到1的值，代表该点的密度函数的斜率。斜率为1时，密度函数在点的边界内返回最大密度，在边界外返回0。斜率小于1时，密度函数返回以点边界下限/上限为中心，最大密度值线性插直至0的密度值。
- Seed

  （int64）：通过点位置、节点种子和分量种子计算得来的点种子。

### 特性

**特性（Attribute）** 是一种特定类型的、由用户自定义的额外metadata，可以覆盖节点参数，或与点绑定，供[PCG图表](#pcg%E5%9B%BE%E8%A1%A8)中的特性操作使用。特性可以在图表中通过 **Create Attribute** 创建，也可以在自定义[PCG元素](#pcg%E5%85%83%E7%B4%A0)中创建。

目前，特性支持的数据类型仅包括：

- transform
- vec2
- vec3
- vec4
- float
- double
- int32
- int64
- bool
- string
- name
- rotator
- quaternion

### Assembly

**Assembly** 是一个由多个Actor及视效组件拼合而成的单一资产。在Electric Dreams场景中，Assembly使用了在关卡实例或Packed Level Actor中组合的Quixel资产，然后这些组件被放手动置在关卡四周。在Level to PCG资产工具的帮助下，Assembly可在[PCG图表](#pcg%E5%9B%BE%E8%A1%A8)和PCGAssembly中作为源内容使用。

### PCG Assembly

**PCGAssembly** 是一种通过PCG框架以程序化方式生成的Assembly。PCGAssembly可以借助[PCG图表](#pcg%E5%9B%BE%E8%A1%A8)中的一组操作，以多种方式构建，并通过更改其输入（如组件或公开的参数）进行定制。这些操作包括生成单独的网格体和Actor，以及手动实现的完整Assembly。
