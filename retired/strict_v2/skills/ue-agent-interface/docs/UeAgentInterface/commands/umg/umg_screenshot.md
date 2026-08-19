---
command: umg_screenshot
category: umg
title: 资产与编译
summary: 离屏渲染 WidgetBlueprint 并截图，可自动裁剪到可见控件外接框
aliases: []
tags: [umg]
status: active
---

# `umg_screenshot`

## LLM Compact

- status: active.
- purpose: 离屏渲染 WidgetBlueprint 并截图，可自动裁剪到可见控件外接框
- key_inputs: `asset_path`, `format`, `max_size`, `output_file`, `quality`, `bounds_padding`, `capture_height`, `capture_width` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `max_size`：截图或导出尺寸上限。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `quality`：有损图片输出质量；通常用于 jpg/webp。
- `bounds_padding`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `capture_height`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `capture_width`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `compile_before_capture`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `crop_height`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `crop_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `crop_width`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `crop_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `crop_y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `region`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
