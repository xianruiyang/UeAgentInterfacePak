---
command: primary_asset_validate_asset
category: data_driven_data_asset_data_table
title: DataAsset / PrimaryDataAsset
summary: 验证单个资产的 Primary Asset ID、注册状态、bundle 和加载探针
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `primary_asset_validate_asset`

## LLM Compact

- status: active.
- purpose: 验证单个资产的 Primary Asset ID、注册状态、bundle 和加载探针
- key_inputs: `asset_path`, `expected_id`, `expected_type`, `load_probe`, `validate_bundles`
- key_returns: `valid`, `asset_manager_registered`, `bundles[]`, `id_matches`, `issues[]`, `type_matches`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `expected_id`：稳定 id，用于精确定位或后续操作。
- `expected_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `load_probe`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `validate_bundles`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `valid`：校验是否通过。
- `asset_manager_registered`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `bundles[]`：bundles 列表摘要；大列表应写入 output/artifact 或 debug。
- `id_matches`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `type_matches`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
