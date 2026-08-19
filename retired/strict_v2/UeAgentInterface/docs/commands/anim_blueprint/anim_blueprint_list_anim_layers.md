---
command: anim_blueprint_list_anim_layers
category: anim_blueprint
title: `anim_blueprint_list_anim_layers`
summary: 列出 Anim Layer，合并编辑图和编译函数视图
aliases: []
tags: [anim_blueprint]
status: active
---

# `anim_blueprint_list_anim_layers`

## LLM Compact

- status: active.
- purpose: 列出 Anim Layer，合并编辑图和编译函数视图
- key_inputs: `asset_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 对“本地 layer”来说，通常 `has_graph=true`
- note: 对“由 interface 引入的 layer”来说，可能出现 `has_graph=false`，但 `compiled_function_found=true`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 对“本地 layer”来说，通常 `has_graph=true`
- 对“由 interface 引入的 layer”来说，可能出现 `has_graph=false`，但 `compiled_function_found=true`

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
