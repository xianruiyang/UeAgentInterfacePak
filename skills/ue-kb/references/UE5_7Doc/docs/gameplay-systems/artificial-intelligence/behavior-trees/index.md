---
title: "行为树"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/behavior-trees-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "行为树"]
---

# 行为树

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 行为树

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/behavior-trees-in-unreal-engine

我们可以用虚幻引擎5（虚幻引擎）中的 **行为树资源** 为项目中的非玩家角色创建人工智能（AI）。虽然行为树资源将被用于执行包含逻辑的分支，从而决定应该执行的分支，但行为树依赖于另一种称为 **黑板** 的资源，它充当了行为树的"大脑"。

黑板包含了数个用户定义的 **键**，这些键会保存行为树用于进行决策的信息。举例而言，用户可以设置一个名为 *Is Light On* 的布尔键，行为树可以引用该键来查看数值是否已变化。如果该值为true，它就会执行一个让蟑螂逃跑的分支。如果该值为false，它就会执行另一个分支，使蟑螂在环境中随机移动。蟑螂范例中给出的行为树非常简单。而在多人游戏中则十分复杂，其能模拟另一个真人玩家，进行寻找掩护、向玩家射击和寻找拾取物等操作。

如您还不熟悉虚幻引擎中的行为树，建议先行阅读 **行为树快速入门指南**，快速创建并运行AI角色。如果您已经熟悉其他应用程序中行为树的概念，则建议阅读 **概要** 部分，其中包含行为树在虚幻引擎中工作方式的概述、行为树和黑板的用户指南，以及行为树中可用的各种节点的参考页面。

## 开始


- [行为树快速入门指南](behavior-tree-in-unreal-engine---quick-start-guide/index.md)

## 概要


- [行为树概述](behavior-tree-in-unreal-engine---overview/index.md)

- [行为树用户指南](behavior-tree-in-unreal-engine---user-guide/index.md) - 描述如何创建和编辑行为树及行为树相关的资源。

- [行为树节点参考](behavior-tree-node-reference/index.md) - 概述使用行为树编辑器时可用的各种节点。
