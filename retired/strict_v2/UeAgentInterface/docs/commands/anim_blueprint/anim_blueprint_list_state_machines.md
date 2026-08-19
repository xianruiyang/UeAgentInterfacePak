---
command: anim_blueprint_list_state_machines
category: anim_blueprint
title: `anim_blueprint_list_state_machines`
summary: 列出所有状态机及其结构明细
aliases: []
tags: [anim_blueprint]
status: active
---

# `anim_blueprint_list_state_machines`

## LLM Compact

- status: active.
- purpose: 列出所有状态机及其结构明细
- key_inputs: `asset_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 这是“结构盘点”命令，不是节点图编辑器替代物
- note: 返回同时包含编辑图结构和编译后 `BakedStateMachines` 统计
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这是“结构盘点”命令，不是节点图编辑器替代物
- 返回同时包含编辑图结构和编译后 `BakedStateMachines` 统计

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
