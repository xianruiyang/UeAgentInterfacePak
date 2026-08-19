---
command: umg_list_widget_events
category: umg
title: 资产与编译
summary: 查询某个 Widget 可绑定的 BlueprintAssignable 事件
aliases: []
tags: [umg]
status: active
---

# `umg_list_widget_events`

## LLM Compact

- status: active.
- purpose: 查询某个 Widget 可绑定的 BlueprintAssignable 事件
- key_inputs: `asset_path`, `compile_before_query`, `include_hidden`, `limit`, `only_unbound`, `query`, `widget_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `compile_before_query`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_hidden`：布尔/开关字段；默认值以本命令契约为准。
- `limit`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `only_unbound`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `query`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `widget_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
