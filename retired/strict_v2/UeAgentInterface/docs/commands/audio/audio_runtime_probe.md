---
command: audio_runtime_probe
category: audio
title: 场景与运行时验证
summary: 临时播放指定 `USoundBase` 并采样
aliases: []
tags: [audio]
status: active
---

# `audio_runtime_probe`

## LLM Compact

- status: active.
- purpose: 临时播放指定 `USoundBase` 并采样
- key_inputs: `cleanup`, `duration`, `expected_min_peak`, `location`, `sound`
- key_returns: `peak_envelope`, `probe_passed`, `started`, `stopped`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `cleanup`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `duration`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expected_min_peak`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `location`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sound`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `peak_envelope`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `probe_passed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `started`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stopped`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
