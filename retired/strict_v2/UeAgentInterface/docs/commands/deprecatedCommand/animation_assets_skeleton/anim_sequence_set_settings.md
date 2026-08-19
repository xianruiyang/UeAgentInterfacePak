---
command: anim_sequence_set_settings
category: animation_assets_skeleton
title: `anim_sequence_set_settings`
summary: **Deprecated for authoring**：批量设置 AnimSequence 常用属性
aliases: []
tags: [animation_assets_skeleton, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：批量设置 AnimSequence 常用属性
deprecated_replacement: []
---

# `anim_sequence_set_settings`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：批量设置 AnimSequence 常用属性
- key_inputs: `asset_path`, `additive_animation_type`, `additive_base_pose_type`, `base_pose_frame_index`, `base_pose_sequence_path`, `bone_compression_settings_path`, `clear_base_pose_sequence`, `clear_retarget_source_asset` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 这是当前 AnimSequence 常用资产设置的统一入口，避免继续拆 `set_rate_scale / set_root_motion / set_interpolation / set_additive_base_pose / set_retarget_source` 多条命令。
- note: 当前优先覆盖“资产级配置”，并已补齐压缩 / 剥帧设置；仍不继续扩到更宽的曲线族、notify payload 和完整骨骼轨 authoring。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 这是当前 AnimSequence 常用资产设置的统一入口，避免继续拆 `set_rate_scale / set_root_motion / set_interpolation / set_additive_base_pose / set_retarget_source` 多条命令。
- 当前优先覆盖“资产级配置”，并已补齐压缩 / 剥帧设置；仍不继续扩到更宽的曲线族、notify payload 和完整骨骼轨 authoring。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `additive_animation_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `additive_base_pose_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `base_pose_frame_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `base_pose_sequence_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `bone_compression_settings_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `clear_base_pose_sequence`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `clear_retarget_source_asset`：资产引用；通常传 UE 资产路径。
- `curve_compression_settings_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `enable_root_motion`：布尔/开关字段；默认值以本命令契约为准。
- `force_root_lock`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `interpolation_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `rate_scale`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `retarget_source`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `retarget_source_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `root_motion_lock_type`：根对象或根节点配置。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `variable_frame_stripping_settings_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
