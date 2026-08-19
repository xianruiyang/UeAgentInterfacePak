---
command: ml_deformer_train
category: deformer_mldeformer_geometry_cache
title: ML Deformer
summary: 显式训练入口状态/保护
aliases: []
tags: [deformer_mldeformer_geometry_cache]
status: active
---

# `ml_deformer_train`

## LLM Compact

- status: active.
- purpose: 显式训练入口状态/保护
- key_inputs: `confirm_long_running_training`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `confirm_long_running_training`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
