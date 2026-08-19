---
command: navigation_get_info
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Navigation
summary: 聚合读取当前世界 Navigation 摘要
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `navigation_get_info`

## LLM Compact

- status: active.
- purpose: 聚合读取当前世界 Navigation 摘要
- key_inputs: `include_agents`, `include_bounds`, `include_nav_data`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_agents`：布尔/开关字段；默认值以本命令契约为准。
- `include_bounds`：布尔/开关字段；默认值以本命令契约为准。
- `include_nav_data`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
