---
command: level_streaming_move_actors
category: level_topology_streaming_world_partition_data_layer_hlod
title: Level Streaming
summary: 将 Actor 移入目标子关卡
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_streaming_move_actors`

## LLM Compact

- status: active.
- purpose: 将 Actor 移入目标子关卡
- key_inputs: `folder_root`, `actor_ids`, `level_package`, `target_level`, `warn_about_references`
- key_returns: `actor_results[]`, `moved_count`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `folder_root`：托管范围根 folder；场景清理时是 Outliner folder，不是 `/Game` 资产目录。
- `actor_ids`：稳定 id 列表。
- `level_package`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_level`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `warn_about_references`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `actor_results[]`：actor_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `moved_count`：数量摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
