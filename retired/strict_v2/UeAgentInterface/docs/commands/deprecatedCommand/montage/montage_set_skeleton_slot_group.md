---
command: montage_set_skeleton_slot_group
category: montage
title: 资产与基础信息
summary: **Deprecated for Montage authoring**：注册 Slot 并设置到指定 Group
aliases: []
tags: [montage, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for Montage authoring**：注册 Slot 并设置到指定 Group
deprecated_replacement: []
---

# `montage_set_skeleton_slot_group`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for Montage authoring**：注册 Slot 并设置到指定 Group
- key_inputs: `asset_path`, `group_name`, `save_skeleton`, `skeleton_path`, `slot_name`
- key_returns: `skeleton_slots`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `group_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `save_skeleton`：布尔/开关字段；默认值以本命令契约为准。
- `skeleton_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `slot_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- `skeleton_slots`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
