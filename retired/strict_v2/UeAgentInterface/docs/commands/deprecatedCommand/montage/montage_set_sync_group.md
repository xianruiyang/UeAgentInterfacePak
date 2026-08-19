---
command: montage_set_sync_group
category: montage
title: 资产与基础信息
summary: **Deprecated for authoring**：设置或清空 Marker Sync 的 Group/Slot
aliases: []
tags: [montage, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：设置或清空 Marker Sync 的 Group/Slot
deprecated_replacement: []
---

# `montage_set_sync_group`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：设置或清空 Marker Sync 的 Group/Slot
- key_inputs: `asset_path`, `save_after_set`, `sync_group_name`, `sync_slot_index`, `sync_slot_name`
- key_returns: `sync`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `sync_group_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `sync_slot_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sync_slot_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- `sync`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
