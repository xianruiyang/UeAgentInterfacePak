---
title: "了解多边形组"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/understanding-polygroups-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模模式入门指南", "了解多边形组"]
---

# 了解多边形组

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模模式入门指南 / 了解多边形组

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/understanding-polygroups-in-unreal-engine

[建模模式概述](../modeling-mode/index.md)介绍了**多边形组**，而[快速入门](../modeling-mode-quick-start/index.md)指南展示了如何使用部分工具指定多边形组。 我们建议先查看这两个文档，然后再继续阅读本文。

本指南将进一步探究多边形组的创建工具，以及如何才能在其他工具和脚本中使用这些组。 本指南的最终目标是了解多边形组，构建在引擎内创建和编辑几何体的高效工作流程。

## 多边形组的使用原因和内容

### 使用原因

在传统的建模软件中，你可以选择进行多边形建模。 但虚幻引擎将所有模型渲染为三角剖分网格体。

|  |  |
| --- | --- |
| [使用Autodesk Maya进行四边形建模](https://dev.epicgames.com/community/api/documentation/image/96befed5-0d01-4198-911a-4ce5650ad4a3?resizing_type=fit) | [虚幻引擎中基于三角形的渲染](https://dev.epicgames.com/community/api/documentation/image/43976561-d4b3-404c-87a6-d826139aed66?resizing_type=fit) |
| Maya中一个基于四边形的立方体。 | 虚幻引擎中渲染成三角形的同一立方体。 |

转换为三角形意味着，虚幻引擎不能原生识别四边形或n边形，这使三角形成为了引擎内建模的构建基础。 为了获得与传统建模工作流程近似的效果，你可以使用**多边形组**。

### 内容

多边形组是一组分组的三角形。 你可以将组用于：

- UV布局
- 材质整理
- 建模和变形
- 使用四边形进行传统盒体建模
- 创建并编辑皮肤权重

例如，如果使用从Maya[导入的](https://dev.epicgames.com/documentation/assets/working-with-content/static-meshes/importing-static-meshes)立方体，我们可以使用**网格体（Mesh）**类别下的**三角形选择（Tri Select）**工具为每个三角形指定一个单独的多边形组。

> [!NOTE]
> 要在网格体上可视化多边形组，你可以将**面颜色模式（Face Color Mode）**设置为**按组（By Group）**。

设置多边形组之后，你就可以使用**模型（Model）**类别下的[多边形组编辑（PolyGroup Edit）](../../modeling-tools/polygroup-edit-tool/index.md)工具。 但现有多边形组每个都代表一个单独的三角形，这并非多边形组编辑工具的最佳用法。

![在虚幻引擎中创建多边形组](../../../../../assets/images/95/95a0197b3ec74f133fa26d020fb594c44f984dd9aa7d328534bbeb96506a6632.jpg)

由一个三角形组成的多边形组——每种颜色表示一个多边形组。

当你将两个三角形合并成一个多边形组时，就会得到一个四边形的表示。

*在视频中，使用**合并（Merge）**功能会创建一个由两个三角形组成的新多边形组。*

处理低多边形网格体和立体空间方块时，多边形组提供了一种比原始三角形更直观的表面交互方式。 但你也可以将多边形组应用于高多边形网格体，以帮助操控原本因过于复杂而难以编辑的几何体块。

## 多边形组剖析

一个多边形组由三个可被选中和编辑的元素组成：

- 面：一个多边形组的区域。
- 顶点：边缘的连接点。 也称为角。
- 边缘：多边形组之间的边界。

在将三角形分组以创建多边形组后，就会形成一条边界边缘。 根据你的网格体和生成的多边形组的拓扑，相较于其他建模数字内容创建（DCC）软件，编辑网格体的边缘可能无法达到你预期的效果。

下图中的网格体包含两个多边形组，由高亮显示的边界边缘表示。 尽管由于弯曲的形状，多边形组的边界似乎有多条边缘，但它不包含任何多边形组顶点，而是由一条多边形组边缘组成。

![多边形组边界的边缘](../../../../../assets/images/4d/4d87fa8d66c782463ac3aaf10df7850d681b0537a2bbd7f20079be8133602964.jpg)

多边形组边缘和顶点在以下条件下生成：

- 两个或更多个相连的多边形组面（或网格体边界）可构成一条多边形组的边缘。
- 三条或更多条相连的多边形组边缘可构成一个多边形组顶点。

## 创建多边形组

为了深入了解多边形组，熟悉可以用来创建多边形组的工具会有所帮助。 使用这些工具的顺序取决于你首选的工作流程和需求。 务必记住，你可以使用任何一组三角形作为多边形组。

### 三角形选择工具

如上方视频所示，**三角形选择（Tri Select）**工具可以将多边形组指定给一个或多个三角形。 现在，我们不再为每个多边形组选择一个三角形，而是使用**多边形组编辑（PolyGroup Edit）**工具选择两个三角形以进行四边形编辑。

*在视频中，新的多边形组是在每个边缘循环的交点创建的。*

> [!NOTE]
> 未被指定多边形组的三角形会被自动归入一个多边形组。

### 合并（Merge）

使用**多边形组编辑（PolyGroup Edit）**工具时，你可以继续将现有多边形组组合成一个新的组。

> [!NOTE]
> 合并现有多边形组的过程具有破坏性，亦即之前的多边形组将不复存在。

*在视频中，每个面都代表一个多边形组，你可以用合并（Merge）功能将面分组。*

### 多边形组绘制工具

有专用于创建多边形组的工具，其中一个工具是[绘制多边形组（Paint PolyGroups）](../../modeling-tools/paint-polygroups-tool/index.md)，你可以使用它交互式绘制你的分组。

*在视频中，绘制多边形组工具创建了由两个三角形组成的新多边形组。 同时启用了**显示线框（Show Wireframe）**以可视化每个多边形组中的两个三角形。*

你可以使用**操作（Action）**设置来选择以下任意一种选择模式：

- **笔刷（Brush）**
- **填充（Fill）**
- **组填充（Group Fill）**
- **套索（Lasso）**

> [!NOTE]
> 要查看为多边形组指定了什么，将鼠标悬停在该多边形组上并使用热键**Shift + G**。 **设置组（Set Group）**行将更新为关联的数字。

### 多边形组生成工具

另一个专用于三角形分组的工具是[生成多边形（Generate PolyGroups）](../../modeling-tools/generate-polygroups-tool/index.md)工具。 多边形组会在打开该工具时自动指定。 多边形组的指定方式则取决于**转换模式（Conversion Mode）**。

| 转换模式 | 说明 |
| --- | --- |
| **面法线偏差（Face Normal Deviation）** | 根据面法线间的角度公差进行转换。 |
| **查找四边形（Find Quads）** | 通过将成对三角形合并成四边形来创建多边形组。 |
| **根据UV岛状区（From UV Islands）** | 根据UV岛状区创建多边形组。 |
| **根据硬法线接缝（From Hard Normal Seams）** | 根据硬法线接缝创建多边形组。 |
| **根据连接的三角形（From Connected Tris）** | 根据连接的三角形创建多边形组。 |
| **最远点取样（Furthest Point Sampling）** | 创建以间隔充分的取样点为中心、近似于表面Voronoi图的多边形组。 |
| **从层复制（Copy From Layer）** | 从现有的多边形组层复制。 |

![在虚幻引擎中生成多边形组](../../../../../assets/images/38/3857c2ab9ca14c2f5dc076cd0ced0ca54e47c1df0a713c1d525ef79ab43e1a31.jpg)

多边形组是由四边形（合并成对三角形）生成的。

你可以使用**输出层（Output Layer）**来创建新的多边形组层。

### 预设形状

在**创建（Create）**类别中创建预设形状时，你可以使用**多边形组模式（Polygroup Mode）**设置来配置新网格体的多边形组。

![在虚幻引擎中针对四边形建模创建多边形组](../../../../../assets/images/bd/bd273fd752ab281ef9b017424734766c4dac34bed2684760e466ae456687e6c2.jpg)

多边形组模式（Polygroup Mode）具有以下分组选项：

|  |  |  |
| --- | --- | --- |
| [按形状生成多边形组](https://dev.epicgames.com/community/api/documentation/image/1f38d947-6f5a-40ec-b933-8c40eb7194dd?resizing_type=fit) | [按面生成多边形组](https://dev.epicgames.com/community/api/documentation/image/9bb4b407-889f-4509-a0d8-6cb5b99eccb2?resizing_type=fit) | [按四边形生成多边形组](https://dev.epicgames.com/community/api/documentation/image/1b7aac71-f6ca-4f0d-ba1a-a8e418af03bf?resizing_type=fit) |
| **按形状（Per Shape）** | **按面（Per Face）** | **按四边形（Per Quad）** |
| 将整个网格体作为单一组输出。 | 自动将网格体划分为可识别的面组。 | 自动为每个四边形将网格体划分为一组。 |

### 多边形组分层

由于多边形组是任意的，你可以创建多个**多边形组层（PolyGroup Layer）**来处理同一模型上不同的多边形组。 你可以使用**属性（Attributes）**类别下的[编辑属性（Edit Attributes）](../../modeling-tools/edit-attributes-tool/index.md)工具来配置这些层。

> [!NOTE]
> 多边形组层并非项目通用， 你需要为各个静态网格体资产创建。 这一具体指定意味着，你不能假定两个不同的网格体会有相同的多边形组层。 但这也意味着，你可以根据需要逐个用例定义这些层。

## 使用多边形组

### 构建形状

多边形组的基本用途是几何体编辑，正如使用**多边形组编辑（PolyGroup Edit）**工具时所示。

多边形组帮助构建网格体的其他方式包括：

- 精确区域编辑。

  *将四个多边形组合并成一个进行挤压。*
- 形成孔洞。
- 使用[细分（Subdivide）](../../modeling-tools/subdivide-tool/index.md)工具对网格体进行平滑处理。

  ![在虚幻引擎中对模型进行细分](../../../../../assets/images/48/4820e1ef6232fb4e493f4323a3ae46f354a032bd81b5f2dab1a0e8943bc202f1.jpg)

  点击查看大图。
- 使用[变形多边形组（Deform PolyGroups）](../../modeling-tools/deform-polygroups-tool/index.md)工具创建变形。

> [!NOTE]
> 多边形组的内部顶点无法选择，只能选择边界顶点。 要选择内部顶点，请使用**分解（Decompose）**来解构多边形组。

### 创建UV

在为你的模型创建UV时，你可以使用多边形组来提供帮助。 在[建模模式快速入门指南](../modeling-mode-quick-start/index.md)中，我们为板条箱指定了六个多边形组（每个面一个）。 然后根据现有多边形组生成了UV岛状区。

![在虚幻引擎中使用多边形组进行UV解包](../../../../../assets/images/cc/cc6de564a615cdff88ff30c73e51034f06461310a08c236d8cccb5f160713801.jpg)

然后你可以使用UV工具进一步解构UV，你也可以添加更多的多边形组。

![在虚幻引擎中指定额外多边形组进行UV解包](../../../../../assets/images/d9/d9eadc1c3856e446c0dd03a8e66ce7342e0c71503e6a54e303f711a289244ad9.jpg)

指定额外的多边形组以表示UV岛状区。

现在，当你打开自己的模型时，会创建更多的UV岛状区。

![在虚幻引擎中使用多边形组进行UV解包](../../../../../assets/images/d2/d2c3938d9051331ab281ecba60dbf2f0672d9f3df54efc9561e2f03bf23bb298.jpg)

如需详细了解UV工具，请参阅[UV类别](https://dev.epicgames.com/documentation/assets/working-with-content/modeling-and-geometry-scripting/modeling-tools/uvs-category)文件。

### 将多种材质指定给一个网格体

你可以使用**编辑材质（Edit Materials）**工具为你的几何体指定多个材质。 为了方便查看你想为材质指定的三角形，可以从**面颜色模式（Face Color Mode）**选择多边形组。这种做法尤其适用于高密度网格体。

## 常见问题解答

**有没有办法清除所有多边形组从头开始？**

有，可以使用**绘制多边形组（Paint PolyGroups）**工具中的**全部清除（Clear All）**选项。

**我的多边形组由一个三角形组成也行吗？**

虽然你仍然可以使用**多边形组编辑（PolyGroup Edit）**等工具编辑你的网格体，但可能会得到意外的结果。 例如，向网格体中添加边缘循环时，如果顶面有两个包含一个三角形的多边形组，该循环将向该侧面倾斜。 如果有一个多边形组将两个三角形归入一组（代表一个四边形），则循环将继续直接通过。

|  |  |
| --- | --- |
| [虚幻引擎中的失真边缘循环](https://dev.epicgames.com/community/api/documentation/image/c7bacee2-6fa6-4579-892c-4e15a6ad16c6?resizing_type=fit) | [虚幻引擎中纠正后的边缘循环](https://dev.epicgames.com/community/api/documentation/image/ef981860-d7af-4e45-a658-cf7cc695f9f3?resizing_type=fit) |
| 失真的边缘循环 | 纠正后的边缘循环 |

**创建多边形组会干扰渲染吗？**

不会，多边形组只是一个辅助工具，可以帮助你执行你可能在其他建模软件中习惯使用的经典建模技术。 在渲染时，仍然使用三角形。
