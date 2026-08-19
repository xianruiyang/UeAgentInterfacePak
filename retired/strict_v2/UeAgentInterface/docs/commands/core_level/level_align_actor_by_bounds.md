---
command: level_align_actor_by_bounds
category: core_level
title: `level_align_actor_by_bounds`
summary: level_align_actor_by_bounds command contract.
aliases: []
tags: [core_level]
status: active
---

# `level_align_actor_by_bounds`

## LLM Compact

- status: active.
- purpose: level_align_actor_by_bounds command contract.
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 相比 `level_align_actor_vertex_to_vertex`，`level_align_actor_by_bounds` 更适合白盒建筑和模块化关卡拼装。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 相比 `level_align_actor_vertex_to_vertex`，`level_align_actor_by_bounds` 更适合白盒建筑和模块化关卡拼装。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
