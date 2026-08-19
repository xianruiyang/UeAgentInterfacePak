---
command: anim_blueprint_create_layer_interface
category: anim_blueprint
title: `anim_blueprint_create_layer_interface`
summary: 创建 Anim Layer Interface 资产
aliases: []
tags: [anim_blueprint]
status: active
---

# `anim_blueprint_create_layer_interface`

## LLM Compact

- status: active.
- purpose: 创建 Anim Layer Interface 资产
- key_inputs: `asset_path`, `compile_after_create`, `open_editor`, `save_after_create`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 这条命令创建的是 Animation Layer Interface 资产，不是普通 AnimBlueprint
- note: 创建后可继续通过 folder HJSON 为它补 layer graph。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这条命令创建的是 Animation Layer Interface 资产，不是普通 AnimBlueprint
- 创建后可继续通过 folder HJSON 为它补 layer graph。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `compile_after_create`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `open_editor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
