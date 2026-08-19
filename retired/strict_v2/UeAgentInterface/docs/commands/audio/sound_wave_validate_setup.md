---
command: sound_wave_validate_setup
category: audio
title: SoundWave
summary: 校验 SoundWave 语义配置
aliases: []
tags: [audio]
status: active
---

# `sound_wave_validate_setup`

## LLM Compact

- status: active.
- purpose: 校验 SoundWave 语义配置
- key_inputs: `asset_path`, `strict`, `expected_attenuation`, `expected_concurrency[]`, `expected_sound_class`
- key_returns: `json_issues[]`, `readonly_info`, `status`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `strict`：严格校验模式。
- `expected_attenuation`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expected_concurrency[]`：expected_concurrency 列表。
- `expected_sound_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `json_issues[]`：json_issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `readonly_info`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
