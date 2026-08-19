---
command: data_layer_create_instance
category: level_topology_streaming_world_partition_data_layer_hlod
title: DataLayer
summary: 在当前 World 创建 DataLayer instance
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `data_layer_create_instance`

## LLM Compact

- status: active.
- purpose: 在当前 World 创建 DataLayer instance
- key_inputs: `asset_path`, `initial_runtime_state`, `initially_visible`, `parent`, `short_name`
- key_returns: `asset_path`, `instance_name`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `initial_runtime_state`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `initially_visible`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `parent`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `short_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- `asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `instance_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
