---
command: navmesh_build
category: core_level
title: `navmesh_build`
summary: 构建/刷新 NavMesh
aliases: []
tags: [core_level]
status: active
---

# `navmesh_build`

## LLM Compact

- status: active.
- purpose: 构建/刷新 NavMesh
- key_inputs: `timeout_seconds`, `wait_for_finish`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 在 Editor World 触发 `UNavigationSystemV1::Build()`。
- note: 需要关卡内存在有效 `NavMeshBoundsVolume` 才会生成可查询 Nav 数据；否则可能返回成功但 `navmesh_find_path` 仍无法投影/查路。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 在 Editor World 触发 `UNavigationSystemV1::Build()`。
- 需要关卡内存在有效 `NavMeshBoundsVolume` 才会生成可查询 Nav 数据；否则可能返回成功但 `navmesh_find_path` 仍无法投影/查路。

## Parameters

- `timeout_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `wait_for_finish`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
