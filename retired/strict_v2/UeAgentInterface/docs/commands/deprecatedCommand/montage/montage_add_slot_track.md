---
command: montage_add_slot_track
category: montage
title: Slot Track
summary: **Deprecated for authoring**：新增 Slot Track
aliases: []
tags: [montage, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：新增 Slot Track
deprecated_replacement: []
---

# `montage_add_slot_track`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：新增 Slot Track
- key_inputs: `asset_path`, `save_after_add`, `slot_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `save_after_add`：布尔/开关字段；默认值以本命令契约为准。
- `slot_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
