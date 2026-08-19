---
command: eqs_run_query
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: EQS
summary: 在当前世界运行 query
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `eqs_run_query`

## LLM Compact

- status: active.
- purpose: 在当前世界运行 query
- key_inputs: `asset_path`, `max_results`, `querier`, `run_mode`
- key_returns: `items[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `max_results`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `querier`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `run_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `items[]`：items 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
