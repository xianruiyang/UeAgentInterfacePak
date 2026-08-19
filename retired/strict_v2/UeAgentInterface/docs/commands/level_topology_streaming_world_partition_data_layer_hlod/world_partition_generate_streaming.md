---
command: world_partition_generate_streaming
category: level_topology_streaming_world_partition_data_layer_hlod
title: World Partition
summary: 生成 streaming 数据，默认只返回计划
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `world_partition_generate_streaming`

## LLM Compact

- status: active.
- purpose: 生成 streaming 数据，默认只返回计划
- key_inputs: `dry_run`, `allow_write`, `allow_commandlet`, `allow_destructive`, `timeout_seconds`
- key_returns: `status`, `commandlet_plan`, `exit_code`, `dry_run`, `allow_write`, `allow_commandlet`, `allow_destructive`, `timeout_seconds`, `error_code`
- behavior: 默认 `dry_run=true`、`allow_write=false`；真实生成必须同时传 `dry_run=false`、`allow_write=true`、`allow_commandlet=true`、`allow_destructive=true`。
- validation: `allow_write` 与 `allow_commandlet` 组成写入/commandlet 双授权，且仍需 destructive 授权。

## Authoring Notes

- 计划态只返回 commandlet 参数，不启动进程。
- `timeout_seconds` 在计划态也会校验，必须是有限正数。

## Parameters

- `dry_run`：默认 `true`。
- `allow_write`：默认 `false`；真实执行必须为 `true`。
- `allow_commandlet`：默认 `false`；真实执行必须为 `true`。
- `allow_destructive`：默认 `false`；真实执行必须为 `true`。
- `timeout_seconds`：默认 `600`；必须是有限正数。

## Returns

- `status`：`planned`、`generated` 或 `failed`。
- `commandlet_plan`：将执行的 WorldPartitionBuilder 参数。
- `exit_code` 及进程字段：真实启动 commandlet 后返回。
- 保护参数与 `timeout_seconds`：有效输入读回。
- `error_code`：包括 `timeout_seconds_invalid`、`requires_commandlet`、`requires_allow_destructive`。

## Validation

真实执行后检查 `status=generated` 与 `exit_code`，再用 `world_partition_check_errors` 和 `world_partition_query` 验证生成后的拓扑状态。
