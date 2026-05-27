# Look At

---
title: "Look At"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-head-look-at-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画蓝图", "动画节点参考", "骨骼控制", "Look At"]
---

# Look At

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画蓝图 / 动画节点参考 / 骨骼控制 / Look At

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-head-look-at-in-unreal-engine

借助 [动画蓝图](../../../../../skeletal-mesh-animation-system/animation-blueprints/index.md) 中的 **Loot At** 节点，你可以控制骨骼的旋转效果，让骨骼始终对齐某个参考对象。

![look at骨骼控制动画蓝图节点](../../../../../../../assets/images/d0/d02017b72900288ad692984ea86587ae27ef51eeedeed916b6cef07d442cf18e.jpg)

你可以使用Loot At节点控制头部的旋转，让骨骼跟随某个参考对象。你甚至可以让骨骼跟随角色骨架另一骨骼的运动。

此处，你可以看到，Loot At节点用于让角色头部跟随角色手部。之后，**查看位置（Look At Location）** 从手部位置偏移，同时头部继续跟随偏移位置。

> 动图已省略：look at骨骼控制动画蓝图节点演示

## 属性参考

![look at骨骼控制动画蓝图节点细节面板](../../../../../../../assets/images/30/3016da37d93e01c903c2934a78dabac84b70209e5224dbc05d7abec4d5e9656e.png)

你可以在此处参考Look At节点的属性列表。

| 属性 | 说明 |
| --- | --- |
| **要修改的骨骼（Bone to Modify）** | 从角色的骨骼中选择要使用 **查看目标（Look at Target）** 和 **查看位置（Look at Location）** 属性驱动的骨架。 |
| **查看轴（Look at Axis）** | 将 **要修改的骨骼（Bone to Modify）** 的轴设置为指向 **查看目标（Look at Target）** 。值为1将使轴计入在内，值为0将使轴排除在外。值集为（0, 0, 0）将允许使用默认轴。启用 **局部空间（Local Space）** 属性，你还可以使轴计入局部空间。禁用 **局部空间（Local Space）** 属性时，轴将计入世界空间。 |
| **使用查找轴（Use Look Up Axis）** | 启用后，**边界骨骼（Bound Bone）** 将指向 **查找轴（Look Up Axis）** 。 |
| **插值类型** | 选择计入已修改运动的插值类型。选项包括： **一次方（Linear）** ：沿线性轨迹混合。 **三次方（Cubic）** ：沿三次轨迹混合。 **正弦曲线（Sinusoidal）** ：沿正弦波轨迹混合。 **缓入缓出2次幂（Ease in Out Exponent 2）** ：沿平方轨迹混入混出。 **缓入缓出3次幂（Ease in Out Exponent 3）** ：沿三次方轨迹混入混出。 **缓入缓出4次幂（Ease in Out Exponent 4）** ：沿四次方轨迹混入混出。 **缓入缓出5次幂（Ease in Out Exponent 5）** ：沿五次方轨迹混入混出。 |
| **查找轴（Look Up Axis）** | 启用 **使用查找轴（Use Look Up Axis）** 时，设置轴将 **要修改的骨骼（Bone to Modify）** 与 **查看目标（Look at Target）** 对齐。你也可以启用 **在局部空间（In Local Space）** ，将轴计入局部空间。禁用 **在局部空间（In Local Space）** 时，轴将计入世界空间。 |
| **查看限制（Look at Clamp）** | 设置限制值，以限制 **边界骨骼（Bound Bone）** 可以在 **X** 、 **Y** 和 **Z** 轴上旋转的角度。 由于用作 **查看轴（Look at Axis）** 的轴被占用，所以限制时只会使用其他轴。例如，如果 **查看轴（Look at Axis）** 为 **Z** ，则仅使用 **X** 、 **Y** 限制度数。 |
| **插值时间（Interpolation Time）** | 使用 **插值类型（Interpolation Type）** 设置执行插值的时长（以秒为单位）。 |
| **插值触发阈值（Interpolation Trigger Threshold）** | 设置触发插值的阈值（以秒为单位）。 |
| **查看目标（Look at Target）** | 设置角色骨架的骨头，用作要查看的目标插槽。 |
| **查看位置（Look at Location）** | 在世界空间中设置参考点，调整 **要修改的骨骼（Bone to Modify）** 朝向的角度。当骨骼设置为 **查看目标（Look Target）** 时，此属性的值会计入局部空间，用作与选定骨骼的偏移量。 |

