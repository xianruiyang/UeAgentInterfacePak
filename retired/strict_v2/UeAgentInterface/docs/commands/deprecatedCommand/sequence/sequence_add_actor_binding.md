---
command: sequence_add_actor_binding
category: sequence
title: Level Sequence
summary: **Deprecated for authoring**：添加 Actor 绑定
aliases: []
tags: [sequence, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：添加 Actor 绑定
deprecated_replacement: []
---

# `sequence_add_actor_binding`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：添加 Actor 绑定
- key_inputs: `actor_id`, `asset_path`
- key_returns: `bindings/*.json`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `actor_id`：Actor id，优先用于精确定位同名 Actor。
- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- `bindings/*.json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
