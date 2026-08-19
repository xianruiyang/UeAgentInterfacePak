---
command: material_delete_expression
category: material
title: 表达式图编辑
summary: **Deprecated for authoring**：删除表达式节点
aliases: []
tags: [material, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：删除表达式节点
deprecated_replacement: []
---

# `material_delete_expression`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：删除表达式节点
- key_inputs: `asset_path`, `expression_guid`, `expression_name`
- key_returns: `deleted_expression_guid`, `deleted_expression_name`, `apply_status`
- behavior: 破坏性命令；先 dry-run/plan，确认候选、阻断项和保护规则后再执行。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 删除先断开图引用并保留同一 UObject 到 verification 完成，只有 commit 才标记回收；失败会恢复原 collection 和输入连接。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `expression_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expression_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 返回删除前读回的 expression GUID/name、Root 状态和 `apply_status`。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
