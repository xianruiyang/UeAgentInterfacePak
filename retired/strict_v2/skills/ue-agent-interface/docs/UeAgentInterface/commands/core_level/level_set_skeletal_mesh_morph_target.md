---
command: level_set_skeletal_mesh_morph_target
category: core_level
title: `level_set_skeletal_mesh_morph_target`
summary: 设置场景 Actor 上 SkeletalMeshComponent 的 Morph Target 权重，可选启动平滑 pulse
aliases: []
tags: [core_level]
status: active
---

# `level_set_skeletal_mesh_morph_target`

## LLM Compact

- status: active.
- purpose: 设置场景 Actor 上 SkeletalMeshComponent 的 Morph Target 权重，可选启动平滑 pulse
- key_inputs: `clear_existing`, `component`, `component_id`, `id`, `morph_target`, `pulse`, `skeletal_mesh`, `stop_pulse` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `clear_existing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `component_id`：稳定 id，用于精确定位或后续操作。
- `id`：稳定 id，用于精确定位或后续操作。
- `morph_target`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `pulse`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `skeletal_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stop_pulse`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `weight`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
