---
command: viewport_set_camera
category: core_level
title: Level Viewport 相机与聚焦
summary: **Deprecated for viewport camera authoring**：Level Viewport 相机写入已进入统一视口相机命令。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for viewport camera authoring**：Level Viewport 相机写入已进入统一视口相机命令。
deprecated_replacement: [editor_viewport_set_camera]
---

# `viewport_set_camera`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for viewport camera authoring**：Level Viewport 相机写入已进入统一视口相机命令。
- key_inputs: `camera.location`, `rotation`, `fov`, `camera.orbit`, `editor_viewport_set_camera`, `scope=level_editor`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `camera.location/rotation/fov`：视口相机状态；通常包含 `location`、`rotation`、`fov` 或 `orbit`。
- `camera.orbit`：视口相机状态；通常包含 `location`、`rotation`、`fov` 或 `orbit`。
- `editor_viewport_set_camera`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `scope=level_editor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
