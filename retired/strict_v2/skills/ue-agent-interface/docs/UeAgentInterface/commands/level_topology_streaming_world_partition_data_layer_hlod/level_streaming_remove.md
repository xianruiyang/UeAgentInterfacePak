---
command: level_streaming_remove
category: level_topology_streaming_world_partition_data_layer_hlod
title: Level Streaming
summary: 从当前 World 移除 streaming level
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_streaming_remove`

## LLM Compact

- status: active.
- purpose: 从当前 World 移除 streaming level
- key_inputs: `level_package`, `dry_run`, `allow_destructive`, `delete_asset`, `allow_delete`, `clear_selection`, `reset_transaction_buffer`, `transaction`
- key_returns: `status`, `removed`, `deleted_asset_count`, `level_package`, `dry_run`, `allow_destructive`, `allow_delete`, `error_code`
- behavior: 默认 `dry_run=true`；真实移除需 `dry_run=false` 与 `allow_destructive=true`，删除关卡资产还需 `allow_delete=true`。
- validation: `removed` 来自实际移除结果；请求删除资产时 `deleted_asset_count<=0` 返回 `partial_failure`，不会固定报告成功。

## Authoring Notes

- 先 dry-run，再根据返回的标准化 `level_package` 确认目标。
- `delete_asset=false` 只从当前 World 移除 streaming level；`delete_asset=true` 还会删除对应关卡资产。

## Parameters

- `level_package`：必填；目标 streaming level package。兼容别名为 `target_level`。
- `dry_run`：默认 `true`；只返回计划，不移除。
- `allow_destructive`：默认 `false`；真实移除必须为 `true`。
- `delete_asset`：默认 `false`；是否继续删除关卡资产。
- `allow_delete`：默认 `false`；仅当 `delete_asset=true` 时必须为 `true`。
- `clear_selection`：默认 `true`。
- `reset_transaction_buffer`：默认 `false`。
- `transaction`：默认 `true`。

## Returns

- `status`：`planned`、`blocked`、`failed`、`partial_failure` 或 `removed`。
- `removed`：`RemoveLevelFromWorld` 实际成功时才为 `true`。
- `deleted_asset_count`：实际删除的关卡资产数量。
- `level_package`、`delete_asset`、`dry_run`、`allow_destructive`、`allow_delete`：本次目标和保护参数读回。
- `error_code`：保护、移除或资产删除失败原因。

## Validation

真实执行后用 `level_streaming_query` 确认该 package 不再出现在当前 World；请求删除资产时再确认资产不存在，并检查 `deleted_asset_count`。
