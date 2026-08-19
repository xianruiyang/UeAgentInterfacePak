---
command: control_rig_viewport_set_camera
category: control_rig_folder_format
title: 预览视口相机
summary: **Deprecated for viewport camera authoring**：ControlRig Persona 预览视口相机写入已进入统一 Editor Viewport 相机命令。
aliases: []
tags: [control_rig_folder_format, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for viewport camera authoring**：ControlRig Persona 预览视口相机写入已进入统一 Editor Viewport 相机命令。
deprecated_replacement: [editor_viewport_set_camera]
---

# `control_rig_viewport_set_camera`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for viewport camera authoring**：ControlRig Persona 预览视口相机写入已进入统一 Editor Viewport 相机命令。
- key_inputs: `asset_type=control_rig`, `editor_viewport_set_camera`, `scope=asset_editor`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。

## Parameters

- `asset_type=control_rig`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `editor_viewport_set_camera`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `scope=asset_editor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
