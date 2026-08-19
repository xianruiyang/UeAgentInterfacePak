---
command: level_check_overlaps
category: core_level
title: `level_check_overlaps`
summary: Overlap 检测（碰撞穿插）
aliases: []
tags: [core_level]
status: active
---

# `level_check_overlaps`

## LLM Compact

- status: active.
- purpose: Overlap 检测（碰撞穿插）
- key_inputs: `center`, `shape`, `trace_channel`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 同样支持在单项里覆盖：`include_overlaps/include_actor_folder_tags`。
- note: 返回 `overlap_count` 与 `overlaps[]`（每项包含 actor 摘要与 component 信息）。
- note: 用于发现摆放穿插、互相卡住、门洞/墙体不贴合等问题。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 同样支持在单项里覆盖：`include_overlaps/include_actor_folder_tags`。
- 返回 `overlap_count` 与 `overlaps[]`（每项包含 actor 摘要与 component 信息）。
- 用于发现摆放穿插、互相卡住、门洞/墙体不贴合等问题。

## Parameters

- `center`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `shape`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `trace_channel`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
