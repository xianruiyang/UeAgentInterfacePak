---
command: navmesh_find_path
category: core_level
title: `navmesh_find_path`
summary: NavMesh 两点查路
aliases: []
tags: [core_level]
status: active
---

# `navmesh_find_path`

## LLM Compact

- status: active.
- purpose: NavMesh 两点查路
- key_inputs: `allow_partial`, `end`, `project_to_nav`, `start`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 注意：NavMesh/查路只覆盖“沿可行走面连续移动”的连通（walkable connectivity）。跳跃/电梯/滑索等连通需要额外建模为显式边（建议见 `Plugins/UeAgentInterface/docs/Proposed_WhiteboxValidation_Commands.md`）。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 注意：NavMesh/查路只覆盖“沿可行走面连续移动”的连通（walkable connectivity）。跳跃/电梯/滑索等连通需要额外建模为显式边（建议见 `Plugins/UeAgentInterface/docs/Proposed_WhiteboxValidation_Commands.md`）。

## Parameters

- `allow_partial`：布尔/开关字段；默认值以本命令契约为准。
- `end`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `project_to_nav`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `start`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
