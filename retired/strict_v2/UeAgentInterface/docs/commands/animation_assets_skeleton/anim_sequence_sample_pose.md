---
command: anim_sequence_sample_pose
category: animation_assets_skeleton
title: `anim_sequence_sample_pose`
summary: 采样 AnimSequence 在指定时间或帧的骨骼姿态，返回本地或世界空间 transform
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_sample_pose`

## LLM Compact

- status: active.
- purpose: 采样 AnimSequence 在指定时间或帧的骨骼姿态，返回本地或世界空间 transform
- key_inputs: `asset_path`, `bone_names[]`, `bones[]`, `evaluation_type=raw/source/compressed`, `frame_index`, `frame_indices[]`, `include_ref_pose`, `max_bones` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 只读采样命令，用于把 AnimSequence 在某个时间或帧上的骨骼姿态读回为 JSON。
- note: 默认 `space=local`、`evaluation_type=raw`、`should_retarget=false`、`evaluate_curves=false`，适合把现有动画作为原型，采样本地骨骼 transform 后再用 `anim_sequence_apply_bone_tracks` 局部覆盖目标骨骼轨道。
- note: 不传 `bone_names[]` / `bones[]` 时返回最多 `max_bones` 根骨骼，默认 `512`；制作动画时建议只传需要修改或验证的骨骼，避免 report 过大。
- note: 返回 transform 同时包含欧拉角 `rotation` 和四元数 `quaternion`；写回动画轨时建议使用四元数，减少欧拉角顺序误差。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 只读采样命令，用于把 AnimSequence 在某个时间或帧上的骨骼姿态读回为 JSON。
- 默认 `space=local`、`evaluation_type=raw`、`should_retarget=false`、`evaluate_curves=false`，适合把现有动画作为原型，采样本地骨骼 transform 后再用 `anim_sequence_apply_bone_tracks` 局部覆盖目标骨骼轨道。
- 不传 `bone_names[]` / `bones[]` 时返回最多 `max_bones` 根骨骼，默认 `512`；制作动画时建议只传需要修改或验证的骨骼，避免 report 过大。
- 返回 transform 同时包含欧拉角 `rotation` 和四元数 `quaternion`；写回动画轨时建议使用四元数，减少欧拉角顺序误差。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `bone_names[]`：bone_names 列表。
- `bones[]`：bones 列表。
- `evaluation_type=raw/source/compressed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_indices[]`：frame_indices 列表。
- `include_ref_pose`：布尔/开关字段；默认值以本命令契约为准。
- `max_bones`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `skeletal_mesh_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `space=local/world`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `time_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `time_seconds_list[]`：time_seconds_list 列表。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
