---
command: screenshot_viewport
category: core_level
title: `screenshot_viewport`
summary: 抓取当前 Level Viewport 截图，可临时切换编辑器 View Mode / Visualization Mode
aliases: []
tags: [core_level]
status: active
---

# `screenshot_viewport`

## LLM Compact

- status: active.
- purpose: 抓取当前 Level Viewport 截图，可临时切换编辑器 View Mode / Visualization Mode
- key_inputs: `format`, `max_size`, `mode`, `output_file`, `quality`, `warmup_frames`, `debug_mode`, `debug_view_mode` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 目标 viewport 选择优先级：当前 active viewport -> `GCurrentLevelEditingViewportClient` -> 面积最大的透视 viewport -> 面积最大的任意 viewport -> 第一个有效 viewport。返回的 `viewport.selection_reason` 用于核对是否抓到了人工正在看的视口。
- note: 未请求 view mode 时，该命令读取当前 Level Viewport backbuffer，适合判断 PlanarReflection、SSR、后期处理和 Single Layer Water 最终观感。
- note: 请求 view mode 时，该命令走编辑器自身 `FLevelEditorViewportClient` 的模式切换路径，覆盖 View Mode 主菜单和子菜单式可视化：Buffer、Nanite、Lumen、Substrate、Groom、Virtual Shadow Map、Virtual Texture、Actor Coloration、GPU Skin Cache、Ray Tracing Debug 等。实际可用 key 以 `viewport_list_view_modes` 返回为准。
- note: 对需要 editor-world tick 的视觉系统，使用 `tick_editor_world=true` 并检查 `capture.editor_world_ticks_performed`，不要只提高 `warmup_frames`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 目标 viewport 选择优先级：当前 active viewport -> `GCurrentLevelEditingViewportClient` -> 面积最大的透视 viewport -> 面积最大的任意 viewport -> 第一个有效 viewport。返回的 `viewport.selection_reason` 用于核对是否抓到了人工正在看的视口。
- 未请求 view mode 时，该命令读取当前 Level Viewport backbuffer，适合判断 PlanarReflection、SSR、后期处理和 Single Layer Water 最终观感。
- 请求 view mode 时，该命令走编辑器自身 `FLevelEditorViewportClient` 的模式切换路径，覆盖 View Mode 主菜单和子菜单式可视化：Buffer、Nanite、Lumen、Substrate、Groom、Virtual Shadow Map、Virtual Texture、Actor Coloration、GPU Skin Cache、Ray Tracing Debug 等。实际可用 key 以 `viewport_list_view_modes` 返回为准。
- 对需要 editor-world tick 的视觉系统，使用 `tick_editor_world=true` 并检查 `capture.editor_world_ticks_performed`，不要只提高 `warmup_frames`。
- 如果只需要深度、法线或底色的稳定数值诊断，优先使用 `screenshot_viewport_buffer`；如果需要和编辑器 View Mode 菜单一致的视觉留证，使用本命令的 `view_mode`。

## Parameters

- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `max_size`：截图或导出尺寸上限。
- `mode`：命令模式；具体枚举以本命令契约为准。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `quality`：有损图片输出质量；通常用于 jpg/webp。
- `warmup_frames`：截图前刷新帧数，用于等待 viewport 更新。
- `debug_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `debug_view_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `editor_view_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `editor_world_tick_delta_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `editor_world_tick_frames`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `mode_key`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `render_warmup_frames`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `restore_view_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `restore_view_mode_after_capture`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `tick_editor_world`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `view_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `view_mode_family`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visualization_family`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visualization_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visualizer`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visualizer_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
