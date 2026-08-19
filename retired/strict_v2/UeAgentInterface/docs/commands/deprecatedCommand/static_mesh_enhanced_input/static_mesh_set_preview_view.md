---
command: static_mesh_set_preview_view
category: static_mesh_enhanced_input
title: StaticMesh
summary: Deprecated: `static_mesh_set_preview_view` 的替代流程为 `editor_viewport_set_camera`；需要临时设置相机并截图时使用 `editor_viewport_screenshot`。
aliases: []
tags: [static_mesh_enhanced_input, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: Deprecated: `static_mesh_set_preview_view` 的替代流程为 `editor_viewport_set_camera`；需要临时设置相机并截图时使用 `editor_viewport_screenshot`。
deprecated_replacement: [editor_viewport_screenshot, editor_viewport_set_camera]
---

# `static_mesh_set_preview_view`

## LLM Compact

- status: deprecated.
- purpose: Deprecated: `static_mesh_set_preview_view` 的替代流程为 `editor_viewport_set_camera`；需要临时设置相机并截图时使用 `editor_viewport_screenshot`。
- key_inputs: `asset_path`, `distance`, `fov`, `pitch`, `yaw`
- key_returns: `camera.orbit`, `asset_type=static_mesh`, `editor_viewport_screenshot`, `editor_viewport_set_camera`, `scope=asset_editor`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `distance`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `fov`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `pitch`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `yaw`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `camera.orbit`：写后或读回的相机状态。
- `asset_type=static_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `editor_viewport_screenshot`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `editor_viewport_set_camera`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `scope=asset_editor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
