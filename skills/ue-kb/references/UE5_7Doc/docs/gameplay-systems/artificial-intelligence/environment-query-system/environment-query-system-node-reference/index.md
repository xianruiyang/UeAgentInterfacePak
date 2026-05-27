---
title: "场景查询系统节点参考"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/environment-query-system-node-reference-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "人工智能", "场景查询系统", "场景查询系统节点参考"]
---

# 场景查询系统节点参考

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 人工智能 / 场景查询系统 / 场景查询系统节点参考

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/environment-query-system-node-reference-in-unreal-engine

**场景查询** 实际上由许多不同的部分组成。您必须从 [行为树](../../behavior-trees/index.md) 调用场景查询，然后实际的场景查询将使用它的 **生成器**，引用它的 **情境**，并使用它的 **测试**，为行为树提供权重最高的结果。

| 节点类型 | 描述 |
| --- | --- |
| **生成器（Generator）** | 生成位置或Actor，其被称为 **项目（Item）**、实际上将被测试和加权。 |
| **情境（Contexts）** | 为各种测试和生成器提供引用的框架。 |
| **测试（Tests）** | 确定环境查询如何决定来自生成器的哪个项目是最佳选择。 |

欲知各类节点的更多信息，请参阅以下链接。


- [EQS节点参考：生成器](eqs-node-reference-generators/index.md)

- [EQS节点参考：情境](eqs-node-reference-contexts/index.md) - 讲述在EQS系统中情境如何用于测试和生成器。

- [EQS节点参考：测试](eqs-node-reference-tests/index.md) - 描述如何在EQS中使用测试来生成
