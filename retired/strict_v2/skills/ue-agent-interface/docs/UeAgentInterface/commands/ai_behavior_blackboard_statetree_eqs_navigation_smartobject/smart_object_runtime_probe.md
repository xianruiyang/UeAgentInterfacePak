---
command: smart_object_runtime_probe
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Smart Object Runtime / Setup
summary: find/claim/release 一体探针
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `smart_object_runtime_probe`

## LLM Compact

- status: active.
- purpose: find/claim/release 一体探针
- key_inputs: `agent`, `expect_claimable`, `expect_reachable`, `query_bounds`
- key_returns: `claim_result`, `cleanup_results[]`, `find_result`, `navigation_result`, `probe_passed`, `release_result`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `agent`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expect_claimable`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expect_reachable`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `query_bounds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `claim_result`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `cleanup_results[]`：cleanup_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `find_result`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `navigation_result`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `probe_passed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `release_result`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
