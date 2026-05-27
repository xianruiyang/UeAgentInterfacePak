---
title: "基于物理的动画"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/physics-driven-animation-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画操作指南和示例", "基于物理的动画"]
---

# 基于物理的动画

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画操作指南和示例 / 基于物理的动画

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/physics-driven-animation-in-unreal-engine

本文介绍了如何给你的角色及骨架网格物体应用物理驱动的动画。该理念是，你可以随同你的关键帧动画混入模拟结果，从而使得需要呈现"布娃娃"效果的角色产生自然模拟的感觉。

在[内容示例](../../../../samples-and-tutorials/content-examples-sample-project/index.md)项目的 PhysicalAnimation.umap 地图中可以看到这个概念的应用示例。在该地图中，我们有一系列应用了动画的骨架网格物体。在每骨架网格物体中，我们也可以通过某种形式进行交互，及查看处理现有运动的物理动画。

需要注意的是，在骨架网格物体上以任何形式应用物理都需要那个网格物体设置Physics Asset（物理资源），并应用该物理资源。请参照相关文档获得关于[物理资源工具(PhAT)](../../../../gameplay-systems/physics/physics-asset-editor/index.md)的内容。

> [!NOTE]
> 为了实现总体的简单性，在这个示例中我们使用了骨架网格物体。同样的技术也可以应用到角色或Pawn上，只需在动画蓝图的事件图表中简单地应用 **Set All Bodies Simulate Physics** 和 **Set All Bodies Below Physics Blend Weight** 节点即可，而不是像我们在该示例中那样在蓝图Actor的图表中进行操作。

## 设置

给角色应用物理有很多种方法，我们的示例仅显示了几种可能性。在我们的方法中，你需要的两个主要工具是 **Set All Bodies Simulate Physics** 和 **Set All Bodies Below Physics Blend Weight** 节点，一般将它们放置在你的角色动画蓝图图表中。

### Set All Bodies Below Simulate Physics（设置之下所有刚体模拟物理）

**Set All Bodies Below Simulate Physics（设置之下所有刚体模拟物理）** 节点的作用是递归地激活骨架网格物体上的物理资源刚体，从给定骨骼开始模拟物理，并递归地沿着骨骼链向下移动。比如，如果你让左锁骨开始模拟，那么在骨架层次结构中位于其下面的所有骨骼也会开始模拟，最终产生一条柔软的或者是类似于布娃娃效果的手臂。简单地说，你可以把这个节点看成一个用于启动或暂停从特定节点开始模拟物理的开关。

### Set All Bodies Below Physics Blend Weight（设置之下所有刚体的物理混合权重）

该节点简单地控制物理资源对动画骨架网格物体影响的程度。值为1.0，则使用物理驱动给定骨骼及该骨骼下的所有骨骼。值为0.0，则骨架网格物体返回到其初始关键帧动画。通常，你要在每次更新时驱动该节点，以便你可以平滑地改变Physics Blend Weight(物理混合权重)的值。

## 基于碰撞的反应的概述

基于碰撞的物理反应是角色模拟的常用情形，比如，当角色被射弹击中时。从高的层次来讲，这要求你：

- 获得碰撞到的骨骼的名称。这可以通过速效武器的踪迹来完成，或者在射弹类的适当地方完成。
- 将那个骨骼名称传递到角色的动画蓝图中，以供事件图表使用, 一般通过

  Set All Bodies Below Simulate Physics

  节点完成。这激活了模拟系统。
- 通过

  Set All Below Physics Blend Weight

  节点控制物理混合权重属性。一般，你会想快速地使它增加到1.0，然后在下降回到0.0，以便物理反应混入然后再混出。这一般在动画蓝图的事件图表中完成。
- 一旦反应完成且物理混合权重返回为0，那么你应该再次使用

  Set All Bodies Below Simulate Physics

  节点来禁用该模拟。

> [!NOTE]
> 你可以在Content Examples项目的PhysicalAnimation.umap关卡的Example 1.2中看到关于该技术的示例。
