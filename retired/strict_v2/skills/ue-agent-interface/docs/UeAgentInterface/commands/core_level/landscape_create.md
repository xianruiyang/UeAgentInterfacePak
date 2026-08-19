---
command: landscape_create
category: core_level
title: Landscape
summary: 在当前关卡创建 Landscape
aliases: []
tags: [core_level]
status: active
---

# `landscape_create`

## LLM Compact

- status: active.
- purpose: 在当前关卡创建 Landscape
- key_inputs: `component_count_x`, `component_count_y`, `location`, `quads_per_section`, `scale`, `sections_per_component`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `component_count_x`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `component_count_y`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `location`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `quads_per_section`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `scale`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sections_per_component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
