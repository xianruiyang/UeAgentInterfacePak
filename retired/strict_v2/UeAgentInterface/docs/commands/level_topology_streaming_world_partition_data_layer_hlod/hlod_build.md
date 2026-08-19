---
command: hlod_build
category: level_topology_streaming_world_partition_data_layer_hlod
title: HLOD
summary: 规划或执行 HLOD commandlet 步骤
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `hlod_build`

## LLM Compact

- status: active.
- purpose: 规划或执行 HLOD commandlet 步骤
- key_inputs: `step`, `dry_run`, `execute`, `report_only`, `allow_commandlet`, `allow_destructive`, `allow_delete`, `allow_rhi`, `timeout_seconds`
- key_returns: `status`, `step`, `commandlet_plan`, `exit_code`, `dry_run`, `execute`, `report_only`, authorization fields, `timeout_seconds`, `error_code`
- behavior: 默认 `dry_run=true`、`execute=false`、`report_only=true`；真实执行需显式关闭两层计划开关并同时授权 commandlet 与 destructive。
- validation: commandlet 成功后用 `hlod_validate_build` 携带明确数量 expectation 验证，不能只检查进程退出。

## Authoring Notes

- `step` 严格为 `setup|build|finalize|delete|stats`；未知值返回 `hlod_build_step_invalid`。
- 真实执行的基本门禁是 `dry_run=false`、`execute=true`、`report_only=false`、`allow_commandlet=true`、`allow_destructive=true`。
- `step=delete` 额外要求 `allow_delete=true`。NullRHI 下执行 `setup` 或 `build` 额外要求 `allow_rhi=true`。

## Parameters

- `step`：默认 `stats`；严格枚举 `setup|build|finalize|delete|stats`。
- `dry_run`：默认 `true`。
- `execute`：默认 `false`；真实执行必须为 `true`。
- `report_only`：默认 `true`；真实执行必须为 `false`。
- `allow_commandlet`：默认 `false`；与 `execute=true` 组成 commandlet 双授权。
- `allow_destructive`：默认 `false`；所有真实 HLOD commandlet 步骤都必须为 `true`。
- `allow_delete`：默认 `false`；`step=delete` 必须为 `true`。
- `allow_rhi`：默认 `false`；NullRHI 下运行 `setup`/`build` 必须为 `true`。
- `timeout_seconds`：默认 `1800`；必须是有限正数，`0`、负数、NaN 或无穷值均失败。

## Returns

- `status`：`planned`、`executed` 或 `failed`。
- `commandlet_plan`：将执行的 commandlet 参数。
- `step`、`dry_run`、`execute`、`report_only`、`allow_commandlet`、`allow_destructive`、`allow_delete`、`allow_rhi`、`timeout_seconds`：有效输入读回。
- `exit_code` 及进程字段：真实启动 commandlet 后返回。
- `error_code`：包括 `timeout_seconds_invalid`、`requires_commandlet`、`requires_allow_destructive`、`requires_allow_delete`、`requires_rhi`。

## Validation

默认请求必须得到 `status=planned` 且不启动 commandlet。真实执行后按目标传 `hlod_validate_build` 的 `expected_hlod_actor_count` 或 `minimum_hlod_actor_count`，再查询相关 HLOD actor/资产状态。
