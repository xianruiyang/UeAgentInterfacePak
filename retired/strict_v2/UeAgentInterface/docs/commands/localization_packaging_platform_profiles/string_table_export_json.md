---
command: string_table_export_json
category: localization_packaging_platform_profiles
title: String Table
summary: 导出 `UStringTable` namespace、entry 和 metadata
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `string_table_export_json`

## LLM Compact

- status: active.
- purpose: 导出 `UStringTable` namespace、entry 和 metadata
- key_inputs: `asset_path`, `output_file`
- key_returns: `entries[]`, `entry_count`, `namespace`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。

## Returns

- `entries[]`：entries 列表摘要；大列表应写入 output/artifact 或 debug。
- `entry_count`：数量摘要。
- `namespace`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
