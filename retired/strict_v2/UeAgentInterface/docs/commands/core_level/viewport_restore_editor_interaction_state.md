---
command: viewport_restore_editor_interaction_state
category: core_level
title: Level Content authoring 优先级
summary: 恢复 Level Viewport 编辑器交互状态
aliases: []
tags: [core_level]
status: active
---

# `viewport_restore_editor_interaction_state`

## LLM Compact

- status: active.
- purpose: 恢复 Level Viewport 编辑器交互状态
- key_inputs: `selection`, `all_viewports`, `game_view`, `mode_widgets`, `pivot`, `widget_mode`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `selection`：目标选择器；支持的字段由命令定义。
- `all_viewports`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `game_view`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `mode_widgets`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `pivot`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `widget_mode`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
