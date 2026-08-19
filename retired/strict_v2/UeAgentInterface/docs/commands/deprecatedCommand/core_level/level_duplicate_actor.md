---
command: level_duplicate_actor
category: core_level
title: Level Actor CRUD / Probe
summary: **Deprecated for Level Content authoring**：克隆后 patch transform/folder/tag/property 可在同一份 JSON 中完成。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for Level Content authoring**：克隆后 patch transform/folder/tag/property 可在同一份 JSON 中完成。
deprecated_replacement: []
---

# `level_duplicate_actor`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for Level Content authoring**：克隆后 patch transform/folder/tag/property 可在同一份 JSON 中完成。
- key_inputs: `folder_path`, `operations[].type=clone`, `patch`, `tags`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `folder_path`：Outliner folder 或资产 folder；具体含义以命令所在领域为准。
- `operations[].type=clone`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `patch`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `tags`：tag 列表，用于过滤、托管或保护规则。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
