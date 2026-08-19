---
command: level_streaming_save
category: level_topology_streaming_world_partition_data_layer_hlod
title: Level Streaming
summary: 保存一个或全部 streaming level package
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_streaming_save`

## LLM Compact

- status: active.
- purpose: 保存一个或全部 streaming level package
- key_inputs: `all`, `level_package`
- key_returns: `saved_count`, `saved_packages[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `all`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `level_package`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `saved_count`：数量摘要。
- `saved_packages[]`：saved_packages 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
