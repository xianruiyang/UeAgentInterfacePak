---
command: niagara_delete_asset
category: niagara_system
title: `niagara_delete_asset`
summary: **Deprecated**：删除 Niagara System / Emitter / Script
aliases: []
tags: [niagara_system, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated**：删除 Niagara System / Emitter / Script
deprecated_replacement: []
---

# `niagara_delete_asset`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated**：删除 Niagara System / Emitter / Script
- key_inputs: `asset_path`, `force_delete`, `use_unchecked_delete`
- key_returns: `asset_delete`
- behavior: 破坏性命令；先 dry-run/plan，确认候选、阻断项和保护规则后再执行。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `force_delete`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `use_unchecked_delete`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `asset_delete`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
