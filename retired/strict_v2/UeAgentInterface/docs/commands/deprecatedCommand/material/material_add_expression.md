---
command: material_add_expression
category: material
title: 表达式图编辑
summary: **Deprecated for authoring**：添加表达式节点
aliases: []
tags: [material, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：添加表达式节点
deprecated_replacement: []
---

# `material_add_expression`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：添加表达式节点
- key_inputs: `asset_path`, `expression_class`
- key_returns: `asset_path`, `expression`, `compiled`, `saved`, `apply_status`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 该命令已是 `material.graph.apply` 的薄适配层；类解析、UE 默认值、事务、回滚和读回不在命令层重复实现。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `expression_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `expression`：创建后按稳定 expression GUID 读回的节点信息。
- `apply_status`：统一 Apply 的提交状态；仍需结合 `expression` 和后续 Export 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
