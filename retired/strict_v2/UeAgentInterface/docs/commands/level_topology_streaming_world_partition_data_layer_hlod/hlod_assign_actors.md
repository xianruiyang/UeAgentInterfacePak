---
command: hlod_assign_actors
category: level_topology_streaming_world_partition_data_layer_hlod
title: HLOD
summary: 给 Actor 设置 HLOD Layer、Runtime Grid、Spatially Loaded
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `hlod_assign_actors`

## LLM Compact

- status: active.
- purpose: 给 Actor 设置 HLOD Layer、Runtime Grid、Spatially Loaded
- key_inputs: actor selection, `hlod_layer|clear_hlod_layer`, `allow_destructive`, `runtime_grid`, `is_spatially_loaded`, `transaction`
- key_returns: `matched_count`, `results[]`, `actor_results[]`, `transaction`
- behavior: 未提供 `hlod_layer` 时保持原 HLOD Layer；清空必须显式 `clear_hlod_layer=true` 且 `allow_destructive=true`。
- validation: 以每个 actor 的 `results[].hlod_layer/runtime_grid/is_spatially_loaded/changed` 读回为准。

## Authoring Notes

- `hlod_layer` 与 `clear_hlod_layer=true` 互斥，冲突返回 `hlod_layer_assignment_conflict`。
- 空字符串 `hlod_layer=""` 不表示清空，返回 `hlod_layer_empty_requires_clear_hlod_layer`。
- 至少提供 `hlod_layer`、`clear_hlod_layer=true`、`runtime_grid`、`is_spatially_loaded` 之一，否则返回 `missing_hlod_assignment_fields`。

## Parameters

- `folder_root`：托管范围根 folder；场景清理时是 Outliner folder，不是 `/Game` 资产目录。
- `actor_ids`：稳定 id 列表。
- `hlod_layer`：可选；目标 HLOD Layer 资产路径。省略时不改变现值。
- `clear_hlod_layer`：默认 `false`；显式清空 HLOD Layer。
- `allow_destructive`：默认 `false`；`clear_hlod_layer=true` 时必须为 `true`。
- `is_spatially_loaded`：可选；省略时不改变现值。
- `runtime_grid`：可选；省略时不改变现值。
- `transaction`：默认 `true`。

## Returns

- `matched_count`：数量摘要。
- `results[]`：results 列表摘要；大列表应写入 output/artifact 或 debug。
- `actor_results[]`：actor 选择解析结果。
- `transaction`：实际使用的 transaction 开关。

## Validation

写入后用 `hlod_query_actors` 对同一 actor selection 读回；清空操作必须确认 `hlod_layer` 为空，并检查 `results[].changed` 与实际状态一致。
