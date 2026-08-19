---
command: anim_sequence_set_preview_mesh
category: animation_assets_skeleton
title: Animation Sequence
summary: **Deprecated for authoring**：设置或清空 AnimSequence 预览网格
aliases: []
tags: [animation_assets_skeleton, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：设置或清空 AnimSequence 预览网格
deprecated_replacement: []
---

# `anim_sequence_set_preview_mesh`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：设置或清空 AnimSequence 预览网格
- key_inputs: `asset_path`, `clear_preview_mesh`, `save_after_set`, `skeletal_mesh_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 序列帧、预览截图和资产预览应沿用统一 `visual_options` 与 `preview_state` 语义。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 序列帧、预览截图和资产预览应沿用统一 `visual_options` 与 `preview_state` 语义。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `clear_preview_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `skeletal_mesh_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
