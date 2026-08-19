---
command: viewport_frame_folder
category: core_level
title: `viewport_frame_folder`
summary: 按 Outliner folder 聚合 bounds 取景
aliases: []
tags: [core_level]
status: active
---

# `viewport_frame_folder`

## LLM Compact

- status: active.
- purpose: 按 Outliner folder 聚合 bounds 取景
- key_inputs: `folder_path`, `include_child_folders`, `padding`, `collision_aware`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 会遍历 folder 下 Actor，聚合有效 bounds。
- note: 默认只重新计算并写入相机 `location`；若 `look_at=true` 会同步修改 `rotation`（`roll=0`）。
- note: 返回 `desired_location`（基准理想位）与 `new_location`（实际写入），并附带 `rotation/fov`。
- note: 未命中遮挡：直接使用候选位。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Folder Authoring Contract

- Exported folder packages keep editable owner properties in grouped Details: edit the referenced `details/<owner_scope>/index.hjson` and group files for existing owners.
- `category` in a `details` / `*_details` ref is metadata only and is not a directory segment; do not create `details/<category>/<owner_scope>` paths
- Creation seeds may provide valid inline `properties[]` or `*_properties[]` descriptors as initial values when that owner has no matching `details` or `*_details` ref. Supplying both sources is an `inline_grouped_details_conflict`; diagnostic property surfaces remain forbidden.
- `raw_properties`, `readonly_properties`, `missing_properties`, and `unsupported_properties` are export, diagnostic, or readback fields only, not apply input
- Inline seed descriptors and grouped Details fields use the same structured property value contract and the same public apply path.

## Authoring Notes
- 会遍历 folder 下 Actor，聚合有效 bounds。
- 默认只重新计算并写入相机 `location`；若 `look_at=true` 会同步修改 `rotation`（`roll=0`）。
- 返回 `desired_location`（基准理想位）与 `new_location`（实际写入），并附带 `rotation/fov`。
- 未命中遮挡：直接使用候选位。
- 命中遮挡：把相机放到命中点沿“Trace 方向反向”回退 `safety_offset_cm` 的位置，避免穿墙/卡墙。
- 若 `auto_fallback=true` 或提供 `fallback_offsets_cm`，会在多候选中选择“距离目标更远且无遮挡/可修正”的相机位，并返回 `fallback_used/fallback_index/fallback_offset_cm`。
- 仅支持透视视口；若当前有效视口不是透视视口，会返回错误。

## Parameters

- `folder_path`：Outliner folder 或资产 folder；具体含义以命令所在领域为准。
- `include_child_folders`：布尔/开关字段；默认值以本命令契约为准。
- `padding`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `collision_aware`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

