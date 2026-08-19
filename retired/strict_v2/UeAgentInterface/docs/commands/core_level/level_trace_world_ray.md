---
command: level_trace_world_ray
category: core_level
title: `level_trace_world_ray`
summary: 世界射线 Trace（不依赖 viewport）
aliases: []
tags: [core_level]
status: active
---

# `level_trace_world_ray`

## LLM Compact

- status: active.
- purpose: 世界射线 Trace（不依赖 viewport）
- key_inputs: `direction`, `start`, `trace_channel`, `trace_distance`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 同样支持在单项里覆盖：`include_all_hits/max_hits/include_actor_folder_tags`。
- note: 返回批量模式时：`mode=batch`，并返回 `rays[]`（每项含 `index/ok/error/hit/...`）以及 `hit_count/error_count/first_error_index` 等汇总字段。
- note: 不依赖 viewport，从任意世界点发起 LineTrace。
- note: 返回 `hit`、命中 `location/normal/distance`，以及 `actor_name/actor_id/component_*` 等。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 同样支持在单项里覆盖：`include_all_hits/max_hits/include_actor_folder_tags`。
- 返回批量模式时：`mode=batch`，并返回 `rays[]`（每项含 `index/ok/error/hit/...`）以及 `hit_count/error_count/first_error_index` 等汇总字段。
- 不依赖 viewport，从任意世界点发起 LineTrace。
- 返回 `hit`、命中 `location/normal/distance`，以及 `actor_name/actor_id/component_*` 等。

## Parameters

- `direction`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `start`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `trace_channel`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `trace_distance`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
