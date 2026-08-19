---
command: navigation_validate_level
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Navigation
summary: 校验关卡导航配置；传入 `nodes`/`sample_points` 时复用连通性验证
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `navigation_validate_level`

## LLM Compact

- status: active.
- purpose: 校验关卡导航配置；传入 `nodes`/`sample_points` 时复用连通性验证
- key_inputs: `strict`, `nodes`, `required_bounds`, `sample_points`
- key_returns: `json_issues[]`, `results[]`, `status`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `strict`：严格校验模式。
- `nodes`：nodes 结构摘要。
- `required_bounds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sample_points`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `json_issues[]`：json_issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `results[]`：results 列表摘要；大列表应写入 output/artifact 或 debug。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
