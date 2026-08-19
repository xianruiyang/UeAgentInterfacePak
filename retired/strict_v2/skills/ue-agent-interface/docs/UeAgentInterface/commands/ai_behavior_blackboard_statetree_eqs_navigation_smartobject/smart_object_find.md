---
command: smart_object_find
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Smart Object Runtime / Setup
summary: 查询可用 Smart Object
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `smart_object_find`

## LLM Compact

- status: active.
- purpose: 查询可用 Smart Object
- key_inputs: `include_claimed`, `max_results`, `query_bounds`, `required_tags[]`
- key_returns: `result_count`, `results[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_claimed`：布尔/开关字段；默认值以本命令契约为准。
- `max_results`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `query_bounds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `required_tags[]`：required_tags 列表。

## Returns

- `result_count`：数量摘要。
- `results[]`：results 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
