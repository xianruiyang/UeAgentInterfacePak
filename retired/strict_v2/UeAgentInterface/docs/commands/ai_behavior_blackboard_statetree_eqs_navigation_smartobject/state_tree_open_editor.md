---
command: state_tree_open_editor
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: StateTree
summary: 打开编辑器
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `state_tree_open_editor`

## LLM Compact

- status: active.
- purpose: 打开编辑器
- key_inputs: `asset_path`, `bring_to_front`
- key_returns: `opened`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `bring_to_front`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `opened`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
