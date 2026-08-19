---
command: niagara_emitter_add_event_handler
category: niagara_emitter
title: Event Handler 管理
summary: **Deprecated for authoring**：新增事件处理器
aliases: []
tags: [niagara_emitter, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：新增事件处理器
deprecated_replacement: []
---

# `niagara_emitter_add_event_handler`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：新增事件处理器
- key_inputs: `emitter_asset_path`, `execution_mode`, `source_emitter_id`, `source_event_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `emitter_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `execution_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source_emitter_id`：稳定 id，用于精确定位或后续操作。
- `source_event_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
