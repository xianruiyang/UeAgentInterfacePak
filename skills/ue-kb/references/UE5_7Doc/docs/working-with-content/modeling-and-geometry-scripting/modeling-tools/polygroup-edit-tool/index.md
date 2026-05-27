---
title: "多边形组编辑"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/polygroup-edit-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模工具", "多边形组编辑"]
---

# 多边形组编辑

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模工具 / 多边形组编辑

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/polygroup-edit-tool-in-unreal-engine

**多边形组编辑（PolyGroup Edit）** 工具包括一整套操作，用于使用多边形组编辑网格体。常见的操作有 **挤压（Extrude）** 、 **倒角（Bevel）** 、 **焊接（Weld）** 和 **桥接（Bridge）** 等。还包括了仅处理结构化多边形组的操作，例如 **插入边缘循环（Insert Edge Loop）** 和边缘循环选择。

将所有这些工具与 **合并（Merge）** （组）或 **按组简化（Simplify By Groups）** 等特定于多边形组的操作结合使用，可创建通常与数字内容创建（DCC）软件（例如3ds Max、Blender、Maya）关联的低多边形工作流程。

> [!NOTE]
> 没有多边形组信息的网格体不能使用多边形组编辑。

## 了解多边形组

多边形组是一组分组的三角形。你可以将这些组用于：

- 建模与变形
- 传统盒体建模
- UV布局
- 材质整理

多边形组是在 **创建（Create）** 类别的[预定义形状（predefined shapes）](../predefined-shapes/index.md)上自动生成的。你也可以使用 **绘制多边形组（Paint PolyGroups）**、**生成多边形组（Generate PolyGroups）**和 **三角形选择（Tri Select）** 工具来创建它们。

在开始使用多边形组编辑前，我们推荐你浏览[了解多边形组](../../getting-started-with-modeling-mode/understanding-polygroups/index.md)一文，详细了解多边形组及其创建方式。

## 访问工具

你可以通过以下方法访问多边形组编辑工具：

- 建模模式（Modeling Mode）

  中的

  模型（Model）

  类别。如需详细了解建模模式以及访问方法，请参阅

  建模模式概述

  。
- 骨架编辑器（Skeleton Editor）

  中的

  编辑工具（Editing Tools）

  选项卡。更多详情，请参阅

  骨架编辑

  。

## 使用多边形组编辑

多边形组编辑的编辑操作分组为三个类别：

- 面编辑（Face Edits）

  - 编辑网格体多边形面的选项。
- 形状编辑（Shape Edits）

  - 整体编辑网格体的选项。
- 边缘编辑（Edge Edits）

  - 编辑网格体多边形组边缘的选项。

许多操作在被选中时，都会弹出设置面板。这些面板都有独立的接受和取消选项，与多边形组编辑的[工具确认](../../getting-started-with-modeling-mode/modeling-mode/index.md#%E5%B7%A5%E5%85%B7-%E6%92%A4%E9%94%80%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95%E5%92%8C%E6%8E%A5%E5%8F%97%E6%9B%B4%E6%94%B9)面板分开。

### 元素选择

你可以使用 **选择筛选器（Selection Filter）** 控制你想选择的网格体元素。

| **元素图标** | **说明** |
| --- | --- |
| 选择顶点 | 选择多边形组的顶点。 |
| 选择边缘 | 选择多边形组的边缘。 |
| 选择面 | 选择多边形组的面。 |
| 选择边缘循环 | 选择多边形组的边缘循环。边缘循环是贯穿连接了四条边缘的顶点的路径。 |
| 选择边缘环 | 选择多边形组的边缘环。环是在一个由四个多边形组边缘的面上相互交叉的边缘的序列。 |

> [!NOTE]
> 如果你无法正确选中元素，请确认你是否正确设置了多边形组，或尝试按照参考指南的[拓扑选项](polygroup-edit-tool-reference/index.md#%E6%8B%93%E6%89%91%E9%80%89%E9%A1%B9)一节重新生成额外的内角。

选框可用于快速选择启用的元素。在默认情况下，选中范围内的所有元素都会被切换，包括你看不到的组件。要确保不选择你看不到的元素，请取消选中 **选框忽略遮挡（Marquee Ignore Occlusion）** 。

你还可以使用以下热键调整选择内容：

- Shift + 点击

  可添加到当前选择内容。
- Ctrl + 点击

  可从当前选择内容删除。

使用 **多边形组编辑（PolyGroup Edit）** 时，你可以使用 **平面投影（Planar Projection）** 交互式设置UV。要缩放UV岛状区，请将光标拖入拖出。要详细了解如何创建和编辑UV，请参阅[UV类别](../uvs-category/index.md)。

要进一步了解多边形组编辑属性，请参阅[多边形组编辑属性](polygroup-edit-tool-reference/index.md)一文，以及[多边形组编辑系列视频](https://youtu.be/JgPU9A4nJWY?feature=shared).
