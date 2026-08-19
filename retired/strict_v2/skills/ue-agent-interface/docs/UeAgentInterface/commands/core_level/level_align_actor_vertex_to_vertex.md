---
command: level_align_actor_vertex_to_vertex
category: core_level
title: Level Content authoring 优先级
summary: 按网格顶点把 Actor 对齐到目标顶点
aliases: []
tags: [core_level]
status: active
---

# `level_align_actor_vertex_to_vertex`

## LLM Compact

- status: active.
- purpose: 按网格顶点把 Actor 对齐到目标顶点
- key_inputs: `source_actor_id`, `target_actor_id`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `source_actor_id`：稳定 id，用于精确定位或后续操作。
- `target_actor_id`：稳定 id，用于精确定位或后续操作。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
