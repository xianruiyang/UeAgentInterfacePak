---
command: world_partition_list_loaded_regions
category: level_topology_streaming_world_partition_data_layer_hlod
title: World Partition
summary: 列出 UAI loader 和 UE user loaded regions
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `world_partition_list_loaded_regions`

## LLM Compact

- status: active.
- purpose: 列出 UAI loader 和 UE user loaded regions
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: `uai_loaders[]`, `user_loaded_regions[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- `uai_loaders[]`：uai_loaders 列表摘要；大列表应写入 output/artifact 或 debug。
- `user_loaded_regions[]`：user_loaded_regions 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
