---
title: "数据流图表"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/dataflow-graph"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "物理", "物理工具", "数据流图表"]
---

# 数据流图表

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 物理 / 物理工具 / 数据流图表

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/dataflow-graph

**数据流图表（Dataflow Graph）** 系统是虚幻引擎编辑器内的一套 **基于节点的程序化资产生成环境** 。

创建数据流是为了在引擎中创建某些资产类型时 **优化迭代时间** 而生的。同一数据流图表可 **被多个资产使用** ，而且图表本身可根据源资产提供的输入而产出不同的结果。

数据流是一套 **通用系统** ，可适配各种物理资产类型，如 **Chaos布料** 、 **Chaos血肉** 和 **几何集合破裂** 等。该系统 **被设计为可由C++开发者扩展** 。开发者可以根据具体需求进一步调整系统。

阅读如下文档即可详细了解数据流：

- [数据流概览](dataflow-overview/index.md) - 虚幻引擎中数据流图表系统的概览。

- [破坏系统数据流快速入门](dataflow-for-destruction-quickstart/index.md) - 了解如何配合Chaos破坏系统使用数据流图表。
