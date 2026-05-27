---
title: "场景查询系统"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/environment-query-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "场景查询系统"]
---

# 场景查询系统

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 场景查询系统

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/environment-query-system-in-unreal-engine

**场景查询系统（EQS）** 是虚幻引擎5（UE5） AI系统的一个功能，可将其用于从环境中收集数据。在EQS中，可以通过不同种类的测试向收集的数据提问，这些测试会根据提出问题的类型来生成最适合的项目。

可以从[行为树](../behavior-trees/index.md)中调用EQS查询，并根据测试的结果将其用于后续操作的决定。EQS查询主要由[生成器](environment-query-system-node-reference/eqs-node-reference-generators/index.md)节点（用于生成将被测试及加权的位置或Actor）和[情境](environment-query-system-node-reference/eqs-node-reference-contexts/index.md)节点（被用作各种测试和生成器引用的框架）组成。可以用EQS查询指引AI角色找到能够发现玩家并发起攻击的最佳位置、找到距离最近的体力值或弹药拾取物，或找到最近的掩体（以及其他可进行的动作）。

对虚幻引擎中行为树的工作方式有大致了解后，如果希望AI进行环境查询，建议从 **场景查询系统快速入门** 指南开始，它会向您全程展示一个案例，该案例中的AI会找到对玩家发起远程攻击的最佳位置。您还可以查阅"概要"部分，其中包含EQS的概述、讲述EQS用法的用户指南、以及详解EQS中可用节点和属性的节点参考页面。

## 开始


- [场景查询系统快速入门](environment-query-system-quick-start/index.md)

## 概要


- [场景查询系统概述](environment-query-system-overview/index.md)

- [场景查询系统用户指南](environment-query-system-user-guide/index.md) - 描述了创建和使用EQS资源的常见方法。

- [场景查询系统节点参考](environment-query-system-node-reference/index.md) - 场景查询系统节点参考页面。

- [场景查询测试Pawn](environment-query-testing-pawn/index.md) - 概述如何使用EQS测试Pawn进行调试并查看EQS查询的执行情况。
