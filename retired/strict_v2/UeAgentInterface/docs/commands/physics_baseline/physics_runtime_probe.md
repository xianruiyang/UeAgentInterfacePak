---
command: physics_runtime_probe
category: physics_baseline
title: 指令总览
summary: 在 editor world 中短时间推进物理，采样速度/位移并可恢复
aliases: []
tags: [physics_baseline]
status: active
---

# `physics_runtime_probe`

## LLM Compact

- status: active.
- purpose: 在 editor world 中短时间推进物理，采样速度/位移并可恢复
- key_inputs: `cleanup`, `duration_seconds`, `expect[]`, `fixed_delta_seconds`, `targets[]`
- key_returns: `expectation_results[]`, `expectations_passed`, `restored`, `samples[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `cleanup`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `duration_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expect[]`：expect 列表。
- `fixed_delta_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `targets[]`：targets 列表。

## Returns

- `expectation_results[]`：expectation_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `expectations_passed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `restored`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `samples[]`：samples 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
