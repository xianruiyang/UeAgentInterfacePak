---
command: probe_camera_pixel_scale
category: probe
title: `probe_camera_pixel_scale`
summary: 计算目标点 / Actor 相对当前 Level Viewport 相机的位置，并给出目标深度处屏幕 1 像素横向 / 纵向对应的相机空间距离
aliases: []
tags: [probe]
status: active
---

# `probe_camera_pixel_scale`

## LLM Compact

- status: active.
- purpose: 计算目标点 / Actor 相对当前 Level Viewport 相机的位置，并给出目标深度处屏幕 1 像素横向 / 纵向对应的相机空间距离
- key_inputs: `id`, `pixel_step`, `sample_screen_x`, `sample_screen_y`, `target_point`, `world_location`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 当前仅支持 Perspective Level Viewport；正交视口会返回 `viewport_not_perspective`。
- note: 该命令只读 viewport / Actor 状态，不移动 Actor、不截图、不产生 dirty resource。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 当前仅支持 Perspective Level Viewport；正交视口会返回 `viewport_not_perspective`。
- 该命令只读 viewport / Actor 状态，不移动 Actor、不截图、不产生 dirty resource。

## Parameters

- `id`：稳定 id，用于精确定位或后续操作。
- `pixel_step`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sample_screen_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sample_screen_y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_point`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `world_location`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
