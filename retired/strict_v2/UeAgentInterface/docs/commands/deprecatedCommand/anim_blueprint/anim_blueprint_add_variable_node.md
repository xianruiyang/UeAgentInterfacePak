---
command: anim_blueprint_add_variable_node
category: anim_blueprint
title: Blueprint 级逻辑编辑
summary: **Deprecated for authoring**：新增变量 Get/Set 节点
aliases: []
tags: [anim_blueprint, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：新增变量 Get/Set 节点
deprecated_replacement: []
---

# `anim_blueprint_add_variable_node`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：新增变量 Get/Set 节点
- key_inputs: `asset_path`, `compile_after_add`, `graph_name`, `node_type`, `pos_x`, `pos_y`, `save_after_add`, `variable_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `compile_after_add`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `graph_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `node_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `pos_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `pos_y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_add`：布尔/开关字段；默认值以本命令契约为准。
- `variable_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
