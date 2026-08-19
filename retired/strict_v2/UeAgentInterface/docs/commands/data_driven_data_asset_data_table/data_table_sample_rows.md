---
command: data_table_sample_rows
category: data_driven_data_asset_data_table
title: DataTable
summary: 对指定行字段做断言采样
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `data_table_sample_rows`

## LLM Compact

- status: active.
- purpose: 对指定行字段做断言采样
- key_inputs: `asset_path`, `checks[]`
- key_returns: `checks[]`, `failed_count`, `passed`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `checks[]`：checks 列表。

## Returns

- `checks[]`：checks 列表摘要；大列表应写入 output/artifact 或 debug。
- `failed_count`：数量摘要。
- `passed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
