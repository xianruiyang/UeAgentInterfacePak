---
title: "应用 2D 物理"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/paper-2d-physics-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "为角色和对象制作动画", "虚幻引擎", "Paper 2D指南", "应用 2D 物理"]
---

# 应用 2D 物理

> 路径：虚幻引擎5.7文档 / 为角色和对象制作动画 / 虚幻引擎 / Paper 2D指南 / 应用 2D 物理

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/paper-2d-physics-in-unreal-engine

此页面讲述在 2D 游戏中对 sprite 应用物理的范例。

> [!NOTE]
> *此例使用的是 2D 横卷轴游戏，然而您也可将相同的概念移植到任意 2D 游戏中。*

在 2D 游戏中应用物理时，需要为 sprite 应用一些约束，防止 sprite 的移动和旋转出现卡片式穿帮（甚至出现类似下图中掉出世界场景的状况）。

上图中已为 sprite 应用物理，但未对物理应用约束，因此出现了物体下坠掉出世界场景的意外情况。物理对象需要对世界场景和玩家交互作出反应，然而需要将其限制在关卡内，防止其在特定的轴上旋转，使 sprite 始终为完全可见状态。

除应用物理外，还可从 **Details** 面板对 sprite 应用约束。

1. 在关卡中选择需要应用物理的 Sprite。
2. 在 **Details** 面板中，点击 *Physics* 下的 **Simulate Physics** 选项。
3. 展开 *Constraints* 并选择 **Lock Position**（对横卷轴游戏而言，通常锁定到 **Y** 轴）。

   此操作将应用物理并将其锁定到 Y 轴，但此设置可能出现其他问题。

   如上图所示，sprite 已锁定至 Y 轴，却仍然出现自由旋转的意外状况。
4. 在 *Constraints* 部分选择 **Lock Rotation**（对横卷轴游戏而言，通常锁定到 **X** 轴）。

   现在对 sprite 应用物理后，其位置将锁定到 Y 轴，旋转将锁定到 X 轴。

   也可使用 **Mode** 选项沿特定的轴对移动进行约束（此例中为 **XZPlane**，实现的效果相同）。

可根据制作的 2D 游戏类型采用不同设置，对物理应用到对象的方式进行限制。
