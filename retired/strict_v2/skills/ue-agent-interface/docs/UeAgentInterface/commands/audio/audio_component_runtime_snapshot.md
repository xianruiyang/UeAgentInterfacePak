---
command: audio_component_runtime_snapshot
category: audio
title: 场景与运行时验证
summary: 读取 AudioComponent 播放状态
aliases: []
tags: [audio]
status: active
---

# `audio_component_runtime_snapshot`

## LLM Compact

- status: active.
- purpose: 读取 AudioComponent 播放状态
- key_inputs: `actor`, `component_name`
- key_returns: `is_playing`, `sound`, `volume_multiplier`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `component_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- `is_playing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sound`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `volume_multiplier`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
