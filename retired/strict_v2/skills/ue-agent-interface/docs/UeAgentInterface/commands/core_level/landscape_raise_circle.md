---
command: landscape_raise_circle
category: core_level
title: Landscape
summary: 抬高圆形区域
aliases: []
tags: [core_level]
status: active
---

# `landscape_raise_circle`

## LLM Compact

- status: active.
- purpose: 抬高圆形区域
- key_inputs: `center`, `falloff`, `radius_cm`, `strength_cm`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `center`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `falloff`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `radius_cm`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `strength_cm`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
