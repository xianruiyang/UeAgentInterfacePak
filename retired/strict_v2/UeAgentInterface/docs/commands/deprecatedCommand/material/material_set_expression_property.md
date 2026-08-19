---
command: material_set_expression_property
category: material
title: 表达式图编辑
summary: **Deprecated for authoring**：设置节点属性
aliases: []
tags: [material, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：设置节点属性
deprecated_replacement: []
---

# `material_set_expression_property`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：设置节点属性
- key_inputs: `asset_path`, `expression_guid|expression_name|expression_index`, `property_path`, `value`
- key_returns: `expression_guid`, `property_path`, `applied_value_text`, `apply_status`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: `value` 使用共享结构化 PropertyValueCodec；`property_name`/`value_text` 仅是该废弃命令的边界适配，不是 Material Apply 内部格式。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `expression_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expression_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `property_path`：共享反射属性路径；`property_name` 是废弃别名。
- `value`：共享结构化属性值；标量使用 `{ literal: ... }`，复合类型遵循 PropertyValueCodec。
- `value_text`：仅保留给旧调用的命令边界适配；新调用不要使用。

## Returns

- `expression_guid`、`property_path`：实际定位并写后的属性身份。
- `applied_value_text`：兼容性读回文本；结构化 authoring 应以后续 Export/readback 的 `value` 为准。
- `apply_status`：统一 Apply 的提交状态。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
