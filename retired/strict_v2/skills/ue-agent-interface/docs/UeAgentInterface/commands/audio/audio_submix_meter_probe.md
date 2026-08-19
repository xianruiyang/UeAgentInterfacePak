---
command: audio_submix_meter_probe
category: audio
title: 场景与运行时验证
summary: 采样 Submix meter
aliases: []
tags: [audio]
status: active
---

# `audio_submix_meter_probe`

## LLM Compact

- status: active.
- purpose: 采样 Submix meter
- key_inputs: `duration`, `expected_min_peak`, `frequencies[]`, `submix`
- key_returns: `peak_by_channel[]`, `spectrum[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `duration`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expected_min_peak`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frequencies[]`：frequencies 列表。
- `submix`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `peak_by_channel[]`：peak_by_channel 列表摘要；大列表应写入 output/artifact 或 debug。
- `spectrum[]`：spectrum 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
