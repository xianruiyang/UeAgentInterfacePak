---
command: sequence_add_property_track
category: sequence
title: 通用属性轨道
summary: **Deprecated for authoring**：统一创建属性轨道
aliases: []
tags: [sequence, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：统一创建属性轨道
deprecated_replacement: []
---

# `sequence_add_property_track`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：统一创建属性轨道
- key_inputs: `asset_path`, `binding_guid`, `property_name`, `property_type`
- key_returns: `bindings/<Binding>/tracks/*.json`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `binding_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `property_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `property_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `bindings/<Binding>/tracks/*.json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
