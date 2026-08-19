---
command: asset_import_fbx_animation
category: core_level
title: `asset_import_fbx_animation`
summary: 导入 FBX 为 AnimSequence
aliases: []
tags: [core_level]
status: active
---

# `asset_import_fbx_animation`

## LLM Compact

- status: active.
- purpose: 导入 FBX 为 AnimSequence
- key_inputs: `source_filename`, `destination_path`, `destination_name`, `skeleton_path`, `skeletal_mesh_path`, `allow_overwrite`, `replace_existing`, `replace_existing_settings`, `save_after_import`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 若只给 `skeletal_mesh_path`，命令会自动解析其绑定 Skeleton。
- note: 导入结果是 `AnimSequence` 资产。
- note: 返回 `skeleton_path` 与 `imported_animation_paths`，便于后续直接接 `AnimBlueprint` / Montage / 结构化动画工作流。
- note: 默认不覆盖已有 AnimSequence。只有显式 `allow_overwrite=true` 或兼容确认 `replace_existing=true` 才允许覆盖；二者必须是 JSON boolean。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 若只给 `skeletal_mesh_path`，命令会自动解析其绑定 Skeleton。
- 导入结果是 `AnimSequence` 资产。
- 返回 `skeleton_path` 与 `imported_animation_paths`，便于后续直接接 `AnimBlueprint` / Montage / 结构化动画工作流。
- `allow_overwrite` 与 `replace_existing` 是同一覆盖确认语义；`replace_existing_settings` 不构成覆盖授权。

## Parameters

- `destination_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `skeletal_mesh_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `skeleton_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `source_filename`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `allow_overwrite`：默认 `false`；显式允许覆盖同名已有资产。
- `replace_existing`：默认 `false`；兼容覆盖确认，显式 `true` 等价于 `allow_overwrite=true`。
- `replace_existing_settings`：默认 `true`，仅在已授权覆盖时生效。
- `save_after_import`：默认 `true`。

## Returns

- 通用导入结果、`skeleton_path`、导入动画路径，以及 `replace_existing`、`allow_overwrite`、`replace_existing_settings`、`save_after_import`。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
