---
command: level_topology_set_actor_assignments
category: level_topology_streaming_world_partition_data_layer_hlod
title: 拓扑编排
summary: 一次性设置 Actor 的子关卡、DataLayer、HLOD、WP 相关分配
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_topology_set_actor_assignments`

## LLM Compact

- status: active.
- purpose: 一次性设置 Actor 的子关卡、DataLayer、HLOD、WP 相关分配
- key_inputs: `actor_ids`, `level_package`, `data_layers`, `data_layer_mode`, `hlod_layer|clear_hlod_layer`, `allow_destructive`, `runtime_grid`, `is_spatially_loaded`, `transaction`
- key_returns: `changed`, `results[]`
- behavior: 未提供 `hlod_layer` 时保持原 HLOD Layer；清空必须显式 `clear_hlod_layer=true` 且 `allow_destructive=true`。
- validation: 分别用 level、DataLayer 和 HLOD query 读回，不以顶层 `changed` 代替逐域验证。

## Authoring Notes

- HLOD 清空语义与 `hlod_assign_actors` 一致：空字符串不清空，`hlod_layer` 与 `clear_hlod_layer` 互斥。
- `data_layer_mode` 传递给 DataLayer membership，严格为 `add|remove|replace|clear`。

## Parameters

- `actor_ids`：稳定 id 列表。
- `data_layers`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `data_layer_mode`：默认按下游契约；严格枚举 `add|remove|replace|clear`。
- `hlod_layer`：可选；省略时不改变现值。
- `clear_hlod_layer`：默认 `false`；清空需 `allow_destructive=true`。
- `allow_destructive`：默认 `false`；用于授权 HLOD Layer 清空。
- `is_spatially_loaded`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `level_package`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `runtime_grid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `transaction`：默认 `true`，传递给子操作。

## Returns

- `changed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `results[]`：results 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

按实际包含的赋值域分别调用 `level_streaming_query`、`data_layer_query` 和 `hlod_query_actors`；清空 HLOD 时确认读回为空。
