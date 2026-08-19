---
command: montage_create
category: montage
title: `montage_create`
summary: 创建 Montage 资产
aliases: []
tags: [montage]
status: active
---

# `montage_create`

## LLM Compact

- status: active.
- purpose: 创建 Montage 资产
- key_inputs: `asset_path`, `open_editor`, `preview_skeletal_mesh`, `save_after_create`, `source_animation`, `target_skeleton`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 如果传了 `source_animation`，会直接用它初始化默认 slot 的第一段 segment。
- note: 如果没传 `source_animation`，则必须显式提供 `target_skeleton`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 如果传了 `source_animation`，会直接用它初始化默认 slot 的第一段 segment。
- 如果没传 `source_animation`，则必须显式提供 `target_skeleton`。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `open_editor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `preview_skeletal_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。
- `source_animation`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_skeleton`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
