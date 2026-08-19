---
command: viewport_set_realtime
category: core_level
title: Level Content authoring 优先级
summary: 切换视口实时刷新
aliases: []
tags: [core_level]
status: active
---

# `viewport_set_realtime`

## LLM Compact

- status: active.
- purpose: 切换视口实时刷新
- key_inputs: `enabled`, `realtime`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `enabled`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `realtime`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
