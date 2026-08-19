---
command: spawn_actor
category: core_level
title: Level Actor CRUD / Probe
summary: **Deprecated for Level Content authoring**：普通 Actor 创建、label、folder、tag、static mesh 和 transform 已由 Level Content resource 表达。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for Level Content authoring**：普通 Actor 创建、label、folder、tag、static mesh 和 transform 已由 Level Content resource 表达。
deprecated_replacement: [level_content_apply_json]
---

# `spawn_actor`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for Level Content authoring**：普通 Actor 创建、label、folder、tag、static mesh 和 transform 已由 Level Content resource 表达。
- key_inputs: `class_path`, `kind`, `level_content_apply_json`, `resources[].operation=create/upsert`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `class_path`：UE class path；未传时部分命令会按 `kind` 推导。
- `kind`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `level_content_apply_json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `resources[].operation=create/upsert`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
