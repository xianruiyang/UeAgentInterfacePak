---
command: ml_deformer_validate_training_inputs
category: deformer_mldeformer_geometry_cache
title: ML Deformer
summary: 校验训练输入资产、骨架、拓扑和时长一致性
aliases: []
tags: [deformer_mldeformer_geometry_cache]
status: active
---

# `ml_deformer_validate_training_inputs`

## LLM Compact

- status: active.
- purpose: 校验训练输入资产、骨架、拓扑和时长一致性
- key_inputs: `deformer_graph`, `duration_tolerance_seconds`, `skeletal_mesh`, `strict_duration_match`, `target_geometry_cache`, `training_anim_sequence`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `deformer_graph`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `duration_tolerance_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `skeletal_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `strict_duration_match`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_geometry_cache`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `training_anim_sequence`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
