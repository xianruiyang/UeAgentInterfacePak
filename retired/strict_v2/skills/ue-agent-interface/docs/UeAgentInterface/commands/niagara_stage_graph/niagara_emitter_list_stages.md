---
command: niagara_emitter_list_stages
category: niagara_stage_graph
title: Stage 管理
summary: 列出 Emitter 所有 Stage
aliases: []
tags: [niagara_stage_graph]
status: active
---

# `niagara_emitter_list_stages`

## LLM Compact

- status: active.
- purpose: 列出 Emitter 所有 Stage
- key_inputs: `emitter_asset_path`, `include_module_inputs`, `include_modules`
- key_returns: `script_usage_id`, `stage_key`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `emitter_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `include_module_inputs`：布尔/开关字段；默认值以本命令契约为准。
- `include_modules`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `script_usage_id`：稳定 id，用于精确定位或后续操作。
- `stage_key`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
