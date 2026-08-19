---
command: sequence_list_level_sequences
category: sequence
title: Level Sequence
summary: 列出序列资产
aliases: []
tags: [sequence]
status: active
---

# `sequence_list_level_sequences`

## LLM Compact

- status: active.
- purpose: 列出序列资产
- key_inputs: `limit`, `root_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `limit`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `root_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
