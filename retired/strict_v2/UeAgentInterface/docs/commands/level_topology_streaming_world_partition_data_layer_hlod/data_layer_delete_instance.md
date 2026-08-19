---
command: data_layer_delete_instance
category: level_topology_streaming_world_partition_data_layer_hlod
title: DataLayer
summary: 删除当前 World 的 DataLayer instance
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `data_layer_delete_instance`

## LLM Compact

- status: active.
- purpose: 删除当前 World 的 DataLayer instance
- key_inputs: `layer`, `dry_run`, `allow_destructive`, `allow_delete`, `delete_asset`, `transaction`
- key_returns: `status`, `deleted`, `deleted_asset_count`, `instance_name`, `dry_run`, `allow_destructive`, `allow_delete`, `error_code`
- behavior: 默认 `dry_run=true`；真实删除 instance 必须同时传 `dry_run=false`、`allow_destructive=true`、`allow_delete=true`。
- validation: 只有 `status=deleted` 且 `deleted=true` 才表示 instance 已实际删除；请求删除资产时还需 `deleted_asset_count>0`。

## Authoring Notes

- `allow_delete` 对 instance 删除本身也必需，不只在 `delete_asset=true` 时必需。
- `delete_asset=true` 会在 instance 删除后继续删除关联 DataLayerAsset；后一步失败返回 `status=partial_failure`，不会把 instance 删除伪报为整体成功。

## Parameters

- `layer`：必填；DataLayer instance 名称或可解析标识。兼容别名为 `instance_name`。
- `dry_run`：默认 `true`；为 `true` 时只返回 `status=planned`，不删除。
- `allow_destructive`：默认 `false`；真实执行必须为 `true`。
- `allow_delete`：默认 `false`；真实执行必须为 `true`。
- `delete_asset`：默认 `false`；为 `true` 时同时删除关联 DataLayerAsset。
- `transaction`：默认 `true`；是否用 UE transaction 包裹写入。

## Returns

- `status`：`planned`、`blocked`、`failed`、`partial_failure` 或 `deleted`。
- `deleted`：实际读回确认 instance 已不存在时才为 `true`。
- `deleted_asset_count`：实际删除的关联资产数量。
- `instance_name`：被定位的 instance 名称。
- `error_code`：保护或实际删除失败时返回，例如 `requires_allow_destructive`、`requires_allow_delete`、`data_layer_instance_delete_failed`、`data_layer_asset_delete_failed`。

## Validation

先执行默认 dry-run 检查候选。真实执行后用 `data_layer_query` 确认 instance 消失；若 `delete_asset=true`，再用资产查询确认 DataLayerAsset 不存在，并检查 `deleted_asset_count`。
