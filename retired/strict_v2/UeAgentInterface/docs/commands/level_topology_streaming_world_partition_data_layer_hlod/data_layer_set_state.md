---
command: data_layer_set_state
category: level_topology_streaming_world_partition_data_layer_hlod
title: DataLayer
summary: 编辑 DataLayer instance 状态
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `data_layer_set_state`

## LLM Compact

- status: active.
- purpose: 编辑 DataLayer instance 状态
- key_inputs: `initial_runtime_state`, `initially_visible`, `layer`, `loaded_in_editor`, `short_name`, `visible`
- key_returns: `changed`, `initial_runtime_state`, `short_name`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `initial_runtime_state`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `initially_visible`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `layer`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `loaded_in_editor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `short_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `visible`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `changed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `initial_runtime_state`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `short_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
