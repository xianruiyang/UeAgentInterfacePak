---
command: level_streaming_validate
category: level_topology_streaming_world_partition_data_layer_hlod
title: Level Streaming
summary: 校验子关卡存在、加载/可见状态、Actor 所属关卡
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_streaming_validate`

## LLM Compact

- status: active.
- purpose: 校验子关卡存在、加载/可见状态、Actor 所属关卡
- key_inputs: `actor_ids`, `expected_loaded`, `expected_visible`, `level_package`
- key_returns: `issues[]`, `status`
- behavior: `level_package` 是必填 expectation；空输入不再视为 valid。
- validation: 无 `level_package` 时返回 `status=invalid`、`missing_validation_expectation`，命令失败。

## Authoring Notes

- validate 只读，不修改 streaming level 或 actor。

## Parameters

- `actor_ids`：稳定 id 列表。
- `expected_loaded`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expected_visible`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `level_package`：必填；缺失或空字符串产生 `missing_validation_expectation`。

## Returns

- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `status`：`valid` 或 `invalid`。
- `error_count`、`actor_results[]`：错误数量和 actor 选择读回。

## Validation

检查 `status`、`error_count` 和 `issues[]`；空 expectation 必须失败，不能把空校验当作成功读回。
