---
command: anim_sequence_apply_bone_tracks
category: animation_assets_skeleton
title: `anim_sequence_apply_bone_tracks`
summary: 写入 AnimSequence 骨骼 transform 轨道 key，可创建新 AnimSequence 或更新已有轨道
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_apply_bone_tracks`

## LLM Compact

- status: active.
- purpose: 写入 AnimSequence 骨骼 transform 轨道 key，可创建新 AnimSequence 或更新已有轨道
- key_inputs: `asset_path`, `create_if_missing`, `fps`, `frame_rate`, `num_frames`, `preview_skeletal_mesh`, `replace_existing_tracks`, `save_after_apply` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 这是 AnimSequence 骨骼 transform 轨写入的主流程入口，用于把本地空间 location / rotation / scale key 写进 UE 原生 DataModel。
- note: 创建新资产时必须提供 `target_skeleton`/`skeleton`，建议同时提供 `preview_skeletal_mesh` 便于后续截图预览。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这是 AnimSequence 骨骼 transform 轨写入的主流程入口，用于把本地空间 location / rotation / scale key 写进 UE 原生 DataModel。
- 创建新资产时必须提供 `target_skeleton`/`skeleton`，建议同时提供 `preview_skeletal_mesh` 便于后续截图预览。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `fps`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_rate`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `num_frames`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `preview_skeletal_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `replace_existing_tracks`：布尔/开关字段；默认值以本命令契约为准。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。
- `skeletal_mesh_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `skeleton`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_skeleton`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `tracks[]`：tracks 列表。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
