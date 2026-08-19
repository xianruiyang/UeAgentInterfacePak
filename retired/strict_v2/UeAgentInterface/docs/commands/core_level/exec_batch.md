---
command: exec_batch
category: core_level
title: Core / Session
summary: 顺序执行多条命令，支持遇错中断
aliases: []
tags: [core_level]
status: active
---

# `exec_batch`

## LLM Compact

- status: active.
- purpose: 顺序执行多条命令，支持遇错中断
- key_inputs: `commands[]`, `stop_on_error`
- key_returns: `executed`, `failed`, `failed_command`, `failed_error`, `failed_index`, `failed_request_id`; compact 视图将完整 `results[]` 外置为 artifact。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- `raw` 视图直接返回完整 `results[]`。
- `llm_compact` 视图保留汇总字段，并将完整 `results[]` 写入 response artifact；调用方需要逐项结果时读取返回的 artifact 描述符，不必切换到 raw 扩大响应。

## Parameters

- `commands[]`：commands 列表。
- `stop_on_error`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `executed` / `failed`：已执行和失败数量。
- `failed_command` / `failed_error` / `failed_index` / `failed_request_id`：首个中断点信息。
- `results[]`：每条子命令的完整结果；`llm_compact` 下通过 artifact 返回。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
