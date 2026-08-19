---
command: audio_submix_record_cancel
category: audio
title: 场景与运行时验证
summary: 停止录制并丢弃导出文件
aliases: []
tags: [audio]
status: active
---

# `audio_submix_record_cancel`

## LLM Compact

- status: active.
- purpose: 停止录制并丢弃导出文件
- key_inputs: `session_id`, `recording_id`
- key_returns: `canceled`, `deleted_file_count`, `elapsed`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `session_id`：编辑 session id；后续 add/remove/apply 必须使用同一 session。
- `recording_id`：稳定 id，用于精确定位或后续操作。

## Returns

- `canceled`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `deleted_file_count`：删除对象摘要。
- `elapsed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
