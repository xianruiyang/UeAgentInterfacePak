---
command: blueprint_add_dynamic_cast_node
category: blueprint
title: 2026-04-22 更新
summary: - **Deprecated for authoring**：`blueprint_add_dynamic_cast_node`
aliases: []
tags: [blueprint, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: - **Deprecated for authoring**：`blueprint_add_dynamic_cast_node`
deprecated_replacement: []
---

# `blueprint_add_dynamic_cast_node`

## LLM Compact

- status: deprecated.
- purpose: - **Deprecated for authoring**：`blueprint_add_dynamic_cast_node`
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
