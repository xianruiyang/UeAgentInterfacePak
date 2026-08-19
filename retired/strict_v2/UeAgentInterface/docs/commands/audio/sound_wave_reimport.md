---
command: sound_wave_reimport
category: audio
title: SoundWave
summary: 重导入已有 SoundWave
aliases: []
tags: [audio]
status: active
---

# `sound_wave_reimport`

## LLM Compact

- status: active.
- purpose: 重导入已有 SoundWave
- key_inputs: `allow_reimport`, `asset_path`, `save_after_reimport`, `source_file`
- key_returns: `duration_after`, `duration_before`, `reimported`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `allow_reimport`：破坏性操作确认开关；默认 `false`。执行重导入必须显式传入 `true`。
- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `save_after_reimport`：布尔/开关字段；默认值以本命令契约为准。
- `source_file`：文件路径字段；长 JSON/结果优先走文件。

## Returns

- `duration_after`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `duration_before`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `reimported`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

- 未显式传入 `allow_reimport=true` 时，返回 `allow_reimport_required`，不会读取或修改目标资产。
