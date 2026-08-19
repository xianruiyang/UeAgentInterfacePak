---
command: data_layer_set_actor_membership
category: level_topology_streaming_world_partition_data_layer_hlod
title: DataLayer
summary: 设置 Actor 与 DataLayer 的成员关系
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `data_layer_set_actor_membership`

## LLM Compact

- status: active.
- purpose: 设置 Actor 与 DataLayer 的成员关系
- key_inputs: actor selection, `layers[]|layer`, `mode`, `transaction`
- key_returns: `mode`, `matched_count`, `changed_count`, `readback_failure_count`, `results[]`, `actor_results[]`
- behavior: `mode` 是严格枚举 `add|remove|replace|clear`，默认 `add`；未知值返回 `data_layer_membership_mode_invalid`。
- validation: 以每个 actor 的 membership readback 和 `readback_failure_count` 为准。

## Authoring Notes

- `replace` 先清除现有成员关系再设置目标 layers；`clear` 清除全部 DataLayer 成员关系。

## Parameters

- `folder_root`：托管范围根 folder；场景清理时是 Outliner folder，不是 `/Game` 资产目录。
- `actor_ids`：稳定 id 列表。
- `layers[]`：layers 列表。
- `layer`：单个 layer 的兼容输入。
- `mode`：默认 `add`；严格枚举 `add|remove|replace|clear`，不接受未知值或隐式回退。
- `transaction`：默认 `true`。

## Returns

- `mode`、`matched_count`、`changed_count`、`readback_failure_count`。
- `results[]`：每个 actor 的变更及成员关系读回。
- `actor_results[]`：actor 选择解析结果。

## Validation

写入后用 `data_layer_query` 或 actor 查询交叉验证成员关系；`readback_failure_count` 必须为 `0`。
