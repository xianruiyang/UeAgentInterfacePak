---
command: state_tree_node_blueprint_get_info
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: StateTree Node Blueprint 摘要
summary: 读取 StateTree Task / Evaluator / Condition Blueprint 或原生类摘要
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `state_tree_node_blueprint_get_info`

## LLM Compact

- status: active.
- purpose: 读取 StateTree Task / Evaluator / Condition Blueprint 或原生类摘要
- key_inputs: `asset_path`
- key_returns: `class`, `generated_class`, `introspection_level=class_hierarchy_only`, `is_state_tree_task`, `is_state_tree_condition`, `is_state_tree_evaluator`, `parent_class`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- `class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `generated_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `introspection_level=class_hierarchy_only`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `is_state_tree_task`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `is_state_tree_condition`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `is_state_tree_evaluator`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `parent_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
