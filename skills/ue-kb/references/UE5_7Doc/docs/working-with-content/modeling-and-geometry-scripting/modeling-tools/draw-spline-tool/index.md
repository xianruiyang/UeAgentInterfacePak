---
title: "绘制样条线"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/draw-spline-tool-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "管理内容", "建模和几何体脚本编写", "建模工具", "绘制样条线"]
---

# 绘制样条线

> 路径：虚幻引擎5.7文档 / 管理内容 / 建模和几何体脚本编写 / 建模工具 / 绘制样条线

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/draw-spline-tool-in-unreal-engine

**绘制样条线（Draw Spline）** 工具能在关卡编辑器中创建样条线。你可以通过 **旋转样条线（Revolve Spline）** 和 **网格体样条线（Mesh Splines）** 建模工具使用创建的样条线来创建网格体，或使用自定义蓝图Actor创建各种对象，例如轨道或藤蔓。

如需详细了解其他样条线工作流程，请查看以下内容：

- 蓝图样条线
- 摄像机绑定

> [!NOTE]
> 你可以在工具外部编辑样条线，方法是选择并操控样条线上的点，右键点击样条线，或使用 **细节（Details）** 面板。

## 访问工具

你可以在 **建模模式（Modeling Mode）** 中的 **创建（Create）** 类别中找到绘制样条线工具。如需详细了解建模模式以及访问方法，请参阅[建模模式概述](../../getting-started-with-modeling-mode/modeling-mode/index.md)。

## 使用绘制样条线

要创建样条线，请按照以下步骤操作：

1. 在 **输出模式（Output Mode）** 下拉菜单中选择样条线的输出类型。
2. 在 **绘制模式（Draw Mode）** 下拉菜单中选择如何绘制你的样条线。
3. 在关卡中点击或拖动以绘制你的样条线。
4. 在[工具确认](../../getting-started-with-modeling-mode/modeling-mode/index.md#%E5%B7%A5%E5%85%B7%E6%92%A4%E9%94%80%E5%8E%86%E5%8F%B2%E8%AE%B0%E5%BD%95%E5%92%8C%E6%8E%A5%E5%8F%97%E6%9B%B4%E6%94%B9)面板中接受或取消更改。

### 输出模式

**输出模式（Output Mode）** 决定了样条线组件的创建方式。

| **输出模式** | **说明** |
| --- | --- |
| **空Actor（Empty Actor）** | 使用样条线组件创建空Actor。 |
| **现有Actor（Existing Actor）** | 将样条线组件附加到现有Actor，如果 **要替换的现有样条线索引（Existing Spline Index To Replace）** 有效，则替换该Actor中的样条线。要选择现有Actor，在切换模式之前点击Actor，或使用滴管来选择。 |
| **创建蓝图（Create Blueprint）** | 创建 **要创建的蓝图（Blueprint To Create）** 指定的蓝图，并将样条线附加到该蓝图，如果 **要替换的现有样条线索引（Existing Spline Index To Replace）** 有效，则替换创建的对象中的现有样条线。 |

> [!TIP]
> 如果你使用的蓝图Actor有成本高昂的构造脚本，关闭高级选项下的 **拖动时重新运行构造脚本（Rerun Construction Script on Drag）** 会很有用。

### 绘制模式

要调整如何在场景中绘制样条线，请使用 **绘制模式（Draw Mode）** 分段中的属性。在关卡中创建样条线时，你可以切换不同的模式。

| **绘制模式** | **说明** | **示例** |
| --- | --- | --- |
| **切线拖动（Tangent Drag）** | 手动控制曲率（通过切线）来逐点绘制样条线。点击以放置一个点并拖动以设置其切线。点击而不拖动会创建锐利的内角。 |  |
| **点击自动切线（Click Auto Tangent）** | 使用自动设置的曲率逐点绘制样条线。点击并拖动以放置新点，并自动设置切线。 |  |
| **自由绘制（Free Draw）** | 使用徒手动作绘制样条线。点击并拖动以放置多个点，间距由 **最小点间距（Min Point Spacing）** 控制。 |  |

你可以通过开关 **回路（Loop）** 来获得开放或闭合的路径。为true时，点会在你绘制的过程中继续附加到回路。要帮助可视化路径和旋转，请增加 **帧可视化宽度（Frame Visualization Width）** 值。

### 光线投射目标

**光线投射目标（Raycast Targets）** 分段将确定在绘制样条线时鼠标位置如何与场景交互。你可以同时切换多个选项。

> [!WARNING]
> 你必须启用至少一个选项才能绘制样条线。

| **光线投射目标** | **说明** | **示例** |
| --- | --- | --- |
| **世界（World）** | 样条线在关卡中的网格体表面上绘制，但在启用 **现有Actor（Existing Actor）** 时，目标网格体除外。 |  |
| **自定义平面（Custom Plane）** | 样条线在你可以使用小工具或使用 **Ctrl + 点击** 重新定位的平面上绘制。 |  |
| **地平面（Ground Planes）** | 样条线在透视视口中的XY地平面上绘制，或在正交视口中的查看平面上绘制。 |  |

### 热键

| **热键** | **说明** |
| --- | --- |
| **C** | 放大鼠标的位置。 |
| **Enter** | 接受工具更改。 |
| **ESC** | 取消更改并退出工具。 |
