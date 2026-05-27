---
title: "手部IK重定向"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-hand-ik-retargeting-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "骨架网格体动画系统", "动画蓝图", "动画节点参考", "骨骼控制", "手部IK重定向"]
---

# 手部IK重定向

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 骨架网格体动画系统 / 动画蓝图 / 动画节点参考 / 骨骼控制 / 手部IK重定向

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/animation-blueprint-hand-ik-retargeting-in-unreal-engine

在你需要将动画用于不同比例的角色时，你可以使用 **Hand IK Retargeting** [动画蓝图](../../../../../skeletal-mesh-animation-system/animation-blueprints/index.md)节点，重定向IK骨骼链，修正FK手部位置。

这里是同一个动画在男性和女性角色身上播放的效果。可以看到，女性角色扭转时，为了使手部与武器保持连接，其右臂会有一定的过度拉伸。

|  |  |
| --- | --- |
| 禁用Hand IK Retargeting节点的男性角色 | 禁用Hand IK Retargeting节点的女性角色 |

你可以使用Hand IK Retargeting节点的 **手部FK权重（Hand FKWeight）** 属性来转变所设FK骨骼的优先级权重，更正过度拉伸。

|  |
| --- |
| 启用Hand IK Retargeting节点的女性角色 |

在示例中，角色的手臂附加到了武器上，其中同时用到了[两个骨骼IK](../animation-bluep-5896e52c/index.md)节点。接着，Hand IK Retargeting节点用于更正角色左臂的过度拉伸。为实现此效果，手部FK权重（Hand FKWeight）设置为值0。

## 属性参考

你可以在此处参考Hand IK Retargeting节点的属性列表。

| 属性 | 说明 |
| --- | --- |
| **右手FK（Right Hand FK）** | 从角色骨架选择角色右手骨骼，以设置为 **右手FK（Right Hand FK）** 。 |
| **左手FK（Left Hand FK）** | 从角色骨架选择角色左手骨骼，以设置为 **左手FK（Left Hand FK）** 。 |
| **右手IK（Right Hand IK）** | 从角色骨架选择右手IK骨骼，以设置为 **右手IK（Right Hand IK）** 。 |
| **左手IK（Left Hand IK）** | 从角色骨架选择左手IK骨骼，以设置为 **左手IK（Left Hand IK）** 。 |
| **要移动的IK骨骼（IKBones to Move）** | 你可以在此处选择要移动的其他骨骼。你可以使用 **添加（Add (+)）** 添加骨骼，并从下拉菜单中角色的骨架选择骨骼。 要移动的其他骨骼可能是武器骨骼，或者用于对象交互的其他骨骼。 |
| **手部FK权重（Hand FKWeight）** | 你可以在此处设置权重来偏好右手或左手，更正关节弹出和拉伸。例如，值为0时将偏好左手，值为1时将偏好右手，值为0.5时两手权重相等。默认情况下，此属性显示为 **AnimGraph** 中Hand IK Retargeting节点上的引脚。 |
