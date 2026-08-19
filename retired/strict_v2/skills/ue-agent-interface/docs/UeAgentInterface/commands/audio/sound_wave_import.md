---
command: sound_wave_import
category: audio
title: SoundWave
summary: 从音频源文件导入 `USoundWave`
aliases: []
tags: [audio]
status: active
---

# `sound_wave_import`

## LLM Compact

- status: active.
- purpose: 从音频源文件导入 `USoundWave`
- key_inputs: `destination_name`, `destination_path`, `replace_existing`, `save_after_import`, `source_file`
- key_returns: `asset_path`, `channels`, `duration`, `sample_rate`, `source_file`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `destination_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `destination_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `replace_existing`：是否覆盖同路径同名资产；默认 `false`。只有明确允许替换现有资产时才传 `true`。
- `save_after_import`：布尔/开关字段；默认值以本命令契约为准。
- `source_file`：文件路径字段；长 JSON/结果优先走文件。

## Returns

- `asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `channels`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `duration`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sample_rate`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source_file`：文件路径字段；长 JSON/结果优先走文件。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

- 目标资产已存在且未显式传入 `replace_existing=true` 时，返回 `asset_already_exists`，不会覆盖现有资产。
