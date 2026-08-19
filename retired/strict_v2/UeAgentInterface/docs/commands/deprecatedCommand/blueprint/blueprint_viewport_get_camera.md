---
command: blueprint_viewport_get_camera
category: blueprint
title: 蓝图预览视口相机
summary: **Deprecated for viewport camera authoring**：Blueprint SCS 预览视口相机读取已进入统一 Editor Viewport 状态命令。
aliases: []
tags: [blueprint, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for viewport camera authoring**：Blueprint SCS 预览视口相机读取已进入统一 Editor Viewport 状态命令。
deprecated_replacement: [editor_viewport_get_state]
---

# `blueprint_viewport_get_camera`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for viewport camera authoring**：Blueprint SCS 预览视口相机读取已进入统一 Editor Viewport 状态命令。
- key_inputs: `asset_type=blueprint`, `editor_viewport_get_state`, `scope=asset_editor`, `viewport_role=components`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_type=blueprint`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `editor_viewport_get_state`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `scope=asset_editor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `viewport_role=components`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
