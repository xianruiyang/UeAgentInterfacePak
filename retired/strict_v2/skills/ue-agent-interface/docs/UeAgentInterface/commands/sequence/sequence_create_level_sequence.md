---
command: sequence_create_level_sequence
category: sequence
title: Level Sequence
summary: 创建关卡序列
aliases: []
tags: [sequence]
status: active
---

# `sequence_create_level_sequence`

## LLM Compact

- status: active.
- purpose: 创建关卡序列
- key_inputs: `asset_path`, `allow_editor_open`, `display_rate_den`, `display_rate_num`, `duration_seconds`, `open_editor`, `start_seconds`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `allow_editor_open`：布尔/开关字段；默认值以本命令契约为准。
- `display_rate_den`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `display_rate_num`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `duration_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `open_editor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `start_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
