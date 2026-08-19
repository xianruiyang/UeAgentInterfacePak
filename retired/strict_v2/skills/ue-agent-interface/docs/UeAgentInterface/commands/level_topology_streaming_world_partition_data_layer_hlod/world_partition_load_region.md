---
command: world_partition_load_region
category: level_topology_streaming_world_partition_data_layer_hlod
title: World Partition
summary: 通过 bounds 创建并加载 UAI 管理的 region loader
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `world_partition_load_region`

## LLM Compact

- status: active.
- purpose: 通过 bounds 创建并加载 UAI 管理的 region loader
- key_inputs: `bounds.center+extent`, `bounds.min+max`, `dry_run`, `label`
- key_returns: `loaded`, `loader_id`, `status`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `bounds.center+extent`：空间范围；通常支持 `center/extent` 或 `min/max`，坐标空间由命令或 `bounds.space` 决定。
- `bounds.min+max`：空间范围；通常支持 `center/extent` 或 `min/max`，坐标空间由命令或 `bounds.space` 决定。
- `dry_run`：只计划/报告不写入；删除类命令通常默认 true，执行删除需显式 false。
- `label`：新建或目标 Actor 的 editor label。

## Returns

- `loaded`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `loader_id`：稳定 id，用于精确定位或后续操作。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
