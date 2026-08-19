---
command: niagara_emitter_list_stage_modules
category: niagara_stage_graph
title: Stage 模块管理
summary: 列出 Stage 模块
aliases: []
tags: [niagara_stage_graph]
status: active
---

# `niagara_emitter_list_stage_modules`

## LLM Compact

- status: active.
- purpose: 列出 Stage 模块
- key_inputs: `emitter_asset_path`, `include_inputs`
- key_returns: `module_node_guid`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `emitter_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `include_inputs`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `module_node_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
