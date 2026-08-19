---
command: world_partition_set_streaming_enabled
category: level_topology_streaming_world_partition_data_layer_hlod
title: World Partition
summary: 修改 World Partition streaming 开关
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `world_partition_set_streaming_enabled`

## LLM Compact

- status: active.
- purpose: 修改 World Partition streaming 开关
- key_inputs: `transaction`, `enabled`
- key_returns: `streaming_enabled`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `transaction`：是否使用 UE transaction 包裹写入。
- `enabled`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `streaming_enabled`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
