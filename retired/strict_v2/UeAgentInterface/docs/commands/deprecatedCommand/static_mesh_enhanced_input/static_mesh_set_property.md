---
command: static_mesh_set_property
category: static_mesh_enhanced_input
title: StaticMesh
summary: **Deprecated for authoring**：设置网格资产属性
aliases: []
tags: [static_mesh_enhanced_input, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：设置网格资产属性
deprecated_replacement: []
---

# `static_mesh_set_property`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：设置网格资产属性
- key_inputs: `asset_path`, `property_name`, `value_text`
- key_returns: `asset_apply_property_json`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `property_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `value_text`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `asset_apply_property_json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
