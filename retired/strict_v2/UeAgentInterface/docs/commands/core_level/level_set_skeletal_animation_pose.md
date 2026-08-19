---
command: level_set_skeletal_animation_pose
category: core_level
title: `level_set_skeletal_animation_pose`
summary: 设置场景 Actor 上 SkeletalMeshComponent 到指定 AnimSequence 帧/时间并刷新骨骼
aliases: []
tags: [core_level]
status: active
---

# `level_set_skeletal_animation_pose`

## LLM Compact

- status: active.
- purpose: 设置场景 Actor 上 SkeletalMeshComponent 到指定 AnimSequence 帧/时间并刷新骨骼
- key_inputs: `animation_asset`, `component`, `component_id`, `frame_index`, `frame_rate`, `id`, `save_after_set`, `time_seconds`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `animation_asset`：资产引用；通常传 UE 资产路径。
- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `component_id`：稳定 id，用于精确定位或后续操作。
- `frame_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame_rate`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `id`：稳定 id，用于精确定位或后续操作。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `time_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
