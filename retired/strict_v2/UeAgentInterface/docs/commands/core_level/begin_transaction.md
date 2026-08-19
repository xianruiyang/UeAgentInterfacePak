---
command: begin_transaction
category: core_level
title: Core / Session
summary: 开启 UE 事务
aliases: []
tags: [core_level]
status: active
---

# `begin_transaction`

## LLM Compact

- status: active.
- purpose: 开启 UE 事务
- key_inputs: `label`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `label`：新建或目标 Actor 的 editor label。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
