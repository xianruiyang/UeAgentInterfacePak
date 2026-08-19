---
command: blueprint_layout_graph_self_test
category: blueprint
title: `blueprint_layout_graph_self_test`
summary: 运行 Blueprint 自动排版核心子算法自测
aliases: []
tags: [blueprint]
status: active
---

# `blueprint_layout_graph_self_test`

## LLM Compact

- status: active.
- purpose: 运行 Blueprint 自动排版核心子算法自测
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 用途：运行 `blueprint_layout_graph` 当前主算法的核心子算法自测。该命令不读取或写入资产，只在内存中构造合成图并直接调用排版内部算法，用于防止“返回字段声称完整，但关键子步骤没有真实生效”的回归。
- note: SCC 回边检测与 `RankIgnoredFeedbackEdge` 标记；回边只从 rank / 列排序 / 输入链抽离中移除，仍保留弱连通成岛，不再把 island 切开。
- note: 排除 feedback 后的真正 fanout 出边转 `IslandCutFanoutEdge`，只有这类边会把显式图拆成多个 node island 并进入 island graph。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- 用途：运行 `blueprint_layout_graph` 当前主算法的核心子算法自测。该命令不读取或写入资产，只在内存中构造合成图并直接调用排版内部算法，用于防止“返回字段声称完整，但关键子步骤没有真实生效”的回归。
- SCC 回边检测与 `RankIgnoredFeedbackEdge` 标记；回边只从 rank / 列排序 / 输入链抽离中移除，仍保留弱连通成岛，不再把 island 切开。
- 排除 feedback 后的真正 fanout 出边转 `IslandCutFanoutEdge`，只有这类边会把显式图拆成多个 node island 并进入 island graph。
- 岛内显式边列分配与双列锚定 Y 放置，保证 rank-ignored 边不再回流到岛内 rank；普通核心列先按既定顺序密排，取紧凑段中点对应的元素作为 `BaseItem`，把该元素放到自己的 `PreferredTop`，再保持紧凑段形状向上/向下贴紧放置。输入链组保留更严格的 leading pin 精确对齐分支。
- 岛内列放置采用严格单次传播：基准列密排后，向右传播时当前列只看左侧最近相邻已知列，向左传播时当前列只看右侧最近相邻已知列。命令不再执行 `all-column` / `known-neighbor` 二次槽内修正，也不会把已放置非相邻列作为低权重锚点反向影响当前列。
- 同列节点连接到同一个相邻节点时，按该相邻节点的真实输入/输出 pin Y 顺序打破同邻居排序平局，覆盖共同下游输入口和共同上游输出口两个方向。
- 同一目标节点不同端口形成的上下顺序会作为 `DownstreamPortOrderDemand` 沿显式边向上游传播，用作多列排序的次级约束；只有 demand 属于同一个目标 group 时才参与比较。
- 同一源节点不同输出端口形成的上下顺序会作为 `SourcePortOrderDemand` 沿显式边向下游传播；当两个节点属于同一个源分支 group 时，source demand 优先于相邻列 barycenter，用于保持 Branch True/False 或其它上下输出端口跨多列不反转。
- island 输入候选、内部总线、边界入口、端口候选、局部端口匹配、确定式 island X/Y 求解和 route/lane 诊断契约。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
