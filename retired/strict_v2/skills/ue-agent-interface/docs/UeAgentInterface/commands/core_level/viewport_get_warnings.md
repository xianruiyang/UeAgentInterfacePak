---
command: viewport_get_warnings
category: core_level
title: `viewport_get_warnings`
summary: 读取当前 Level Viewport renderer warning/probe
aliases: []
tags: [core_level]
status: active
---

# `viewport_get_warnings`

## LLM Compact

- status: active.
- purpose: 读取当前 Level Viewport renderer warning/probe
- key_inputs: `include_suppressed`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 返回 `display_gates`：包含 `screen_messages_enabled`、`map_warnings_suppressed`、`display_gate_open`。
- note: 返回 `renderer_probe`：包含检测条件，例如 `r.AllowGlobalClipPlane`、`planar_reflection_count`、`active_directional_light_count`、`highest_forward_shading_priority`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 返回 `display_gates`：包含 `screen_messages_enabled`、`map_warnings_suppressed`、`display_gate_open`。
- 返回 `renderer_probe`：包含检测条件，例如 `r.AllowGlobalClipPlane`、`planar_reflection_count`、`active_directional_light_count`、`highest_forward_shading_priority`。

## Parameters

- `include_suppressed`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
