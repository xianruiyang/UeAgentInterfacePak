---
title: "物理场参考指南"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/reference-guide-for-physics-field-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "物理场", "物理场参考指南"]
---

# 物理场参考指南

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 物理场 / 物理场参考指南

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/reference-guide-for-physics-field-in-unreal-engine

本文介绍了 **虚幻引擎5（Unreal Engine 5）** 中的 **物理场系统（Physics Field System）** 的参考信息。

> [!NOTE]
> Chaos粒子指的是空间中具有各种属性的点，这些属性包括位置、速度和质量，会受到Chaos物理解算器的影响。这些粒子还可以具有其他属性，例如朝向、角速度、惯性和几何形状。

物理场系统有三种主要类型的场。

## 物理场类型

| 场类型 | 说明 |
| --- | --- |
| **瞬态场（Transient Field）** | 在函数或事件调用期间，这些场是在运行时创建、执行和破坏的。 瞬态场用于对物理模拟添加临时效果，例如向与场体积重叠的刚体应用外部张力或线性速度。 |
| **构造场（Construction Field）** | 这些场是在蓝图的构造脚本中创建的，并在每次编译之后存储场。 最常见的构造场示例是锚点场，用于固定几何体集合破裂件。你可以通过 **RemoveConstructionFields** 节点删除组件的所有构造场。 |
| **持久场（Persistent Fields）** | 这些场创建之后始终保持活动，直到将其显式删除。持久场在每次执行物理模拟的更新函数时进行求值。常见示例是禁用场，该场可以用于禁用与其体积重叠的几何体集合的破裂件。你可以通过 **RemovePersistentFields** 节点删除组件的所有持久场。 |

每一种场都会在相互碰撞的Chaos粒子上应用特定的 **物理类型（Physics Type）**，例如线性力（Linear Force）、外部张力（External Strain），或者禁用阈值（Disabled Threshold）。每个物理类型都按照类型进一步分类为整数、标量或向量。

## 场物理类型列表

| 类型 | 物理类型 | 说明 |
| --- | --- | --- |
| **整数（Integer）** | **动态状态（Dynamic State）** | 将Chaos粒子的状态设置为静态、动态、运动或休眠。 |
|  | **激活已禁用项（Activate Disabled）** | 激活所有已禁用的场数值将为0的Chaos粒子。 |
|  | **碰撞组（Collision Group）** | 设置Chaos粒子碰撞组。 |
| **标量（Scalar）** | **外部张力（External Strain）** | 在Chaos粒子上应用外部张力。如果此外部张力大于内部张力，则几何体集合群集将破裂。 |
|  | **内部张力（Internal Strain）** | 将内部张力场添加到Chaos粒子。 |
|  | **禁用阈值（Disabled Threshold）** | 如果线性速度或角速度低于指定的阈值，则禁用Chaos粒子。 |
|  | **休眠阈值（Sleeping Threshold）** | 如果线性速度或角速度低于指定的阈值，则将Chaos粒子设置为休眠模式。 |
|  | **去除粒子（Kill Particles）** | 禁用场评估结果数值大于0的Chaos粒子。这些粒子将被立即禁用。 |
| **向量（Vector）** | **线性力（Linear Force）** | 将向量场添加到Chaos粒子的当前线性力。 |
|  | **线性速度（Linear Velocity）** | 将向量场添加到Chaos粒子的当前线性速度。 |
|  | **角速度（Angular Velocity）** | 将向量场添加到Chaos粒子的当前角速度。 |
|  | **角扭矩（Angular Torque）** | 将向量场添加到Chaos粒子的当前角扭矩。 |

场可以使用不同类型的 **元数据（Meta Data）** 来添加有关如何对场进行求值的其他信息。

## 场的可用元数据列表

| 类型 | 名称 | 说明 |
| --- | --- | --- |
| **状态（State）** | **动态（Dynamic）** | Chaos粒子筛选器，粒子根据物理模拟进行移动。 |
|  | **运动（Kinematic）** | Chaos粒子筛选器，粒子移动但不是由物理模拟驱动。常见示例是通过动画来移动Chaos粒子。 |
|  | **静态（Static）** | Chaos粒子的筛选器，粒子当前不移动，无法从物理模拟接收力。 |
|  | **睡眠（Sleeping）** | 筛选出当前休眠并等待重新激活的Chaos粒子。 |
|  | **禁用（Disabled）** | 筛选出当前被禁用的Chaos粒子。 |
|  | **全部（All）** | Chaos解算器中所有Chaos粒子的筛选器，无论粒子状态如何。 |
| **对象（Object）** | **刚体（Rigid）** | 将场应用于所有物理刚体对象上。 |
|  | **布料（Cloth）** | 将场应用到所有布料对象上。 |
|  | **破坏（Destruction）** | 将场应用到所有几何体集合上。 |
|  | **角色（Character）** | 将场应用到所有刚体角色动画节点上。 |
|  | **全部（All）** | 将场应用到所有Chaos对象上。 |
| **位置（Position）** | **质量中心（Center of Mass）** | 场将在刚体对象的质心被计算。 |
|  | **枢轴点（Pivot Point）** | 场将在刚体对象的枢轴点被计算。 |
| **分辨率（Resolution）** | **最低（Minimum）** | 当前启用的Chaos粒子的筛选器。 |
|  | **父项（Parents）** | 所有顶层父项的群集化Chaos粒子的筛选器。 |
|  | **最大值（Maximum）** | 启用和禁用的Chaos粒子的筛选器。 |

每个场都按照连接到 **物理场（Physics Field）** 节点的 **场节点（Field Node）** 引脚的蓝图图表进行定义。图表定义场的范围和属性。

蓝图图表由 **场节点（Field Nodes）** 构成，这些节点添加为场系统组件的子组件。

## 场节点列表

| 场类型 | 名称 | 说明 |
| --- | --- | --- |
| **整数（Integer）** | **统一整数（Uniform Integer）** | 设置不依赖于样本位置的统一整数值。输出数值等于其大小。 |
|  | **径向整形遮罩（Radial Int Mask）** | 如果样本与场位置的距离小于或大于半径，则将内侧或外侧数值设置为中间结果。根据遮罩条件，最终输出数值将受中间数值影响。 |
| **标量（Scalar）** | **统一标量（Uniform Scalar）** | 设置不依赖于样本位置的统一标量数值。输出数值等于其大小。 |
|  | **波标量（Wave Scalar）** | 根据样本与场位置的距离来设置临时波标量数值。 |
|  | **径向衰减（Radial Falloff）** | 设置随着与球体中心点位置的距离逐渐减少的场标量数值。 |
|  | **平面衰减（Plane Falloff）** | 设置随着与位置/法线对定义的平面的距离逐渐减少的场标量数值。 |
|  | **盒体衰减（Box Falloff）** | 设置随着与盒体中心点位置的距离逐渐减少的场标量数值。 |
|  | **噪点场（Noise Field）** | 如果样本在盒体中，定义Perlin噪点标量数值。 |
| **向量（Vector）** | **统一向量（Uniform Vector）** | 设置不依赖于样本位置的统一标量数值。输出数值等于其大小 * 方向。 |
|  | **径向向量（Radial Vector）** | 设置径向向量数值及其方向，作为从样本位置到场位置的标准化向量。输出数值等于其大小 * 方向。 |
|  | **随机向量（Random Vector）** | 设置不依赖于样本位置的随机向量数值。输出数值等于其大小 * 随机方向。 |
| **运算符（Operator）** | **运算符场（Operator Field）** | 计算两个指定场之间的数学运算。 |
|  | **转换为整数场（To Integer Field）** | 将标量场转换为整数场。 |
|  | **转换为浮点场（To Float Field）** | 将整数场转换为标量场。 |
|  | **剔除场（Culling Field）** | 根据剔除场的结果来对输入场进行求值。 |
