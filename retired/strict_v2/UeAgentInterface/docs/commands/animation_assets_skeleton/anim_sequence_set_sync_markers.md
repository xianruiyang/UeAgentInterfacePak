---
command: anim_sequence_set_sync_markers
category: animation_assets_skeleton
title: `anim_sequence_set_sync_markers`
summary: 批量新增 / 删除 / 清空 sync marker
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_set_sync_markers`

## LLM Compact

- status: active.
- purpose: 批量新增 / 删除 / 清空 sync marker
- key_inputs: `asset_path`, `add_markers[]`, `clear_all`, `remove_marker_names[]`, `remove_notify_track_names[]`, `save_after_set`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 如果 `add_markers[].notify_track_name` 不存在，命令会先补对应 notify track。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 如果 `add_markers[].notify_track_name` 不存在，命令会先补对应 notify track。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `add_markers[]`：add_markers 列表。
- `clear_all`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `remove_marker_names[]`：remove_marker_names 列表。
- `remove_notify_track_names[]`：remove_notify_track_names 列表。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
