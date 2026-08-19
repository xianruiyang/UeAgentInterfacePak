---
command: audio_runtime_snapshot
category: audio
title: 场景与运行时验证
summary: 聚合 Audio Device、active sounds、components
aliases: []
tags: [audio]
status: active
---

# `audio_runtime_snapshot`

## LLM Compact

- status: active.
- purpose: 聚合 Audio Device、active sounds、components
- key_inputs: `include_active_sounds`, `include_components`, `include_submixes`
- key_returns: `active_sound_count`, `audio_device_available`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_active_sounds`：布尔/开关字段；默认值以本命令契约为准。
- `include_components`：布尔/开关字段；默认值以本命令契约为准。
- `include_submixes`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `active_sound_count`：数量摘要。
- `audio_device_available`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
