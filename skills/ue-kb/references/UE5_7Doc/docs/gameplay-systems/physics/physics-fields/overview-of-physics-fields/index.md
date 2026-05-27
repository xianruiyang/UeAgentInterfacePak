---
title: "物理场概述"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/overview-of-physics-fields-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "物理场", "物理场概述"]
---

# 物理场概述

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 物理场 / 物理场概述

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/overview-of-physics-fields-in-unreal-engine

**物理场系统（Physics Field System）** 使用户能够在运行时直接影响特定空间中的 **Chaos物理（Chaos Physics）** 模拟效果。你可以对这些场进行配置，以多种方式来影响物理模拟，例如在刚体和布料上施加力、打碎几何体集合群集、锚定或禁用破裂的刚体，以及与刚体动画节点交互。

此外，物理场系统还可以与其他引擎系统通信，例如Niagara和材质。这些系统可以通过内置功能，在特定地点对物理场进行估值计算，从而对物理场进行采样。

若要设置场，先创建 **场系统组件（Field System Component）** 蓝图，然后指定允许哪些系统查询你的场。你可以将场配置为 **世界场（World Field）**，以允许 **材质（Materials）** 和 **Niagara系统（Niagara Systems）** 对场进行采样。此外，你还可以将其配置为 **Chaos场（Chaos Field）**，允许几何体集合、物理对象、布料，以及刚体动画节点与其交互。

在内部，物理场直接影响 **Chaos粒子（Chaos Particles）**。Chaos粒子是指空间中具有各种属性的点，例如位置、速度和质量，可以受到Chaos物理解算器的影响。Chaos粒子的常见示例包括几何体集合中的破碎刚体、附加到角色的刚体，以及布料模拟中的个体顶点。

## 添加物理场

创建蓝图之后，你可以添加三种类型的物理场之一：瞬态、构造、持久。

**瞬态场（Transient Fields）** 在运行时创建、执行和破坏，用于对物理模拟添加临时效果。常见示例包括将对于场体积重叠的刚体施加外部张力或线性速度。

**构造场（Construction Fields）** 是在蓝图的构造脚本中创建的，并在每次编译之后存储场。此类型的场的最常见示例是，用于固定几何体集合破裂件的锚点场。

**持久场（Persistent Fields）** 在创建之后始终保持活动，直到将其显式删除。持久场在每次执行物理模拟的更新函数时进行求值。常见示例是禁用场，该场可以用于禁用与其体积重叠的几何体集合的破裂件。

## 应用物理类型

每一种场都会在相互碰撞的Chaos粒子上应用特定的 **物理类型（Physics Type）**，例如线性力（Linear Force）、外部张力（External Strain），或者禁用阈值（Disabled Threshold）。每个物理类型都按照类型进一步分类为整数、标量或矢量。在材质编辑器和Niagara系统中使用内置功能时，将引用这些类别。

## 添加元数据

场可以使用不同类型的 **元数据（Meta Data）** 来添加有关如何对场进行求值的其他信息。此元数据可以根据Chaos粒子的状态（例如动态、静态、Kinematic、睡眠或禁用）以及对象类型（布料、刚体、破坏和角色） 对Chaos粒子进行筛选。此外，它还能用来设置物理场在刚体内的计算位置，比如是在质心还是枢轴点。

## 定义场

每个场都由一张蓝图图表定义，该图表连接到 **添加瞬态场（Add Transient Field）**、**添加构造场（Add Construction Field）** 或 **添加持久场（Add Persistent Field）** 节点的 **场节点（Field Node）** 引脚。图表定义了场的范围和属性。

蓝图图表由 **场节点（Field Nodes）** 构成，这些节点添加为场系统组件的子组件。这些对象的常见示例包括：盒体和径向衰减、均匀和径向矢量，以及用于合并重叠场的场运算符。

## 可视化场

通过运行适当的控制台命令，持久性物理场可以在关卡中被可视化。在模拟过程中，在控制台输入下列命令。

![在视口中点击](../../../../../assets/images/df/dfa82d2428d4da0feec4f59ba7d90ec7ed14d18b4d808a8368197a8f7756bc88.jpg)

在模拟过程中，请在控制台中输入以下命令：

| **控制台命令** | **可用CVAR** | **描述** |
| --- | --- | --- |
| **r.PhysicsField.Rendering.TargetType** | **1: 动态状态（Dynamic State） 2: 线性力（Linear Force） 3: 外部压力（External Strain） 4: 消灭粒子（Kill Particles） 5: 线性速度（Linear Velocity） 6: 角速度（Angular Velocity） 7: 角扭矩（Angular Torque） 8: 内部压力（Internal Strain） 9: 已禁用阈值（Disabled Threshold） 10: 休眠阈值（Sleeping Threshold） 15: 碰撞组（Collision Group） 16: 激活已禁用（Activate Disabled）** | 设置显示哪种物理场目标类型。 |
| **r.PhysicsField.Rendering.SystemType** | **0：Chaos场 1：世界场** | 设置显示哪种物理场类型。 |
| **r.PhysicsField.Rendering.EvalType** | **0：分析求值（精确，较慢） 1：对Clipmap采样（近似，较快）** | 设置使用哪种场计算方式。 |

如需详细了解此页面中提及的各种元素，请参考[物理场参考指南](../reference-guide-for-physics-field/index.md)。
