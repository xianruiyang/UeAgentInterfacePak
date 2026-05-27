---
title: "使用射线进行命中判定"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/traces-with-raycasts-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "使用射线进行命中判定"]
---

# 使用射线进行命中判定

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 使用射线进行命中判定

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/traces-with-raycasts-in-unreal-engine

游戏中可能存在这样的情况：需要确定玩家角色是否在看着某件物体；如是，则以某种方式调整游戏状态（例如在玩家看着某件物体时将其高亮显示）。或者需要确定敌人是否能看到玩家角色；如是，则开始射击或以其他方式攻击。使用 **追踪** (or **光线投射**)可实现这两种情况——"发射"一道不可见的光线检测两点之间的几何体；如命中几何体，返回被击中的内容，以便对其进行操作。

运行追踪时有数个不同的可用选项。您可运行追踪，检查和任意目标发生的碰撞（命中的对象将被返回）；或者按追踪通道运行追踪，只有在对象被设为响应特定的追踪通道时（可通过 Collision Settings 进行设置）命中的对象才返回命中信息。

除按对象或追踪通道运行追踪外，您还可运行追踪检测单次命中或多次命中，单次追踪只返回单次命中结果，多次追踪返回追踪造成的多次命中。也可通过追踪指定使用的光线类型：直线、方块、胶囊体或球体。

## 话题

通过下方链接了解更多使用蓝图的射线命中判定。


- [追踪概述](traces-in-unreal-engine---overview/index.md)

- [追踪指南](traces-tutorials/index.md) - 虚幻引擎追踪（光线投射）相关的指南。
