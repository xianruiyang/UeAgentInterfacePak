---
command: level_set_selection
category: core_level
title: Level Content authoring 优先级
summary: 设置选择集
aliases: []
tags: [core_level]
status: active
---

# `level_set_selection`

## LLM Compact

- status: active.
- purpose: 设置选择集
- key_inputs: `mode`, `actor_ids`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `mode`：命令模式；具体枚举以本命令契约为准。
- `actor_ids`：稳定 id 列表。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
