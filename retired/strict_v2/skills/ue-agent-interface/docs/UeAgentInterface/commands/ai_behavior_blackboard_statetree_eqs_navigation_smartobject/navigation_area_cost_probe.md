---
command: navigation_area_cost_probe
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Navigation
summary: 读取 NavArea cost，可选附带路径
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `navigation_area_cost_probe`

## LLM Compact

- status: active.
- purpose: 读取 NavArea cost，可选附带路径
- key_inputs: `expected_areas[]`, `run_path_probe`, `start`, `end`
- key_returns: `area_costs[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `expected_areas[]`：expected_areas 列表。
- `run_path_probe`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `start`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `end`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `area_costs[]`：area_costs 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
