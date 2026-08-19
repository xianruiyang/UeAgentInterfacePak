---
command: ai_perception_runtime_probe
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: AI Perception
summary: 按期望做感知探针
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `ai_perception_runtime_probe`

## LLM Compact

- status: active.
- purpose: 按期望做感知探针
- key_inputs: `controller`, `expected_sensed`, `stimulus_actor`, `target_actor`
- key_returns: `probe_passed`, `samples[]`, `successfully_sensed`, `target_stimuli[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `controller`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expected_sensed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stimulus_actor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_actor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `probe_passed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `samples[]`：samples 列表摘要；大列表应写入 output/artifact 或 debug。
- `successfully_sensed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_stimuli[]`：target_stimuli 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
