---
command: metasound_preview
category: audio
title: MetaSound
summary: 预览并设置输入参数
aliases: []
tags: [audio]
status: active
---

# `metasound_preview`

## LLM Compact

- status: active.
- purpose: 预览并设置输入参数
- key_inputs: `asset_path`, `duration`, `expected_min_peak`, `inputs{}`
- key_returns: `peak_envelope`, `probe_passed`, `started`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `duration`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expected_min_peak`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `inputs{}`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `peak_envelope`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `probe_passed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `started`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
