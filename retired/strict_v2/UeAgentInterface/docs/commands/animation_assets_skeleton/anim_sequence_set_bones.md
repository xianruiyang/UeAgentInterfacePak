---
command: anim_sequence_set_bones
category: animation_assets_skeleton
title: `anim_sequence_set_bones`
summary: 统一管理骨骼动画轨删除
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_set_bones`

## LLM Compact

- status: active.
- purpose: 统一管理骨骼动画轨删除
- key_inputs: `asset_path`, `children_excluded[]`, `exclude_children_recursively`, `finalize_after_set`, `include_children`, `remove_all_bone_animation`, `remove_bone_names[]`, `remove_virtual_bone_names[]` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 这是当前骨骼动画轨处理的统一入口，避免继续拆 `remove_bone_track / remove_all_bone_tracks / remove_virtual_bones` 多条命令。
- note: 当前稳定面主要是“按骨骼名删除动画轨”。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这是当前骨骼动画轨处理的统一入口，避免继续拆 `remove_bone_track / remove_all_bone_tracks / remove_virtual_bones` 多条命令。
- 当前稳定面主要是“按骨骼名删除动画轨”。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `children_excluded[]`：children_excluded 列表。
- `exclude_children_recursively`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `finalize_after_set`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_children`：布尔/开关字段；默认值以本命令契约为准。
- `remove_all_bone_animation`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `remove_bone_names[]`：remove_bone_names 列表。
- `remove_virtual_bone_names[]`：remove_virtual_bone_names 列表。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
