---
command: anim_blueprint_clear_entry_state
category: anim_blueprint
title: State Machine
summary: **Deprecated for authoring**：清空 Entry 当前连线
aliases: []
tags: [anim_blueprint, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：清空 Entry 当前连线
deprecated_replacement: []
---

# `anim_blueprint_clear_entry_state`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：清空 Entry 当前连线
- key_inputs: `asset_path`, `compile_after_clear`, `save_after_clear`, `state_machine_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `compile_after_clear`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_clear`：布尔/开关字段；默认值以本命令契约为准。
- `state_machine_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
