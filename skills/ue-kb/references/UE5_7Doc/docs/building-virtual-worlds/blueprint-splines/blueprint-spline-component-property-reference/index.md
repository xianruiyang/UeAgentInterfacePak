---
title: "蓝图样条组件属性参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/blueprint-spline-component-property-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "构建虚拟世界", "蓝图样条", "蓝图样条组件属性参考"]
---

# 蓝图样条组件属性参考

> 路径：虚幻引擎5.7文档 / 构建虚拟世界 / 蓝图样条 / 蓝图样条组件属性参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/blueprint-spline-component-property-reference-in-unreal-engine

本页面包含了一个在 **蓝图样条组件（Blueprint Spline Components）** 中可用属性的参考列表。如果在 **蓝图编辑器（Blueprint Editor）** 中选择了 **蓝图样条组件（Blueprint Spline Component）**，是 **根组件（Root Component）**，或者在 **关卡编辑器（Level Editor）** 中选择了该组件，则显示的属性将略有不同。

## 属性

### 变形

| 属性 | 说明 |
| --- | --- |
| **位置（Location）** | **Actor** 或 **组件（Component）** 在 **世界场景空间（World Space）** 中或 **相对于（Relative）** 其父项的位置。 |
| **旋转（Rotation）** | **Actor** 或 **组件（Component）** 在 **世界场景空间（World Space）** 中或 **相对于（Relative）** 其父项的旋转。 |
| **缩放（Scale）** | **Actor** 或 **组件（Component）** 在 **世界场景空间（World Space）** 中或 **相对于（Relative）** 其父项的缩放。 |

### 插槽

| 属性 | 说明 |
| --- | --- |
| **父插槽（Parent Socket）** | 当这个组件是 **骨架网格体组件（Skeletal Mesh Component）** 的 **子项（Child）**（或带有 **插槽（Socket）** 的 **静态网格体组件（Static Mesh Component）**）时，你可以指定一个 **插槽（Socket）** 或 **关节（Joint）** 来将这个组件附加到其上。 |

### 样条

| 属性 | 说明 |
| --- | --- |
| **时长（Duration）** | 指定样条的持续时间，以秒为单位。 |
| **覆盖构造脚本（Override Construction Script）** | 该样条是否已被样条组件可视化器从其默认设置中进行过编辑。 |
| **将样条点输入到构造脚本中（Input Spline Points to Construction Script）** | 是否应该将样条点传递到用户构造脚本，以便由脚本对其进一步操作。 |
| **绘制调试（Draw Debug）** | 如果为True，且样条显示标记被设置过，则会渲染样条。 |
| **闭环（Closed Loop）** | 样条是否被视为闭环。 |
| **默认向上矢量（Default Up Vector）** | 在沿样条计算变换时，将使用本地空间中的默认向上矢量。 |

### 高级

| 属性 | 说明 |
| --- | --- |
| **每分段重参数化步数（Reparam Steps Per Segment）** | 在重新参数化表中为每个样条段分配的步数数量。 |
| **固定端点（Stationary Endpoints）** | 在以非恒定速度沿样条移动时，是否将样条端点视为固定点。 |

### 编辑器

| 属性 | 说明 |
| --- | --- |
| **编辑器未选中的样条片段颜色（Editor Unselected Spline Segment Color）** | 编辑器中未选中的样条组件片段的颜色。 |
| **编辑器选中的样条片段颜色（Editor Selected Spline Segment Color）** | 编辑器中选中的样条组件片段的颜色。 |
| **应可视化缩放（Should Visualize Scale）** | 是否应该在编辑器中显示缩放可视化。 |
| **缩放可视化宽度（Scale Visualization Width）** | 在编辑器中启用缩放可视化时样条的宽度。 |

### 选中的点

| 属性 | 说明 |
| --- | --- |
| **输入键（Input Key）** | 这是曲线上选定的 **曲线点（Curve Point）** 的索引。 |
| **位置（Position）** | 这是所选 **曲线点（Curve Point）** 在局部空间中的位置。 |
| **到达切线（Arrive Tangent）** | 这个矢量定义了曲线在接近选定 **曲线点（Curve Point）** 时的切线。 |
| **离开切线（Leave Tangent）** | 这个矢量定义了曲线在离开选定 **曲线点（Curve Point）** 时的切线。 |
| **旋转（Rotation）** | 旋转可应用于 **曲线点（Curve Point）** 以修改其切线。这个值与切线是分开应用的，因此可以对两者进行修改以创建所需的结果。 |
| **缩放（Scale）** | 缩放可应用于 **曲线点（Curve Point）** 以修改其切线。这个值与切线是分开应用的，因此可以对两者进行修改以创建所需的结果。 |
| **类型（Type）** | 定义选定 **曲线点（Curve Point）** 处的曲线类型。 **线性（Linear）**：从选定的 **曲线点（Curve Point）** 到下一个点，曲线将是笔直的。这将影响进入所选 **曲线点（Curve Point）** 的切线以及离开下一个点的切线。 **曲线（Curve）**：默认值。**曲线点（Curve Points）** 的位置（选定曲线点之前和之后）定义了所选 **曲线点（Curve Point）** 的切线。 **常量（Constant）**：类似 **线性（Linear）**，但 **不** 影响进入所选 **曲线点（Curve Point）** 的切线以及离开下一个点的切线。 **CurveClamped**：类似 **曲线（Curve）**，但它夹住曲线的切线。 **曲线自定义切线（CurveCustomTangent）**：如果你调整 **曲线点（Curve Point）** 上的任何切线，它将被设置为此值。 |

### 标签

| 属性 | 说明 |
| --- | --- |
| **组件标签（Component Tags）** | 标签数组，可用于分组和分类。也可以通过脚本访问。 |

### 激活

| 属性 | 说明 |
| --- | --- |
| **自动激活（Auto Activate）** | 是在创建时自动激活组件，还是必须显式激活组件。 |

### 事件

| 属性 | 说明 |
| --- | --- |
| **在组件命中时（On Component Hit）** | 在组件命中某些固体，或被某些固体命中时调用的事件。 |
| **在组件开始重叠时（On Component Begin Overlap）** | 当某些物体开始与组件重叠时调用的事件，如玩家走入触发器。 |
| **在组件结束重叠时（On Component End Overlap）** | 当某些物体不再与组件重叠时调用的事件。 |
| **在组件唤醒时（On Component Wake）** | 当底层物理对象被唤醒时调用的事件。 |
| **在组件睡眠时（On Component Sleep）** | 当底层物理对象开始休眠时调用的事件。 |
| **在光标开始悬停时（On Begin Cursor Over）** | 当鼠标光标移动到此组件上方，且玩家控制器启用了鼠标悬停事件时调用的事件。 |
| **在光标结束悬停时（On End Cursor Over）** | 当鼠标光标离开此组件上方，且玩家控制器启用了鼠标悬停事件时调用的事件。 |
| **在单击时（On Clicked）** | 当鼠标光标位于此组件上方并按下鼠标左键，且玩家控制器启用了点击事件时调用的事件。 |
| **在释放时（On Released）** | 当鼠标光标位于此组件上方并释放鼠标左键，且玩家控制器启用了点击事件时调用的事件。 |
| **在输入触摸开始时（On Input Touch Begin）** | 当此组件上接收到触摸输入，且玩家控制器启用了触摸事件时调用的事件。 |
| **在输入触摸结束时（On Input Touch End）** | 当此组件上的触摸输入被释放，且玩家控制器启用了触摸事件时调用的事件。 |
| **在输入触摸进入时（On Input Touch Enter）** | 当手指移动到此组件上方，且玩家控制器启用了触摸事件时调用的事件。 |
| **在输入触摸离开时（On Input Touch Leave）** | 当手指离开此组件上方，且玩家控制器启用了触摸事件时调用的事件。 |
| **物理体积已更改（Physics Volume Changed）** | 当物理体积更改时将调用的委托。 |
