---
command: hlod_query_actors
category: level_topology_streaming_world_partition_data_layer_hlod
title: HLOD
summary: 查询 Actor 的 HLOD/WP 分配
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `hlod_query_actors`

## LLM Compact

- status: active.
- purpose: 查询 Actor 的 HLOD/WP 分配
- key_inputs: `folder_root`, `actor_ids`
- key_returns: `actors[]`, `actor_results[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `folder_root`：托管范围根 folder；场景清理时是 Outliner folder，不是 `/Game` 资产目录。
- `actor_ids`：稳定 id 列表。

## Returns

- `actors[]`：候选或读回 Actor 摘要列表；完整展开应走 output/debug。
- `actor_results[]`：actor_results 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
