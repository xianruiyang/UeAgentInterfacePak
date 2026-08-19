---
command: hlod_validate_build
category: level_topology_streaming_world_partition_data_layer_hlod
title: HLOD
summary: 按明确 expectation 校验当前场景 HLOD actor 数量
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `hlod_validate_build`

## LLM Compact

- status: active.
- purpose: 按明确 expectation 校验当前场景 HLOD actor 数量
- key_inputs: `expected_hlod_actor_count` 和/或 `minimum_hlod_actor_count`
- key_returns: `status`, `hlod_actor_count`, `error_count`, `issues[]`
- behavior: 至少提供一个 expectation；空输入返回 `missing_validation_expectation`，不会把仅统计数量视为 valid。
- validation: expectation 必须是非负整数；不匹配时命令失败并返回对应 issue。

## Authoring Notes

- 本命令是断言式 readback，不是无条件统计接口。

## Parameters

- `expected_hlod_actor_count`：可选；期望精确数量，必须为非负整数。
- `minimum_hlod_actor_count`：可选；期望最小数量，必须为非负整数。
- 两者至少提供一个；同时提供时两项都必须满足。

## Returns

- `hlod_actor_count`：数量摘要。
- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `status`：`valid` 或 `invalid`。
- `error_count`：error issue 数量。

## Validation

在 `hlod_build` 后根据预期传入精确或最小数量，检查 `status=valid`、`error_count=0` 和 `hlod_actor_count`。
