---
command: navmesh_project_point
category: core_level
title: `navmesh_project_point`
summary: 单点投影到 NavMesh（只投影不查路）
aliases: []
tags: [core_level]
status: active
---

# `navmesh_project_point`

## LLM Compact

- status: active.
- purpose: 单点投影到 NavMesh（只投影不查路）
- key_inputs: `location`, `point`, `project_query_extent`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 在 Editor World 调用 `UNavigationSystemV1::ProjectPointToNavigation`。
- note: 典型用途：当你怀疑 `navmesh_find_path(project_to_nav=true)` 把点投影到楼梯台阶/上层平台时，用此命令先把“投影落点”结构化输出，避免误判。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 在 Editor World 调用 `UNavigationSystemV1::ProjectPointToNavigation`。
- 典型用途：当你怀疑 `navmesh_find_path(project_to_nav=true)` 把点投影到楼梯台阶/上层平台时，用此命令先把“投影落点”结构化输出，避免误判。

## Parameters

- `location`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `point`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `project_query_extent`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
