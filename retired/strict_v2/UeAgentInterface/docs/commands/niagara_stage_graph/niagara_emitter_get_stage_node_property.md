---
command: niagara_emitter_get_stage_node_property
category: niagara_stage_graph
title: Stage 节点管理
summary: 读取节点属性
aliases: []
tags: [niagara_stage_graph]
status: active
---

# `niagara_emitter_get_stage_node_property`

## LLM Compact

- status: active.
- purpose: 读取节点属性
- key_inputs: `emitter_asset_path`, `node_guid`, `property_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `emitter_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `node_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `property_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
