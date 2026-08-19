---
command: editor_viewport_set_camera
category: editor_viewport
title: 命令表
summary: 设置指定视口相机并读回
aliases: []
tags: [editor_viewport]
status: active
---

# `editor_viewport_set_camera`

## LLM Compact

- status: active.
- purpose: 设置指定视口相机并读回
- key_inputs: `camera.fov`, `camera.location`, `camera.orbit`, `camera.rotation`
- key_returns: `camera`, `capabilities`, `visual_options`
- note: 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- note: 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- note: 用途：设置相机后立即读回状态。默认只改变当前 Editor viewport，不保存关卡或资产。
- validation: 读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。

## Authoring Notes

- 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- 用途：设置相机后立即读回状态。默认只改变当前 Editor viewport，不保存关卡或资产。

## Parameters

- `camera.fov`：视口相机状态；通常包含 `location`、`rotation`、`fov` 或 `orbit`。
- `camera.location`：视口相机状态；通常包含 `location`、`rotation`、`fov` 或 `orbit`。
- `camera.orbit`：视口相机状态；通常包含 `location`、`rotation`、`fov` 或 `orbit`。
- `camera.rotation`：视口相机状态；通常包含 `location`、`rotation`、`fov` 或 `orbit`。

## Returns

- `camera`：写后或读回的相机状态。
- `capabilities`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visual_options`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。
