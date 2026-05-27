---
title: "变形多边形组"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/deform-polygroups-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模工具", "变形多边形组"]
---

# 变形多边形组

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模工具 / 变形多边形组

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/deform-polygroups-tool-in-unreal-engine

**变形多边形组（Deform PolyGroup）** 建模工具通过[多边形组](../../getting-started-with-modeling-mode/understanding-polygroups/index.md)动态地改变网格体的形状。变形是快速重塑网格体和创建有机几何体的有效方法。

你可以选择顶点、边或面，然后沿世界网格轴拖动它们，使网格体的整体轮廓发生变形。你还可以在一个工具会话中应用多个变形。

> [!NOTE]
> 如果网格体没有发生预期的变形，可能是分辨率（三角形数量）太低。你可以使用 **[重新网格化](../index.md#mesh)** 工具重新标定。

## 获取工具

你可以通过以下方法访问变形多边形组工具：

- 建模模式（Modeling Mode）

  中的

  变形（Deform）

  类别。如需详细了解建模模式以及访问方法，请参阅

  建模模式概述

  。
- 骨架编辑器（Skeleton Editor）

  中的

  编辑工具（Editing Tools）

  选项卡。更多详情，请参阅

  骨架编辑

  。

## 设置

### 选项

使用该工具有两个核心选项：**变形** 和 **变换**。

你可以在**线性**和**平滑**之间选择变形类型。

| **变形** | **说明** |
| --- | --- |
| **线性** | 与所选组件相连的多边形组边线会保持平直。 |
| **平滑** | 与所选组件相连的多边形组边线平滑插值成为一条曲线。 |

变换选项决定了选择组件时的移动类型。

| **变换** | **说明** |
| --- | --- |
| **平移** | 在 X、Y 和 Z 轴上线性移动所选组件。 |
| **选装** | 围绕 X、Y 和 Z 轴移动选中的组件。 |

### 选择

**选择（Selection）** 决定可选择的元素类型（边、面或顶点）。你可以同时开启/关闭多个选项。

> [!NOTE]
> 如不能按预期选择元素，请确认多边形组设置正确。更多详情，请参阅[了解多边形组](../../getting-started-with-modeling-mode/understanding-polygroups/index.md)。

### 显示线框

启用 **显示线框（Show Wireframe）** 后，网格体上会出现2D线框覆层，描绘底层三角形。

工具使用完毕后，请在[工具确认](../../getting-started-with-modeling-mode/modeling-mode/index.md#%E5%B7%A5%E5%85%B7-%E6%92%A4%E9%94%80%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95%E5%92%8C%E6%8E%A5%E5%8F%97%E6%9B%B4%E6%94%B9)面板中接受或取消改动。
