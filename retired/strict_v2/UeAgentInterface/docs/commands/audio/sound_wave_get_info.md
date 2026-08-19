---
command: sound_wave_get_info
category: audio
title: SoundWave
summary: 读取 SoundWave 摘要
aliases: []
tags: [audio]
status: active
---

# `sound_wave_get_info`

## LLM Compact

- status: active.
- purpose: 读取 SoundWave 摘要
- key_inputs: `asset_path`, `include_analysis`, `include_cue_points`, `include_properties`
- key_returns: `channels`, `duration`, `loading_behavior`, `sample_rate`, `sound_class`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `include_analysis`：布尔/开关字段；默认值以本命令契约为准。
- `include_cue_points`：布尔/开关字段；默认值以本命令契约为准。
- `include_properties`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `channels`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `duration`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `loading_behavior`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sample_rate`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sound_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
