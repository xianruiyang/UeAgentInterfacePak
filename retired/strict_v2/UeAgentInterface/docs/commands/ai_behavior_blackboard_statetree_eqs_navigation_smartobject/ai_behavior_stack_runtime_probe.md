---
command: ai_behavior_stack_runtime_probe
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: AI Behavior Stack
summary: 聚合 runtime probe
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `ai_behavior_stack_runtime_probe`

## LLM Compact

- status: active.
- purpose: 聚合 runtime probe
- key_inputs: `actor`, `controller`, `expected_blackboard_keys[]`, `expected_perception[]`, `pawn`
- key_returns: `cleanup_results[]`, `expectation_results[]`, `samples[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `controller`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expected_blackboard_keys[]`：expected_blackboard_keys 列表。
- `expected_perception[]`：expected_perception 列表。
- `pawn`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `cleanup_results[]`：cleanup_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `expectation_results[]`：expectation_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `samples[]`：samples 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
