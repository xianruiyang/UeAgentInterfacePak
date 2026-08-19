---
command: ml_deformer_get_training_log
category: deformer_mldeformer_geometry_cache
title: ML Deformer
summary: 读取训练日志尾部
aliases: []
tags: [deformer_mldeformer_geometry_cache]
status: active
---

# `ml_deformer_get_training_log`

## LLM Compact

- status: active.
- purpose: 读取训练日志尾部
- key_inputs: `log_file`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `log_file`：文件路径字段；长 JSON/结果优先走文件。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
