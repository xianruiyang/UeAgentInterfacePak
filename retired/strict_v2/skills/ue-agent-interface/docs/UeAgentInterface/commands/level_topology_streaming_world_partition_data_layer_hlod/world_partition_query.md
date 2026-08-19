---
command: world_partition_query
category: level_topology_streaming_world_partition_data_layer_hlod
title: World Partition
summary: 查询当前 World Partition 状态
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `world_partition_query`

## LLM Compact

- status: active.
- purpose: 查询当前 World Partition 状态
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: `available`, `streaming_enabled`, `world_path`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- `available`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `streaming_enabled`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `world_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
