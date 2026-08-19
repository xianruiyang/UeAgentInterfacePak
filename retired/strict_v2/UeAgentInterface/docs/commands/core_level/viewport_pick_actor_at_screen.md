---
command: viewport_pick_actor_at_screen
category: core_level
title: `viewport_pick_actor_at_screen`
summary: viewport_pick_actor_at_screen command contract.
aliases: []
tags: [core_level]
status: active
---

# `viewport_pick_actor_at_screen`

## LLM Compact

- status: active.
- purpose: viewport_pick_actor_at_screen command contract.
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 先把屏幕点反投影成世界射线，再做一次直线 Trace。
- note: 成功时会返回命中 Actor 摘要、Component 名称与路径，以及命中位置、法线、距离等信息。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 先把屏幕点反投影成世界射线，再做一次直线 Trace。
- 成功时会返回命中 Actor 摘要、Component 名称与路径，以及命中位置、法线、距离等信息。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
