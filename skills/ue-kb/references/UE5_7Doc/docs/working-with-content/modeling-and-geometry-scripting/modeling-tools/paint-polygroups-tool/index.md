---
title: "绘制多边形组"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/paint-polygroups-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模工具", "绘制多边形组"]
---

# 绘制多边形组

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模工具 / 绘制多边形组

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/paint-polygroups-tool-in-unreal-engine

**绘制多边形组（Paint PolyGroups）** 工具提供了在网格体上以交互方式绘制多边形组的方法。多边形组是一组已成组的三角形。你可以将多边形组用于各种操作，例如：

- 建模与变形
- 传统的盒体建模
- UV布局
- 材质整理
- 皮肤权重

如需了解更多信息，请参阅[了解多边形组](../../getting-started-with-modeling-mode/understanding-polygroups/index.md)。

## 访问工具

你可以从以下位置访问绘制多边形组工具：

- 建模模式（Modeling Mode）

  中的

  属性（Attributes）

  类别。如需详细了解建模模式以及访问方法，请参阅

  建模模式概述

  。
- 骨架编辑器（Skeleton Editor）

  中的

  编辑工具（Editing Tools）

  选项卡。如需了解更多信息，请参阅

  骨架编辑

  。

## 使用绘制多边形组

打开绘制多边形组工具时，该工具会保留预先存在的分组。从 **激活多边形组（Active PolyGroup）** 属性中，选择你要编辑的多边形组图层。要创建新图层，请使用[编辑属性](../edit-attributes-tool/index.md)或[生成多边形组](../generate-polygroups-tool/index.md)工具。

使用 **操作（Action）** 设置，选择以下任意一种选择模式来绘制多边形组：

- 笔刷（Brush）

  ：用笔刷绘制多边形组。在网格体上

  点击 + 拖动

  进行绘制。
- 填充（Fill）

  ：用当前组填充整个组件。

  点击

  网格体以添加填充。
- 组填充（Group Fill）

  ：仅使用当前设置的组ID填充悬停的组。
- 多边形套索

  ：在网格体上绘制一个区域来绘制当前组ID。

  点击 + 拖动

  以突出显示要添加多边形组的网格体区域。

要创建不同的多边形组，请在 **设置组（Set Group）** 属性中添加值。该值代表组ID。将组ID添加到 **擦除组（Erase Group）** 属性并使用 **Shift + 点击 + 拖动** 热键，可以擦除分组。要查看当前组ID，请切换 **可视化（Visualization）** 分段中的属性或使用 **Shift + G** 热键。

为便于控制选组，请使用 **冻结（Freezing）** 和 **操作（Operations）** 分段中的快速操作按钮。

工具使用完毕后，在[工具确认](../../getting-started-with-modeling-mode/modeling-mode/index.md#%E5%B7%A5%E5%85%B7-%E6%92%A4%E6%B6%88%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95%E5%92%8C%E6%8E%A5%E5%8F%97%E6%9B%B4%E6%94%B9)面板中接受或取消更改。

### 热键

| **热键** | **说明** |
| --- | --- |
| **Shift + 点击 + 拖动** | 擦除已绘制的多边形组。 |
| **[或S** | 缩小笔刷尺寸。按住 **Shift** 可减小级别。 |
| **]或D** | 增加笔刷尺寸。按住 **Shift** 可减小级别。 |
| **Shift + Q** | 创建新组并将其应用于 **设置组（Set Group）** 。 |
| **Shift + G** | 将悬停的组指定为 **设置组（Set Group）** 。 |
| **Shift + F** | 冻结或取消冻结悬停的组。 |
| **Enter** | 接受工具更改。 |
| **ESC** | 取消更改并退出工具。 |
