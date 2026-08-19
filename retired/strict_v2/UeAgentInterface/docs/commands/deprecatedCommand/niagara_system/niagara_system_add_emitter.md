---
command: niagara_system_add_emitter
category: niagara_system
title: System 内 Emitter 管理
summary: **Deprecated for authoring**：向 System 添加 Emitter
aliases: []
tags: [niagara_system, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：向 System 添加 Emitter
deprecated_replacement: []
---

# `niagara_system_add_emitter`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：向 System 添加 Emitter
- key_inputs: `emitter_asset_path`, `emitter_name`, `system_asset_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `emitter_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `emitter_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `system_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
