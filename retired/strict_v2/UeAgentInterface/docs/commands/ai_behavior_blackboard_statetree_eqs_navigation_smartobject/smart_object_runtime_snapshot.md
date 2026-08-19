---
command: smart_object_runtime_snapshot
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Smart Object Runtime / Setup
summary: runtime 子系统快照
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `smart_object_runtime_snapshot`

## LLM Compact

- status: active.
- purpose: runtime 子系统快照
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: `active_claim_count`, `cached_find_result_count`, `component_count`, `components[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- `active_claim_count`：数量摘要。
- `cached_find_result_count`：数量摘要。
- `component_count`：数量摘要。
- `components[]`：components 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
