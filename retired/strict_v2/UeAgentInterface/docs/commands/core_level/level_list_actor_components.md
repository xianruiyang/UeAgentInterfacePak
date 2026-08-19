---
command: level_list_actor_components
category: core_level
title: Level Content authoring 优先级
summary: `actor_list_components` 的同义命令
aliases: []
tags: [core_level]
status: active
---

# `level_list_actor_components`

## LLM Compact

- status: active.
- purpose: `actor_list_components` 的同义命令
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: `level_*`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- `level_*`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
