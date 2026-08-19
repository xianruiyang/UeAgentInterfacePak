---
command: data_layer_create_asset
category: level_topology_streaming_world_partition_data_layer_hlod
title: DataLayer
summary: 创建或更新 `UDataLayerAsset`
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `data_layer_create_asset`

## LLM Compact

- status: active.
- purpose: 创建或更新 `UDataLayerAsset`
- key_inputs: `asset_path`, `overwrite_policy`, `type`, `debug_color`, `load_filter`, `save_after_create`, `transaction`
- key_returns: `asset_path`, `object_path`, `created_or_updated`, `saved`, `transaction`
- behavior: `overwrite_policy` 是严格枚举，仅允许 `fail|replace`；未知值直接返回 `overwrite_policy_invalid`。
- validation: 创建后用 `data_layer_query` 或资产读回确认路径、类型和属性，不能只检查 `created_or_updated`。

## Authoring Notes

- 默认 `overwrite_policy=fail`，目标已存在时返回 `asset_already_exists`；需要更新现有同类资产时显式使用 `replace`。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `overwrite_policy`：默认 `fail`；严格枚举 `fail|replace`，不接受其他拼写或隐式回退。
- `type`：可选 DataLayer 类型；无效值失败。
- `debug_color`、`load_filter`：可选资产属性。
- `save_after_create`：默认 `false`。
- `transaction`：默认 `true`。

## Returns

- `asset_path`、`object_path`：实际创建或更新的资产路径。
- `created_or_updated`：命令已完成创建或更新时为 `true`。
- `saved`、`transaction`：保存和 transaction 状态。

## Validation

成功后用 `data_layer_query` 或资产查询读回；传入未知 `overwrite_policy` 应稳定失败为 `overwrite_policy_invalid`。
