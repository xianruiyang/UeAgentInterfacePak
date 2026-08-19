---
command: world_partition_load_actors
category: level_topology_streaming_world_partition_data_layer_hlod
title: World Partition
summary: 通过 Actor GUID 或已加载 Actor 选择创建 actor list loader
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `world_partition_load_actors`

## LLM Compact

- status: active.
- purpose: 通过 Actor GUID 或已加载 Actor 选择创建 actor list loader
- key_inputs: `dry_run`, `actor_guids[]`, `actor_ids[]`
- key_returns: `actor_guid_count`, `loaded`, `loader_id`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `dry_run`：只计划/报告不写入；删除类命令通常默认 true，执行删除需显式 false。
- `actor_guids[]`：actor_guids 列表。
- `actor_ids[]`：actor_ids 列表。

## Returns

- `actor_guid_count`：数量摘要。
- `loaded`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `loader_id`：稳定 id，用于精确定位或后续操作。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
