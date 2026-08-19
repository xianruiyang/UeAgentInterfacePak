---
command: level_validate_connectivity
category: core_level
title: `level_validate_connectivity`
summary: 多点连通性验收（walk + 显式边）
aliases: []
tags: [core_level]
status: active
---

# `level_validate_connectivity`

## LLM Compact

- status: active.
- purpose: 多点连通性验收（walk + 显式边）
- key_inputs: `graph_root_index`, `pairs[].edge_type`, `points[]`, `probe_actor_ids[]`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 不提供 `pairs[]` 时默认按序验收 `0->1,1->2,...`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 不提供 `pairs[]` 时默认按序验收 `0->1,1->2,...`

## Parameters

- `graph_root_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `pairs[].edge_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `points[]`：points 列表。
- `probe_actor_ids[]`：probe_actor_ids 列表。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
