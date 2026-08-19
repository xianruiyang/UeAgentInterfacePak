---
command: level_destroy_folder_actors
category: core_level
title: 托管清理
summary: **Deprecated for managed Level Content cleanup**：托管 scope 删除应带 managed/protected 规则。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for managed Level Content cleanup**：托管 scope 删除应带 managed/protected 规则。
deprecated_replacement: [level_content_delete_scope]
---

# `level_destroy_folder_actors`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for managed Level Content cleanup**：托管 scope 删除应带 managed/protected 规则。
- key_inputs: `delete_policy=replace_scope_managed`, `level_content_delete_scope`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `delete_policy=replace_scope_managed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `level_content_delete_scope`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
