---
command: viewport_frame_actor
category: core_level
title: Level Viewport 相机与聚焦
summary: **Deprecated for viewport focus authoring**：Actor bounds 取景已由统一 focus model 表达。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for viewport focus authoring**：Actor bounds 取景已由统一 focus model 表达。
deprecated_replacement: [editor_viewport_focus]
---

# `viewport_frame_actor`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for viewport focus authoring**：Actor bounds 取景已由统一 focus model 表达。
- key_inputs: `focus.mode=actor`, `collision_aware`, `editor_viewport_focus`, `look_at`, `padding`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `focus.mode=actor`：聚焦目标；可为 selection、bounds、component、bone、socket 或 preview component 等 adapter 支持形式。
- `collision_aware`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `editor_viewport_focus`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `look_at`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `padding`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
