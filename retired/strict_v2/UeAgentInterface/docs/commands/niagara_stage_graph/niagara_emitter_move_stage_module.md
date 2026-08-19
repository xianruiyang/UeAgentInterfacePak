---
command: niagara_emitter_move_stage_module
category: niagara_stage_graph
title: **原子/兼容**：移动 standalone Emitter 的 stage module；新 authoring 优先用 folder HJSON
summary: **原子/兼容**：移动 standalone Emitter 的 stage module；新 authoring 优先用 folder HJSON
aliases: []
tags: [niagara_stage_graph]
status: active
---

# `niagara_emitter_move_stage_module`

## LLM Compact

- status: active.
- purpose: **原子/兼容**：移动 standalone Emitter 的 stage module；新 authoring 优先用 folder HJSON
- key_inputs: `emitter_asset_path`, `module_node_guid`, `script_usage`, `stage_key`, `target_index`
- key_returns: `saved`, `module_node_guid`, `stage_key`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `emitter_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `module_node_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `script_usage`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stage_key`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `saved`：是否保存资源或关卡。
- `module_node_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stage_key`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
