---
command: sequence_get_level_sequence_info
category: sequence
title: Level Sequence
summary: 读取序列摘要
aliases: []
tags: [sequence]
status: active
---

# `sequence_get_level_sequence_info`

## LLM Compact

- status: active.
- purpose: 读取序列摘要
- key_inputs: `asset_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 每个 key 需要 `control` 或 `control_name`，并需要 `time_seconds` 或 `frame`。`frame` 使用序列 display rate。
- note: 支持的 control 类型：`float/scale_float`、`bool`、`integer/enum`、`vector2d`、`position`、`scale`、`rotator`、`transform/euler_transform/transform_no_scale`。
- note: 当前 apply 会把多个 `sections[]` 的 key 合并到一个 Control Rig section，并返回 warning；需要多 section 精确语义时应先小步验证。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 每个 key 需要 `control` 或 `control_name`，并需要 `time_seconds` 或 `frame`。`frame` 使用序列 display rate。
- 支持的 control 类型：`float/scale_float`、`bool`、`integer/enum`、`vector2d`、`position`、`scale`、`rotator`、`transform/euler_transform/transform_no_scale`。
- 当前 apply 会把多个 `sections[]` 的 key 合并到一个 Control Rig section，并返回 warning；需要多 section 精确语义时应先小步验证。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
