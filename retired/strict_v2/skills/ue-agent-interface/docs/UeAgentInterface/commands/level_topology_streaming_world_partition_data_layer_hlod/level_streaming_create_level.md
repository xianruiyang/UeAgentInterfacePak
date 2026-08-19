---
command: level_streaming_create_level
category: level_topology_streaming_world_partition_data_layer_hlod
title: Level Streaming
summary: 创建并挂载新子关卡
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_streaming_create_level`

## LLM Compact

- status: active.
- purpose: 创建并挂载新子关卡
- key_inputs: `create_world_partition`, `enable_world_partition_streaming`, `level_package`, `move_selected_actors`, `save_after_create`, `streaming_class`, `transform`, `use_external_actors`
- key_returns: `saved`, `created`, `level_package`, `streaming_class`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `create_world_partition`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `enable_world_partition_streaming`：布尔/开关字段；默认值以本命令契约为准。
- `level_package`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `move_selected_actors`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。
- `streaming_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `transform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `use_external_actors`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `saved`：是否保存资源或关卡。
- `created`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `level_package`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `streaming_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
