---
command: data_layer_validate
category: level_topology_streaming_world_partition_data_layer_hlod
title: DataLayer
summary: 校验 DataLayer 与 Actor 归属
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `data_layer_validate`

## LLM Compact

- status: active.
- purpose: 校验 DataLayer 与 Actor 归属
- key_inputs: `actor_ids`, `expect_actor_membership[]`, `layers[]`
- key_returns: `issues[]`, `status`
- behavior: 必须提供非空 `layers[]`，或同时提供 actor selection 与非空 `expect_actor_membership[]`；空 expectation 失败。
- validation: 空 expectation 返回 `status=invalid` 与 `missing_validation_expectation`；actor 解析失败返回 `actor_selection_invalid` issue。

## Authoring Notes

- validate 只读，不创建 DataLayer 或修改 actor 成员关系。

## Parameters

- `actor_ids`：稳定 id 列表。
- `expect_actor_membership[]`：expect_actor_membership 列表。
- `layers[]`：layers 列表。
- 至少满足一个校验分支：非空 `layers[]`；或 `actor_ids` 与非空 `expect_actor_membership[]` 的组合。

## Returns

- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `status`：`valid` 或 `invalid`。
- `error_count`、`actor_results[]`：错误数量和 actor 选择读回。

## Validation

检查 `status`、`error_count`、`issues[]` 和 `actor_results[]`；空 expectation 必须失败。
