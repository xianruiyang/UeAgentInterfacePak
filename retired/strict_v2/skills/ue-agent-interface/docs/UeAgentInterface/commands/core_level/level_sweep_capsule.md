---
command: level_sweep_capsule
category: core_level
title: `level_sweep_capsule`
summary: 胶囊 Sweep 通行性检测
aliases: []
tags: [core_level]
status: active
---

# `level_sweep_capsule`

## LLM Compact

- status: active.
- purpose: 胶囊 Sweep 通行性检测
- key_inputs: `end`, `half_height_cm`, `radius_cm`, `start`, `trace_channel`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 若单项未填写 `radius_cm/half_height_cm`，会回退使用顶层同名字段作为默认值。
- note: 同样支持在单项里覆盖：`include_all_hits/max_hits/include_actor_folder_tags/return_penetration_depth`。
- note: 用胶囊做 Sweep 通行性检测（门洞太低、走廊太窄、电梯轨迹被挡等）。
- note: 返回 `blocking_hit`、`start_penetrating`，以及命中信息字段（同 Trace）。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 若单项未填写 `radius_cm/half_height_cm`，会回退使用顶层同名字段作为默认值。
- 同样支持在单项里覆盖：`include_all_hits/max_hits/include_actor_folder_tags/return_penetration_depth`。
- 用胶囊做 Sweep 通行性检测（门洞太低、走廊太窄、电梯轨迹被挡等）。
- 返回 `blocking_hit`、`start_penetrating`，以及命中信息字段（同 Trace）。
- 实战建议：做“净空/通行”验证时，`start/end.z` 建议在地面上方留一点余量（例如 `+5cm`），或设 `find_initial_overlaps=false`，避免“刚好贴地”触发 `start_penetrating` 的误判。
- 当 `start_penetrating=true` 时，会额外返回 `start_penetrating_advice`（包含结构化建议：抬高 Z / 关闭 `find_initial_overlaps` 等）。
- 若需要更强的可解释性（例如生成“阻挡原因报告”），可开 `include_all_hits=true` 并结合 `include_actor_folder_tags=true`。

## Parameters

- `end`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `half_height_cm`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `radius_cm`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `start`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `trace_channel`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
