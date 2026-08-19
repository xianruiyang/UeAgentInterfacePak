---
command: editor_resolve_dirty_resources
category: core_level
title: `editor_resolve_dirty_resources`
summary: 按路径或整批保存/丢弃脏资源
aliases: []
tags: [core_level]
status: active
---

# `editor_resolve_dirty_resources`

## LLM Compact

- status: active.
- purpose: 按路径或整批保存/丢弃脏资源
- key_inputs: `close_all_asset_editors`, `discard_all_dirty`, `discard_resource_paths`, `only_save_dirty`, `save_all_dirty`, `save_resource_paths`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 兼容旧字段：`save_asset_paths` / `discard_asset_paths`。
- note: 兼容别名：`save_resources` / `discard_resources`
- note: 兼容别名：`save_all` / `discard_all`
- note: 只处理脏资源，不会直接关闭编辑器。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 兼容旧字段：`save_asset_paths` / `discard_asset_paths`。
- 兼容别名：`save_resources` / `discard_resources`
- 兼容别名：`save_all` / `discard_all`
- 只处理脏资源，不会直接关闭编辑器。
- 返回处理前后 `dirty_resources_before / dirty_resources_after`。
- 若还有未处理的脏资源，会通过 `remaining_dirty_resource_count` 显式告诉调用方。

## Parameters

- `close_all_asset_editors`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `discard_all_dirty`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `discard_resource_paths`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `only_save_dirty`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_all_dirty`：布尔/开关字段；默认值以本命令契约为准。
- `save_resource_paths`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
