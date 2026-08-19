---
command: screenshot_viewport_buffer
category: core_level
title: `screenshot_viewport_buffer`
summary: 抓取深度/法线/底色等调试 buffer
aliases: []
tags: [core_level]
status: active
---

# `screenshot_viewport_buffer`

## LLM Compact

- status: active.
- purpose: 抓取深度/法线/底色等调试 buffer
- key_inputs: `format`, `max_size`, `output_file`, `quality`, `buffer`, `depth_auto_pct_high`, `depth_auto_pct_low`, `depth_far_cm` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 抓取当前视口的“深度/法线/底色”等调试截图（默认深度图），用于更可靠地发现白盒空间错误：穿插、悬空、遮挡、缝隙、楼梯被挡等。
- note: **优先 SceneCapture（推荐）**：直接用当前 Level Viewport 的相机（位置/旋转/FOV）做一次 SceneCapture，并读取 RenderTarget 得到对应 buffer；不依赖 `Buffer Visualization` 的 debug 材质。
- note: **回退 Buffer Visualization（实验）**：临时切换当前 Level Viewport 到 `Buffer Visualization` 模式并设置 `<buffer>`；截图完成后恢复原 view mode 与原 Buffer Visualization Mode。
- note: 返回字段会带 `capture_mode="scene_capture_buffer"`、`final_lit_composition=false`、`scene_capture_buffer=true`、`validation_scope="debug_buffer_only"`、`buffer`、`method`（`scene_capture` / `buffer_visualization`）和实际使用的 `viewport`，便于批量留证与回归对比。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 抓取当前视口的“深度/法线/底色”等调试截图（默认深度图），用于更可靠地发现白盒空间错误：穿插、悬空、遮挡、缝隙、楼梯被挡等。
- **优先 SceneCapture（推荐）**：直接用当前 Level Viewport 的相机（位置/旋转/FOV）做一次 SceneCapture，并读取 RenderTarget 得到对应 buffer；不依赖 `Buffer Visualization` 的 debug 材质。
- **回退 Buffer Visualization（实验）**：临时切换当前 Level Viewport 到 `Buffer Visualization` 模式并设置 `<buffer>`；截图完成后恢复原 view mode 与原 Buffer Visualization Mode。
- 返回字段会带 `capture_mode="scene_capture_buffer"`、`final_lit_composition=false`、`scene_capture_buffer=true`、`validation_scope="debug_buffer_only"`、`buffer`、`method`（`scene_capture` / `buffer_visualization`）和实际使用的 `viewport`，便于批量留证与回归对比。
- 目标 viewport 选择：优先当前正在编辑的 Level Viewport；若无法获取“当前”，则选择面积最大的透视视口（避免抓到隐藏/未渲染视口导致纯黑截图）。

## Parameters

- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `max_size`：截图或导出尺寸上限。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `quality`：有损图片输出质量；通常用于 jpg/webp。
- `buffer`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `depth_auto_pct_high`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `depth_auto_pct_low`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `depth_far_cm`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `depth_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `depth_near_cm`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `invert`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
