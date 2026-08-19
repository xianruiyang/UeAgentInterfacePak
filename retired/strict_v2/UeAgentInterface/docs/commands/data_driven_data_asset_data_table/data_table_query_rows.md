---
command: data_table_query_rows
category: data_driven_data_asset_data_table
title: DataTable
summary: 局部查询 rows 和字段
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `data_table_query_rows`

## LLM Compact

- status: active.
- purpose: 局部查询 rows 和字段
- key_inputs: `asset_path`, `field_filters[]`, `field_names[]`, `limit`, `row_names[]`
- key_returns: `row_count`, `rows[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `field_filters[]`：field_filters 列表。
- `field_names[]`：field_names 列表。
- `limit`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `row_names[]`：row_names 列表。

## Returns

- `row_count`：数量摘要。
- `rows[]`：rows 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
