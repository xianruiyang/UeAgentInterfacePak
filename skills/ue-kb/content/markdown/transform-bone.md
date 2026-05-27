# Transform Bone

---
title: "Transform Bone"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-transform-bone-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画蓝图", "动画节点参考", "骨骼控制", "Transform Bone"]
---

# Transform Bone

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画蓝图 / 动画节点参考 / 骨骼控制 / Transform Bone

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-transform-bone-in-unreal-engine

你可以使用[动画蓝图](../../../../../skeletal-mesh-animation-system/animation-blueprints/index.md)中的 **Transform (Modify) Bone** 节点对指定骨骼进行变换（**平移** 、 **旋转** 和 **缩放** 。

![transform bone动画蓝图节点](../../../../../../../assets/images/a5/a526d279bf608072a04e9fd68846cc7e4d13f1bc06c35685873c802a0e702517.jpg)

使用 **要修改的骨骼（Bone to Modify）** 属性选择要控制的骨骼之后，你可以在 **平移（Translation）** 、 **旋转（Rotation）** 和 **缩放（Scale）** 属性分段中选择变换模式种类。此处选择了角色的 `upperarm_l` ，并且正在使用视口中的控制器进行累加变换。

> 动图已省略：transform modify bone动画蓝图节点演示

Transform Bone节点在 **组件空间（Component Space）** 中运行，因此需要进行[空间转换](../../../../../skeletal-mesh-animation-system/animation-blueprints/animation-blueprint-nodes/animation-blueprint-component-space-022a8e09/index.md)，以在角色的动画蓝图中实现该节点。

## 属性参考

![transform bone动画蓝图节点细节面板](../../../../../../../assets/images/7b/7b66d7b65fd2ac209d6f8e4befa0500d45e77ebd2fb807409afc1105ed1dade2.jpg)

下面你可以参考Transform Bone节点的一系列属性。

| 属性 | 说明 |
| --- | --- |
| **要修改的骨骼（Bone To Modify）** | 从角色的[骨架](../../../../../skeletal-mesh-animation-system/animation-assets-and-features/skeletons/index.md)选择要使用Transform Bone节点控制的骨骼。 |
| **平移（Translation）** | 控制所选骨骼的 **平移** 。默认情况下，平移坐标可在AnimGraph中控制。 你可以使用 **平移模式（Translation Mode）** 属性设置节点，以 **忽略（Ignore）** 节点所做的修改并保留骨骼上的现有平移，**替换现有（Replace Existing）** 以将骨骼上的平移替换为节点所执行的平移，以及 **添加到现有（Add to Existing）** 以将Transform Bone的平移添加到骨骼上的现有平移。 你还可以设置节点的 **平移空间（Translation Space）** ，以控制应用了平移的空间。你可以设置以下选项： **世界空间（World Space）** ：根据世界空间中的绝对位置应用平移。 **组件空间（Component Space）** ：根据骨骼相对于[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)的参考帧的位置应用平移。 **父骨骼空间（Parent Bone Space）** ：根据骨骼相对于父骨骼的位置应用平移。 **骨骼空间（Bone Space）** ：根据骨骼自己的参考帧应用平移。 |
| **旋转（Rotation）** | 控制所选骨骼的 **旋转** 。默认情况下，旋转坐标可在AnimGraph中控制。 你可以使用 **旋转模式（Rotation Mode）** 属性设置节点，以 **忽略（Ignore）** 节点所做的修改并保留骨骼上的现有旋转，**替换现有（Replace Existing）** 以将骨骼上的旋转替换为节点所执行的旋转，以及 **添加到现有（Add to Existing）** 以将Transform Bone的旋转添加到骨骼上的现有旋转。 你还可以设置节点的 **旋转空间（Rotation Space）** ，以控制应用了旋转的空间。你可以设置以下选项： **世界空间（World Space）** ：根据世界空间中的绝对位置应用旋转。 **组件空间（Component Space）** ：根据骨骼相对于[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)** 的参考帧的位置应用旋转。 **父骨骼空间（Parent Bone Space）** ：根据骨骼相对于父骨骼的位置应用旋转。 **骨骼空间（Bone Space）** ：根据骨骼自己的参考帧应用旋转。 |
| **缩放（Scale）** | 控制所选骨骼的 **缩放** 。默认情况下，缩放坐标可在AnimGraph中控制。 你可以使用 **缩放模式（Scale Mode）** 属性设置节点，以 **忽略（Ignore）** 节点所做的修改并保留骨骼上的现有缩放，**替换现有（Replace Existing）** 以将骨骼上的缩放替换为节点所执行的缩放，以及 **添加到现有（Add to Existing）** 以将Transform Bone的缩放添加到骨骼上的现有缩放。 你还可以设置节点的 **缩放空间（Scale Space）** ，以控制应用了缩放的空间。你可以设置以下选项： **世界空间（World Space）** ：根据世界空间中的绝对位置应用缩放。 **组件空间（Component Space）** ：根据骨骼相对于[骨骼网格体](../../../../../../working-with-content/skeletal-mesh-assets/index.md)** 的参考帧的位置应用缩放。 **父骨骼空间（Parent Bone Space）** ：根据骨骼相对于父骨骼的位置应用缩放。 **骨骼空间（Bone Space）** ：根据骨骼自己的参考帧应用缩放。 |

