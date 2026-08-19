---
command: blueprint_get_compile_log
category: blueprint
title: 资产与编译
summary: 触发编译并读取编译日志
aliases: []
tags: [blueprint]
status: active
---

# `blueprint_get_compile_log`

## LLM Compact

- status: active.
- purpose: 触发编译并读取编译日志
- key_inputs: `asset_path`, `max_messages`, `save_after_compile`, `severity_filter`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `max_messages`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_compile`：布尔/开关字段；默认值以本命令契约为准。
- `severity_filter`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
