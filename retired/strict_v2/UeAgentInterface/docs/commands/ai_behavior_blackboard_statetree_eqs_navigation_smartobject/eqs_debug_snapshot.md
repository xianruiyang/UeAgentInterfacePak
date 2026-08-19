---
command: eqs_debug_snapshot
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: EQS
summary: 运行并返回 debug 摘要
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `eqs_debug_snapshot`

## LLM Compact

- status: active.
- purpose: 运行并返回 debug 摘要
- key_inputs: `asset_path`, `max_results`, `querier`, `run_mode`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `max_results`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `querier`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `run_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
