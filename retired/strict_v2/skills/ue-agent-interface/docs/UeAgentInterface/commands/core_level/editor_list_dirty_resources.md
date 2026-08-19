---
command: editor_list_dirty_resources
category: core_level
title: `editor_list_dirty_resources`
summary: 列出当前所有待处理的脏资源
aliases: []
tags: [core_level]
status: active
---

# `editor_list_dirty_resources`

## LLM Compact

- status: active.
- purpose: 列出当前所有待处理的脏资源
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 无参数。
- note: 返回当前编辑器里所有待处理的脏包资源。
- note: 当前关卡
- note: 其它关卡
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 无参数。
- 返回当前编辑器里所有待处理的脏包资源。
- 当前关卡
- 其它关卡
- 普通资产
- 返回项包含 `resource_path`、`object_path`、`kind`、`is_current_level`、`is_open_in_editor` 等字段。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
