---
command: material_set_parameter
category: material
title: 属性与实例参数
summary: **Deprecated for authoring**：统一设置实例参数
aliases: []
tags: [material, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：统一设置实例参数
deprecated_replacement: []
---

# `material_set_parameter`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：统一设置实例参数
- key_inputs: `asset_path`, `parameter_name`, `parameter_type`
- key_returns: `parameters`, `overrides.json`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 使用 `value`
- note: 使用 `value:{r,g,b,a}` 或 `value_text`
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- 使用 `value`
- 使用 `value:{r,g,b,a}` 或 `value_text`
- 兼容旧字段 `texture_path`
- 统一写法可用 `value_path`
- 使用布尔 `value`
- 可用 `value:{r,g,b,a}`
- 也可直接传顶层 `r/g/b/a`
- 返回 `resolved_value`

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `parameter_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `parameter_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `parameters`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `overrides.json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
