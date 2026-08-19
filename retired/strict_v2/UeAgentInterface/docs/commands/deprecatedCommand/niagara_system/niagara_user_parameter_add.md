---
command: niagara_user_parameter_add
category: niagara_system
title: System User 参数 CRUD
summary: **Deprecated for authoring**：新增 User 参数
aliases: []
tags: [niagara_system, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：新增 User 参数
deprecated_replacement: []
---

# `niagara_user_parameter_add`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：新增 User 参数
- key_inputs: `asset_path`, `default_value_text`, `parameter_name`, `parameter_type`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `default_value_text`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `parameter_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `parameter_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
