---
command: niagara_system_list_stage_modules
category: niagara_stage_graph
title: 读取 System stage 的 module 列表
summary: 读取 System stage 的 module 列表
aliases: []
tags: [niagara_stage_graph]
status: active
---

# `niagara_system_list_stage_modules`

## LLM Compact

- status: active.
- purpose: 读取 System stage 的 module 列表
- key_inputs: `asset_path`, `include_inputs`, `script_usage`, `stage_key`
- key_returns: `modules`, `script_usage_id`, `stage_key`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `include_inputs`：布尔/开关字段；默认值以本命令契约为准。
- `script_usage`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stage_key`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `modules`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `script_usage_id`：稳定 id，用于精确定位或后续操作。
- `stage_key`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
