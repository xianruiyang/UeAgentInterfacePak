---
command: data_asset_export_json
category: data_driven_data_asset_data_table
title: DataAsset / PrimaryDataAsset
summary: 导出 DataAsset schema 和字段当前值
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `data_asset_export_json`

## LLM Compact

- status: active.
- purpose: 导出 DataAsset schema 和字段当前值
- key_inputs: `asset_path`, `output_file`, `include_primary_asset`
- key_returns: `class_schema_hash`, `field_count`, `fields[]`, `primary_asset`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- `fields[]` 使用 `property_path`、精确 `value_kind` 和 canonical `value`；容器递归携带元素、key、mapped value 或 inner type。
- authoring 不输出 `selector`、`property_name`、field 级 `category_path`、`operations` 或 `value_text` 展示副本。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `include_primary_asset`：资产引用；通常传 UE 资产路径。

## Returns

- `class_schema_hash`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `field_count`：数量摘要。
- `fields[]`：默认 authoring 字段数组；每项用 `property_path` 定位，enum/choice 用 `candidates`。
- `primary_asset`：资产引用；通常传 UE 资产路径。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
