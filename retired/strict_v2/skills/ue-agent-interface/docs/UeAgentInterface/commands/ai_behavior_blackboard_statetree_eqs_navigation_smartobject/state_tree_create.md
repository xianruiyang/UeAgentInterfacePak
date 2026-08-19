---
command: state_tree_create
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: StateTree
summary: 创建最小 StateTree
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `state_tree_create`

## LLM Compact

- status: active.
- purpose: 创建最小 StateTree
- key_inputs: `asset_path`, `root_state_name`, `save_after_create`, `schema_class`
- key_returns: `ready_to_run`, `schema_class`, `states[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `root_state_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。
- `schema_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `ready_to_run`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `schema_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `states[]`：states 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
