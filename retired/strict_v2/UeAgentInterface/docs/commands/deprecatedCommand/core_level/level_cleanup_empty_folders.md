---
command: level_cleanup_empty_folders
category: core_level
title: 托管清理
summary: **Deprecated for managed Level Content cleanup**：Level Content 流程内的清理应由 repair/task 统一记录。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for managed Level Content cleanup**：Level Content 流程内的清理应由 repair/task 统一记录。
deprecated_replacement: [level_content_repair_json]
---

# `level_cleanup_empty_folders`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for managed Level Content cleanup**：Level Content 流程内的清理应由 repair/task 统一记录。
- key_inputs: `level_content_repair_json`, `tasks[].type=cleanup_empty_folders`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `level_content_repair_json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `tasks[].type=cleanup_empty_folders`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
