---
command: material_connect_expressions
category: material
title: 表达式图编辑
summary: **Deprecated for authoring**：连接节点到节点
aliases: []
tags: [material, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：连接节点到节点
deprecated_replacement: []
---

# `material_connect_expressions`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：连接节点到节点
- key_inputs: `asset_path`, `from_expression*`, `to_expression*`
- key_returns: `from_expression_guid`, `to_expression_guid`, `from_output_name`, `to_input_name`, `apply_status`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 两端 selector、pin 解析、事务和连接读回由 `material.graph.apply` 统一处理；冲突 selector 不会静默选中。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `from_expression*`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `to_expression*`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 返回规范化后的两端 GUID 和 pin 名，以及 `apply_status`。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
