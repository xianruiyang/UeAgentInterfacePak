---
command: world_partition_unload_actors
category: level_topology_streaming_world_partition_data_layer_hlod
title: World Partition
summary: 卸载 actor list loader
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `world_partition_unload_actors`

## LLM Compact

- status: active.
- purpose: 卸载 actor list loader
- key_inputs: `loader_id`, `dry_run`, `allow_destructive`
- key_returns: `status`, `unloaded`, `loader_id`, `kind`, `dry_run`, `allow_destructive`, `error_code`
- behavior: 默认 `dry_run=true`；真实卸载必须传 `dry_run=false` 与 `allow_destructive=true`，并且 loader kind 必须为 `actors`。
- validation: 只有 adapter 读回为未加载且 registry 条目已移除时才返回 `status=unloaded`。

## Authoring Notes

- 不得用本命令卸载 region loader；kind 不匹配返回 `world_partition_loader_kind_mismatch` 及 `expected_kind`/`actual_kind`。

## Parameters

- `loader_id`：稳定 id，用于精确定位或后续操作。
- `dry_run`：默认 `true`；只返回计划。
- `allow_destructive`：默认 `false`；真实卸载必须为 `true`。

## Returns

- `status`：`planned`、`blocked`、`failed` 或 `unloaded`。
- `unloaded`：实际 adapter 已卸载时才为 `true`。
- `kind`：固定期望为 `actors`。
- `error_code`：loader 不存在、kind 不匹配、adapter 无效或卸载失败时返回。

## Validation

真实执行后调用 `world_partition_list_loaded_regions`，确认对应 `loader_id` 已从 `uai_loaders[]` 消失。
