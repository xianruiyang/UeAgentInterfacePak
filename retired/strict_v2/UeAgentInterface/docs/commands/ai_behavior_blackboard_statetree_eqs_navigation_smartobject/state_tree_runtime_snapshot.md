---
command: state_tree_runtime_snapshot
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: StateTree
summary: 读取运行中 StateTree 组件
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `state_tree_runtime_snapshot`

## LLM Compact

- status: active.
- purpose: 读取运行中 StateTree 组件
- key_inputs: `actor`, `component_name`, `include_active_states`, `include_tasks`
- key_returns: `active_states[]`, `running_tasks[]`, `queued_events[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `component_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `include_active_states`：布尔/开关字段；默认值以本命令契约为准。
- `include_tasks`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `active_states[]`：active_states 列表摘要；大列表应写入 output/artifact 或 debug。
- `running_tasks[]`：running_tasks 列表摘要；大列表应写入 output/artifact 或 debug。
- `queued_events[]`：queued_events 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
