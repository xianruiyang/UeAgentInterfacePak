# FABRIK动画蓝图节点

---
title: "FABRIK动画蓝图节点"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/fabrik-animation-blueprint-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画蓝图", "动画节点参考", "FABRIK动画蓝图节点"]
---

# FABRIK动画蓝图节点

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画蓝图 / 动画节点参考 / FABRIK动画蓝图节点

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/fabrik-animation-blueprint-in-unreal-engine

**前后延伸反向运动学（Forward And Backward Reaching Inverse Kinematics，简称 FABRIK）**，是处理一串任意长度的[骨骼](../../../animation-assets-and-features/skeletons/index.md)（至少 2 节）的 IK 解算器。

![fabrik动画蓝图节点](../../../../../../assets/images/de/deaf9cd276e47859acbf4a40676023809fc955d850e85a06c74c9278be24cafd.jpg)

## 概览

你可以将 **FABRIK** 蓝图节点添加到动画蓝图的 **动画图表（AnimGraph）** 中。添加后，你可以通过物体的 **组件姿势（Component Pose）** 将FABRIK节点整合到动画蓝图。

你可以使用FABRIK节点的 **效果器变换（Effector Transform）** 输入引脚，连接一个[变换变量](../../../../../blueprints-visual-scripting/specialized-blueprint-visual-scripting-node-groups/blueprint-variables/index.md)，来控制骨骼对于骨骼链的 **相对（relative）** 或者 **绝对（absolute）** 变换。你可以使用相对变换来引用同一骨架上的不同骨骼进行变换，或者使用绝对变换在没有引用的情况下对骨骼链进行变换。

![效果器转换变量输入引脚](../../../../../../assets/images/5e/5ee07eb47bfe68beb60a050a3b82887a1b980f15aa21f5f7bac6bed350b680ce.jpg)

要决定应用的 **骨骼控制（Skeletal Control）** 的力度，你可以设置 **Alpha** 输入引脚的Alpha值。你既可以手动设置Alpha输入引脚，也可以通过动画图表中的动态变量来设置。Alpha值越大，意味着更多的骨骼控制，数值越小控制越少。

![alpha变量值输入引脚](../../../../../../assets/images/92/92609376fc7cbe180e4b6273400f24a000a8549f1ec1e983413edf983bf7e2b1.png)

## Properties and Settings

在 **FABRIK** 节点的 **细节（Details）** 面板中，你可以找到可用于进一步调整解算器功能的更多设置：

![fabrik动画蓝图节点细节面板属性](../../../../../../assets/images/31/31a1b360ebe185b7224dd929d2013dee8b8b692f03133798bd9aff1d7116b165.png)

在 **最终效果器（End Effector）** 部分，你可以确定目标位置和旋转角度。

> [!NOTE]
> FABRIK节点的细节面板中的 **最终效果器（End Effector）** 属性与[TwoBone_IK](../../../animation-assets-and-features/skeletons/index.md) 节点属性很相似。

| 属性 | 描述 |
| --- | --- |
| **位置（Location）、旋转（Rotation）、比例（Scale）** | 末梢骨骼的目标位置的坐标 - 如果 **效果器位置空间** 设为 **骨骼**，那么这就是相对于作为目标位置使用的目标骨骼的偏移（也可以在节点上作为引脚设置）。 |
| **效果器转换空间（Effector Transform Space** | 设置骨骼在骨骼网格组件的参考帧中的位置。 |
| **效果器转换骨骼（Effector Transform Bone）** | 如果 **效果器转换空间** 设为 **骨骼**，那么这就是要使用的骨骼。 |
| **效果器旋转源（Effector Rotation Source）** | 控制旋转（维持组件空间、局部空间或匹配最终效果器目标旋转）。 |

在 **解算器（Solver）**部分，您可以定义要使用的骨骼串，从 **根** 至 **末梢**。末梢将尽量到达最终效果器位置。

| 属性 | 说明 |
| --- | --- |
| **末梢骨骼（Tip Bone）** | 从 **骨骼树** 中设置引用 **末梢骨骼**。 |
| **根骨骼（Root Bone）** | 从 **骨骼树** 中设置引用 **根骨骼**。 |
| **精度（Precision）** | 最终 **末梢骨骼** 位置相对于 **效果器位置** 输入引脚之差的 **容差（Tolerance）**。该值越低，到达 **最终效果器** 目标的精度越高，但性能成本也越高。 |
| **最大迭代次数（Max Iterations）** | 为了控制性能和确保大量使用不会使帧率下降而允许的最大迭代次数。 |
| **启用调试绘图（Enable Debug Draw）** | 切换用于调试关节旋转的轴的绘制。 |

在 **设置（Settings）** 部分，可以设置应用的力度。

| 属性 | 说明 |
| --- | --- |
| **阿尔法（Alpha）** | 骨骼控件的当前力度（也可作为节点上的引脚设置）。 |
| **阿尔法标度偏差（Alpha Scale Bias）** | 设置 **最小** 和 **最大** 输入标度值。 |
| **节点（Node）** | 如果将它设置为非 **相对于父项的局部旋转**，可以用于重置 **效果器旋转源（Effector Rotation Source）**。 |

