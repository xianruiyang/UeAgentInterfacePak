---
command: viewport_get_editor_interaction_state
category: core_level
title: Level Content authoring 优先级
summary: 读取 Level Viewport 编辑器交互状态
aliases: []
tags: [core_level]
status: active
---

# `viewport_get_editor_interaction_state`

## LLM Compact

- status: active.
- purpose: 读取 Level Viewport 编辑器交互状态
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
