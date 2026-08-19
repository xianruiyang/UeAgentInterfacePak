---
command: pcg_inspection_set
category: pcg
title: 指令列表
summary: 开关并可清空 Inspection
aliases: []
tags: [pcg]
status: active
---

# `pcg_inspection_set`

## LLM Compact

- status: active.
- purpose: 开关并可清空 Inspection
- key_inputs: `actor`, `clear`, `component`, `enabled`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `clear`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `enabled`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
