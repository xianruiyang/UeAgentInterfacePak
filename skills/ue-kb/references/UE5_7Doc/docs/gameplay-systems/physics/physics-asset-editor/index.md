---
title: "物理资产编辑器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/physics-asset-editor-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "物理资产编辑器"]
---

# 物理资产编辑器

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 物理资产编辑器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/physics-asset-editor-in-unreal-engine

![为操作骨架网格体的物理资产而设计的物理资产编辑器](../../../../assets/images/76/767cbd73069ee7f7383bc08bae495e041a71f8e4e5955e3e84158806f123c322.jpg)

**物理资产编辑器** 是一个集成编辑器，它是虚幻引擎中[动画编辑器](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-editors/index.md)的一部分。它专门设计用于操纵 **骨架网格体** 的 **物理资产**。

![用于定义骨架网格体所使用的物理和碰撞的物理资产](../../../../assets/images/7f/7f91bc85d05ae2a2314ffb2a11cd18be8e52d9d1c1e48761220a8ac2aa4086b8.png)

**物理资产** 用于定义骨架网格体使用的物理和碰撞。它们包含一组刚体和约束，这些构成一个布偶，而布偶并不 局限于人形布偶。它们可以用于任何使用形体和约束的物理模拟。因为一个骨架网格体只允许一个物理资产， 所以可以为许多骨架网格体打开或关闭它们。

| 人型角色 | 演示中的越野车 |
| --- | --- |
| 角色物理资产 | 载具物理资产 |

可以为任何骨架网格体设置物理资产进行模拟。上面是使用它们的两个示例；一个是人形角色，另一个是Epic的演示版载具游戏的车辆。

## 创建物理资产

为骨架网格体创建物理资产的方法有两种：

- 在导入时启用 **创建物理资产（Create Physics Asset）**。

  ![undefined](../../../../assets/images/0a/0a4b1ed34bde31c8c04dec051eaa5ec5f6d16911f9127cdc8860243efdbb3852.png)

  点击查看大图
- 使用 **内容侧滑菜单** 创建物理资产并选择要使用的骨架网格体。

  ![undefined](../../../../assets/images/51/519bf07a92d6cadba1f9db279369242891622cb8d268e258b64254445efefb0e.png)

  点击查看大图

  第一次选择物理资产时，将打开一个窗口来设置应该如何生成形体和约束：

  ![用于设置如何生成形体和约束的窗口](../../../../assets/images/1e/1eab130bf2a432d457ecd3956d302c0e829454db897c3f763183c942e680ee4c.png)

## 打开物理资产编辑器

可以使用几种不同的方式打开 **物理资产编辑器**：

- 双击 **内容侧滑菜单** 中的 **物理资产**。

  ![双击内容侧滑菜单中的物理资产](../../../../assets/images/f8/f8407a9398aa36b7ba522d7d6362650067ae0621df279457ff683331e4732767.jpg)
- 使用右键快捷菜单并选择 **编辑...（Edit...）**。

  ![使用右键快捷菜单并选择编辑](../../../../assets/images/c3/c369d7b69d836c1e6fdc7ed3e8137df2bdbd76fa879a1f63fd48199283041f94.jpg)
- 或者，在[动画编辑器](../../../animating-characters-and-objects/skeletal-mesh-animation-system/animation-editors/index.md)选择选项卡中选中 **物理（Physics）** 选项卡。

  ![在动画编辑器选项卡中选择物理选项卡](../../../../assets/images/5f/5f3b0a1a0edad797085c89ccaceca79161d551c30aa079546e1943aa73c8498d.png)

  可以使用 **物理（Physics）** 选项卡旁边的下拉菜单，从 **内容侧滑菜单** 中选择正在使用当前已打开骨架网格体的物理资产。

  > 图片已省略：下拉菜单可用于选择任何物理资产

## 基础


- [物理对象](../physics-bodies/index.md)

- [物理约束](../physics-constraints/index.md) - 在物理对象相互之间和世界场景之间设置约束

## 教程


- [物理资产编辑器教程](physics-asset-editor-tutorial-directory/index.md)
