---
command: audio_submix_record_start
category: audio
title: 场景与运行时验证
summary: 开始 Submix 录制
aliases: []
tags: [audio]
status: active
---

# `audio_submix_record_start`

## LLM Compact

- status: active.
- purpose: 开始 Submix 录制
- key_inputs: `name`, `session_id`, `expected_duration`, `path`, `recording_id`, `submix`
- key_returns: `session_id`, `recording_id`, `started`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `name`：对象名称；创建时应保持稳定，避免同名歧义。
- `session_id`：编辑 session id；后续 add/remove/apply 必须使用同一 session。
- `expected_duration`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `path`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `recording_id`：稳定 id，用于精确定位或后续操作。
- `submix`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `session_id`：可继续使用的 session id。
- `recording_id`：稳定 id，用于精确定位或后续操作。
- `started`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
