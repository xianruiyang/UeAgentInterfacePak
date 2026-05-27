---
title: "物理材质参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/physical-materials-reference-for-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "物理材质", "物理材质参考"]
---

# 物理材质参考

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 物理材质 / 物理材质参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/physical-materials-reference-for-unreal-engine

**物理材质（Physical Materials）** 用于定义物理对象与场景动态交互时的方式。物理材质非常容易使用。创建一个物理材质后，它会提供一组默认值，与应用于所有物理对象的默认物理材质相同。物理材质的例子包括角色尸体（布娃娃）、可移动的木箱等。

## 属性

以下是按主要类别划分的物理材质属性。

## 物理材质

这一类别包含物理材质的核心属性：摩擦力（Friction）、恢复力（Restitution）和密度（Density）。

| 属性 | 说明 |
| --- | --- |
| **摩擦力（Friction）** | 这是表面的摩擦力值，控制物体在该表面上滑动的容易程度。 |
| **摩擦力合并模式（Friction Combine Mode）** | 此属性允许您调整物理材质摩擦力的组合方式。默认情况下此属性设置为平均值（Average），但是可以使用 **覆盖摩擦力合并模式（Override Friction Combine Mode）** 属性来覆盖。 **平均值（Average）**：使用接触的材质的平均值：(a+b)/2 **最小值（Min）**：使用接触的材质的下限值：min(a,b) **乘（Multiply）**：将接触的材质的值相乘：a*b **最大值（Max）**：使用接触的材质的上限值：max(a,b) |
| **覆盖摩擦力合并模式（Override Friction Combine Mode）** | 默认情况下，摩擦力合并模式（Friction Combine Mode）设置为 **平均值（Average）**，通过启用此属性，可以更改接触的物理材质之间摩擦力的组合方式。 |
| **恢复力（Restitution）** | 它指的是表面的"弹性"，或者说该表面与另一个表面碰撞时能保留多少能量。 |
| **恢复力合并模式（Restitution Combine Mode）** | 此属性允许您调整物理材质恢复力的组合方式。默认情况下此属性设置为平均值（Average），但是可以使用 **覆盖恢复力合并模式（Override Restitution Combine Mode）** 属性来覆盖。 **平均值（Average）**：使用接触的材质的平均值：(a+b)/2 **最小值（Min）**：使用接触的材质的下限值：min(a,b) **乘（Multiply）**：将接触的材质的值相乘：a*b **最大值（Max）**：使用接触的材质的上限值：max(a,b) |
| **覆盖恢复力合并模式（Override Restitution Combine Mode）** | 默认情况下，恢复力合并模式（Restitution Combine Mode）设置为 **平均值（Average）**，通过启用此属性，可以更改接触的物理材质之间恢复力的组合方式。 |
| **密度（Density）** | 用于与物体形状一起计算其质量属性。数值越高，物体越重。单位为每立方 **厘米** 的 **克** 数。 |

### 高级

此类别包含一个属性，用于更改比例如何影响应用该物理材质的Actor的质量。

| 属性 | 说明 |
| --- | --- |
| **根据力提升质量（Raise Mass To Power）** | 用于调整在物体变大时质量增加的方式。这适用于基于"固体"物体计算出的质量。事实上，较大的物体往往不是实心的，而变得更像"贝壳"（例如，汽车就不是实心金属块）。值限制为1或更小。 |

## 破坏

特定于虚幻引擎4中的破坏系统的属性。

| 属性 | 说明 |
| --- | --- |
| **可破坏物伤害阈值比例（Destructible Damage Threshold Scale）** | 在应用此物理材质的任何可破坏物上衡量伤害阈值的比例。 |

## 物理属性

物理材质的游戏进程相关属性。

| 属性 | 说明 |
| --- | --- |
| **表面类型（Surface Type）** | 在"DefaultEngine.ini"文件中为您的项目设置表面类型（Surface Type）。它们定义了一个枚举，在引擎中用于定义任何数量的东西，从角色走过某个表面时播放的声音，到爆炸应该在不同表面留下的贴花类型。 您可以使用项目设置（ProjectSetting）/物理（Physics）/物理表面（Physical Surfaces） 您可以在代码或蓝图中提取这些数据： 根据默认设置，在不编辑源代码的情况下，您只能使用30种表面类型，其标记为SurfaceType1到SurfaceType30。 |

## 载具

这些属性特定于虚幻引擎4中的载具。虽然它们可能会表示它们处理的是轮胎，但它们只在应用于载具时才这样做（例如轮胎数据类型（Tire Data Type）和车轮蓝图（Wheel Blueprint），不直接引用物理材质）。

| 属性 | 说明 |
| --- | --- |
| **轮胎摩擦力比例（Tire Friction Scale）** | 当该物理材质应用于载具时，轮胎的总摩擦力标量。此值与车轮的特定摩擦力比例（Friction Scale）值相乘。 |
| **轮胎摩擦力比例（Tire Friction Scales）** | 当这种物理材质应用于载具时，特定车轮的轮胎摩擦力标量。这些值与车轮的特定摩擦力比例（Friction Scale）值相乘。 |
