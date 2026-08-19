---
command: level_streaming_add_existing
category: level_topology_streaming_world_partition_data_layer_hlod
title: Level Streaming
summary: 将已有关卡资产作为 streaming level 挂入当前 World
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_streaming_add_existing`

## LLM Compact

- status: active.
- purpose: 将已有关卡资产作为 streaming level 挂入当前 World
- key_inputs: `level_package`, `streaming_class`, `transform`
- key_returns: `added`, `level_package`, `loaded`, `visible`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `level_package`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `streaming_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `transform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `added`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `level_package`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `loaded`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visible`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
