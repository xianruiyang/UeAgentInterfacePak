---
command: editor_viewport_list
category: editor_viewport
title: 命令表
summary: 列出当前可发现的编辑器视口和资产预览候选
aliases: []
tags: [editor_viewport]
status: active
---

# `editor_viewport_list`

## LLM Compact

- status: active.
- purpose: 列出当前可发现的编辑器视口和资产预览候选
- key_inputs: `include_open_editors`
- key_returns: `schema`, `camera`, `target`, `capabilities`, `status`, `viewport_count`, `viewports[]`
- behavior: 只读查询类命令；大结果应写入 `output_file`。
- note: 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- note: 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- note: 已识别的 2D/special 资产编辑器项包含 `status="special_preview_unsupported"`、`unsupported_reason` 和 `special_preview`；`capabilities.camera/focus/screenshot=false`，不会伪造 3D viewport 能力。
- note: 已识别的 graph/canvas/editor UI 资产编辑器项包含 `status="excluded_editor_window"`、`unsupported_reason` 和 `excluded_window`；`capabilities.camera/focus/screenshot=false`。
- validation: 读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。

## Authoring Notes

- 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- 已识别的 2D/special 资产编辑器项包含 `status="special_preview_unsupported"`、`unsupported_reason` 和 `special_preview`；`capabilities.camera/focus/screenshot=false`，不会伪造 3D viewport 能力。
- 已识别的 graph/canvas/editor UI 资产编辑器项包含 `status="excluded_editor_window"`、`unsupported_reason` 和 `excluded_window`；`capabilities.camera/focus/screenshot=false`。

## Parameters

- `include_open_editors`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `schema`：返回 payload schema。
- `camera`：写后或读回的相机状态。
- `target`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `capabilities`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `viewport_count`：数量摘要。
- `viewports[]`：viewports 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。
