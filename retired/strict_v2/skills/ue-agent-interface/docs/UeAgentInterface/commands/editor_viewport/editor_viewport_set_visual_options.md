---
command: editor_viewport_set_visual_options
category: editor_viewport
title: 命令表
summary: 设置视图模式和 overlay/show flags
aliases: []
tags: [editor_viewport]
status: active
---

# `editor_viewport_set_visual_options`

## LLM Compact

- status: active.
- purpose: 设置视图模式和 overlay/show flags
- key_inputs: `visual_options`
- key_returns: `visual_options`, `visual_options_applied`
- note: 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- note: 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- note: 设置结果也应被 `editor_viewport_screenshot` 以及 Niagara/Animation/Sequence 等序列帧输出消费。
- note: 用途：设置视口显示模式和 overlay/show flags。
- validation: 读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。

## Authoring Notes

- 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- 设置结果也应被 `editor_viewport_screenshot` 以及 Niagara/Animation/Sequence 等序列帧输出消费。
- Level viewport 复用完整 viewport mode 契约：`view_mode` 支持 optimization 稳定 key（包括 `quad_overdraw`、`shader_complexity_with_quad_overdraw`），Visualization 模式使用 `visualization_family` + `visualization_mode`；资产预览仍遵守各 adapter 的能力边界。
- 用途：设置视口显示模式和 overlay/show flags。
- 上述 overlay 也可平铺到 `visual_options` 顶层。
- 不支持的字段默认失败并返回 `unsupported_visual_options`；显式传 `ignore_unsupported=true` 时会在 `unsupported_options[]` 中返回未应用项。

## Parameters

- `visual_options`：视图模式/overlay/show flags；截图和序列帧也应消费该对象。
- Level viewport 的高级模式读回包含稳定 `view_mode`，Visualization family 还包含 `visualization_family` 和 `visualization_mode`；临时截图默认精确恢复这些状态。

## Returns

- `visual_options`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visual_options_applied`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。
