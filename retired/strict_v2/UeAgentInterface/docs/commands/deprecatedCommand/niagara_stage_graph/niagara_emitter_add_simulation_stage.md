---
command: niagara_emitter_add_simulation_stage
category: niagara_stage_graph
title: Stage 管理
summary: **Deprecated for authoring**：新增 Simulation Stage
aliases: []
tags: [niagara_stage_graph, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：新增 Simulation Stage
deprecated_replacement: []
---

# `niagara_emitter_add_simulation_stage`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：新增 Simulation Stage
- key_inputs: `emitter_asset_path`, `stage_class`, `stage_name`, `target_index`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `emitter_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `stage_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stage_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `target_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
