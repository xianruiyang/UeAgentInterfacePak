---
command: state_tree_get_info
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: StateTree
summary: 读取 StateTree 摘要
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `state_tree_get_info`

## LLM Compact

- status: active.
- purpose: 读取 StateTree 摘要
- key_inputs: `asset_path`, `include_bindings`, `include_states`, `include_validation`
- key_returns: `compile_report`, `evaluators[]`, `global_tasks[]`, `states[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `include_bindings`：布尔/开关字段；默认值以本命令契约为准。
- `include_states`：布尔/开关字段；默认值以本命令契约为准。
- `include_validation`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `compile_report`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `evaluators[]`：evaluators 列表摘要；大列表应写入 output/artifact 或 debug。
- `global_tasks[]`：global_tasks 列表摘要；大列表应写入 output/artifact 或 debug。
- `states[]`：states 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
