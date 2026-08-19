---
command: level_snap_to_surface
category: core_level
title: `level_snap_to_surface`
summary: 沿射线吸附 Actor 到命中面
aliases: []
tags: [core_level]
status: active
---

# `level_snap_to_surface`

## LLM Compact

- status: active.
- purpose: 沿射线吸附 Actor 到命中面
- key_inputs: `id`, `start`, `direction`, `offset_cm`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 把某个 Actor 沿射线吸附到命中面（常用于修复：悬空、贴合差、门缝、电梯平台不贴合地面等）。
- note: 返回：`snapped=true/false`，以及命中信息、`previous_location/rotation`、`new_location/rotation`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 把某个 Actor 沿射线吸附到命中面（常用于修复：悬空、贴合差、门缝、电梯平台不贴合地面等）。
- 返回：`snapped=true/false`，以及命中信息、`previous_location/rotation`、`new_location/rotation`。

## Parameters

- `id`：稳定 id，用于精确定位或后续操作。
- `start`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `direction`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `offset_cm`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
