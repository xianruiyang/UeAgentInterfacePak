---
command: level_spawn_wall_with_opening
category: core_level
title: `level_spawn_wall_with_opening`
summary: 生成“带开口的墙”（自动拆成多段网格）
aliases: []
tags: [core_level]
status: active
---

# `level_spawn_wall_with_opening`

## LLM Compact

- status: active.
- purpose: 生成“带开口的墙”（自动拆成多段网格）
- key_inputs: `label_prefix`, `opening_center`, `opening_size`, `plane`, `wall_size`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 用途：一次性生成“墙面矩形 - 开口矩形”的剩余部分（最多 4 段）。典型用来做门洞/通道口，避免手工拆成多段墙时遗漏接口验收导致的“视觉连着但实际被墙封死”。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 用途：一次性生成“墙面矩形 - 开口矩形”的剩余部分（最多 4 段）。典型用来做门洞/通道口，避免手工拆成多段墙时遗漏接口验收导致的“视觉连着但实际被墙封死”。

## Parameters

- `label_prefix`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `opening_center`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `opening_size`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `plane`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `wall_size`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
