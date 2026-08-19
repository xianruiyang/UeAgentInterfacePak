---
command: viewport_select_actor_at_screen
category: core_level
title: `viewport_select_actor_at_screen`
summary: viewport_select_actor_at_screen command contract.
aliases: []
tags: [core_level]
status: active
---

# `viewport_select_actor_at_screen`

## LLM Compact

- status: active.
- purpose: viewport_select_actor_at_screen command contract.
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 其它 Trace 参数与 `viewport_pick_actor_at_screen` 相同。
- note: 会先从屏幕点拾取 Actor。
- note: 成功后按 `selection_mode` 更新编辑器当前选择集。
- note: 返回命中 Actor 摘要、完整 `actor_info`、命中信息，以及更新后的选择集。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 其它 Trace 参数与 `viewport_pick_actor_at_screen` 相同。
- 会先从屏幕点拾取 Actor。
- 成功后按 `selection_mode` 更新编辑器当前选择集。
- 返回命中 Actor 摘要、完整 `actor_info`、命中信息，以及更新后的选择集。
- 若 `allow_no_hit=true` 且未命中，则不会修改选择集，只返回当前选择集（同时 `hit=false`）。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
