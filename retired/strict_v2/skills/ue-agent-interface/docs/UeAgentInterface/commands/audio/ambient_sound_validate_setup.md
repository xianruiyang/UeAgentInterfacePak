---
command: ambient_sound_validate_setup
category: audio
title: 场景与运行时验证
summary: 校验 `AAmbientSound`
aliases: []
tags: [audio]
status: active
---

# `ambient_sound_validate_setup`

## LLM Compact

- status: active.
- purpose: 校验 `AAmbientSound`
- key_inputs: `actor`, `expected_sound`
- key_returns: `json_issues[]`, `status`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `expected_sound`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `json_issues[]`：json_issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
