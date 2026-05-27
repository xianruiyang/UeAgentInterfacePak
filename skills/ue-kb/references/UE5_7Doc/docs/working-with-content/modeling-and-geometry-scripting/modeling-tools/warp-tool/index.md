---
title: "扭曲"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/warp-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模工具", "扭曲"]
---

# 扭曲

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模工具 / 扭曲

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/warp-tool-in-unreal-engine

**扭曲（Warp）** 工具使用弯曲（bend）、迸发（flare）和扭转（twist）等非线性变换，改变网格体的形状。

## 访问工具

你可以通过以下方法访问扭曲工具：

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

## 使用工具

你可以从 **操作类型（Operation Type）** 属性中选择以下变换来使网格体变形：

- 弯曲（Bend）
- 迸发（Flare）
- 扭转（Twist）

扭曲工具使用独特的小工具（额外T形控点）调整变形程度。你可以 **按住Ctrl并点击** ，将小工具放入特定网格体区域。在**选项（Options）** 分段中，句柄以数字方式表示如下：

- 上边界（Upper Bound）
- 下边界（Lower Bound）
- 角度或百分比（Degree or percentage）

工具使用完毕后，在[工具确认](../../getting-started-with-modeling-mode/modeling-mode/index.md#%E5%B7%A5%E5%85%B7%E6%92%A4%E9%94%80%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95%E5%92%8C%E6%8E%A5%E5%8F%97%E6%9B%B4%E6%94%B9)面板中接受或取消更改。

### 热键

| **按键命令** | **操作** |
| --- | --- |
| **Ctrl + 点击** | 重新定位小工具。 |
| **F** | 放大网格体位置。 |
| **ESC** | 取消 更改并退出工具。 |
| **Enter** | 接受工具更改。 |
