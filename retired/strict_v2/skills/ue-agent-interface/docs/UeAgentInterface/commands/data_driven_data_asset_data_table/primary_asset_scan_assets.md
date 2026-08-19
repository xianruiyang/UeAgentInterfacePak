---
command: primary_asset_scan_assets
category: data_driven_data_asset_data_table
title: DataAsset / PrimaryDataAsset
summary: 按 Primary Asset 类型读取 Asset Manager 扫描结果
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `primary_asset_scan_assets`

## LLM Compact

- status: active.
- purpose: 按 Primary Asset 类型读取 Asset Manager 扫描结果
- key_inputs: `load_assets`, `paths[]`, `primary_asset_type`, `type`
- key_returns: `asset_count`, `assets[]`, `found`, `loaded_count`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `load_assets`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `paths[]`：paths 列表。
- `primary_asset_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `asset_count`：数量摘要。
- `assets[]`：assets 列表摘要；大列表应写入 output/artifact 或 debug。
- `found`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `loaded_count`：数量摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
