---
command: level_streaming_query
category: level_topology_streaming_world_partition_data_layer_hlod
title: Level Streaming
summary: 列出当前 World 的 streaming levels
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_streaming_query`

## LLM Compact

- status: active.
- purpose: 列出当前 World 的 streaming levels
- key_inputs: `include_actors`
- key_returns: `count`, `streaming_levels[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_actors`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `count`：数量摘要。
- `streaming_levels[]`：streaming_levels 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
