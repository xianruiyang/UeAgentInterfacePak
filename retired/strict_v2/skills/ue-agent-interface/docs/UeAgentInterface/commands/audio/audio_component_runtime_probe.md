---
command: audio_component_runtime_probe
category: audio
title: 场景与运行时验证
summary: 播放/采样已有组件
aliases: []
tags: [audio]
status: active
---

# `audio_component_runtime_probe`

## LLM Compact

- status: active.
- purpose: 播放/采样已有组件
- key_inputs: `actor`, `component_name`, `duration`, `expected_min_peak`
- key_returns: `cleanup_results[]`, `peak_envelope`, `probe_passed`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `component_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `duration`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expected_min_peak`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `cleanup_results[]`：cleanup_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `peak_envelope`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `probe_passed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
