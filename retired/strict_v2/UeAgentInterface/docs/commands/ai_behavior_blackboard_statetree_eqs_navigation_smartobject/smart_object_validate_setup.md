---
command: smart_object_validate_setup
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Smart Object Runtime / Setup
summary: 校验 Definition 与当前关卡 Actor 上 SmartObjectComponent 的引用关系
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `smart_object_validate_setup`

## LLM Compact

- status: active.
- purpose: 校验 Definition 与当前关卡 Actor 上 SmartObjectComponent 的引用关系
- key_inputs: `definition_asset`, `owner_actor_or_blueprint`
- key_returns: `component_definition`, `component_owner`, `json_issues[]`, `status`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `definition_asset`：资产引用；通常传 UE 资产路径。
- `owner_actor_or_blueprint`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `component_definition`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `component_owner`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `json_issues[]`：json_issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
