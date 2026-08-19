---
command: behavior_tree_runtime_snapshot
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Behavior Tree
summary: 读取运行中 BT / Blackboard
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `behavior_tree_runtime_snapshot`

## LLM Compact

- status: active.
- purpose: 读取运行中 BT / Blackboard
- key_inputs: `controller`, `include_active_path`, `include_blackboard`, `include_service_status`, `pawn`
- key_returns: `active_path[]`, `running_task`, `service_status[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `controller`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_active_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `include_blackboard`：布尔/开关字段；默认值以本命令契约为准。
- `include_service_status`：布尔/开关字段；默认值以本命令契约为准。
- `pawn`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `active_path[]`：active_path 列表摘要；大列表应写入 output/artifact 或 debug。
- `running_task`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `service_status[]`：service_status 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
