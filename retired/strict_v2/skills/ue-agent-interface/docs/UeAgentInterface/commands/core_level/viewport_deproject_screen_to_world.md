---
command: viewport_deproject_screen_to_world
category: core_level
title: Level Content authoring 优先级
summary: 屏幕坐标反投影到世界射线
aliases: []
tags: [core_level]
status: active
---

# `viewport_deproject_screen_to_world`

## LLM Compact

- status: active.
- purpose: 屏幕坐标反投影到世界射线
- key_inputs: `screen_x`, `screen_y`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `screen_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `screen_y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
