---
command: audio_submix_record_stop
category: audio
title: 场景与运行时验证
summary: 停止录制并导出
aliases: []
tags: [audio]
status: active
---

# `audio_submix_record_stop`

## LLM Compact

- status: active.
- purpose: 停止录制并导出
- key_inputs: `session_id`, `recording_id`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `session_id`：编辑 session id；后续 add/remove/apply 必须使用同一 session。
- `recording_id`：稳定 id，用于精确定位或后续操作。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
