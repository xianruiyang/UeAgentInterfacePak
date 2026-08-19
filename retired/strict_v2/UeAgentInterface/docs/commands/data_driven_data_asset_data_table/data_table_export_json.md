---
command: data_table_export_json
category: data_driven_data_asset_data_table
title: DataTable
summary: 导出 DataTable row schema 和 rows
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `data_table_export_json`

## LLM Compact

- status: active.
- purpose: 导出 DataTable row schema 和 rows
- key_inputs: `asset_path`, `output_file`
- key_returns: `row_count`, `row_policy=replace_all`, `row_schema[]`, `row_struct`, `row_struct_schema_hash`, `rows[]`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- `rows[].fields[]` 默认使用 `property_path` 作为字段身份，并暴露 authoring metadata。
- 默认不输出 duplicate/legacy 字段 `name`、`authored_name`、`cpp_type`；legacy `name` 仅用于显式迁移或诊断识别。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。

## Returns

- `row_count`：数量摘要。
- `row_policy=replace_all`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `row_schema[]`：row_schema 列表摘要；大列表应写入 output/artifact 或 debug。
- `row_struct`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `row_struct_schema_hash`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `rows[]`：rows 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
