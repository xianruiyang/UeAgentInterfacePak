---
command: level_streaming_set_state
category: level_topology_streaming_world_partition_data_layer_hlod
title: Level Streaming
summary: 设置 streaming level 加载、可见、当前关卡和 transform
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_streaming_set_state`

## LLM Compact

- status: active.
- purpose: 设置 streaming level 加载、可见、当前关卡和 transform
- key_inputs: `current`, `level_package`, `loaded`, `transform`, `visible`
- key_returns: `changed`, `loaded`, `should_be_loaded`, `should_be_visible`, `visible`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `current`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `level_package`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `loaded`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `transform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visible`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `changed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `loaded`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `should_be_loaded`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `should_be_visible`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visible`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
