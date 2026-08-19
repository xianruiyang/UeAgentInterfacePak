---
command: editor_close
category: core_level
title: `editor_close`
summary: 关闭编辑器；若仍有未处理脏资源则失败并返回清单
aliases: []
tags: [core_level]
status: active
---

# `editor_close`

## LLM Compact

- status: active.
- purpose: 关闭编辑器；若仍有未处理脏资源则失败并返回清单
- key_inputs: `close_all_asset_editors`, `close_world_browser_tabs`, `unload_late_shutdown_editor_modules`, `request_exit`, `allow_exit`, `exit_delay_seconds`
- key_returns: `request_exit`, `allow_exit`, `close_requested`, `closed`, `dirty_resource_count`, `dirty_resources[]`, `closed_world_browser_tab_count`, `unloaded_late_shutdown_editor_module_count`
- note: 该命令不会替调用方做保存/丢弃判断。
- note: 若仍存在未处理脏资源，会返回失败 `editor_has_unresolved_dirty_resources`，并在 `data.dirty_resources` 中给出完整清单。
- note: 默认 `request_exit=false`，且关闭资产编辑器、关闭 World Browser tab、卸载模块也都默认 `false`；空参数请求不会退出或关闭窗口。
- note: 请求退出必须同时显式传 `request_exit=true` 和 `allow_exit=true`，否则返回 `allow_exit_required`，不会安排退出。
- note: 即使退出已确认，仍只有在脏资源全部处理完后才会允许关闭编辑器。
- note: 返回 `closed_world_browser_tab_count`、`unloaded_late_shutdown_editor_module_count`、`unloaded_late_shutdown_editor_modules[]`，用于确认退出前清理是否执行。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 该命令不会替调用方做保存/丢弃判断。
- 若仍存在未处理脏资源，会返回失败 `editor_has_unresolved_dirty_resources`，并在 `data.dirty_resources` 中给出完整清单。
- 默认不退出、不关闭资产编辑器、不关闭 World Browser tab，也不卸载模块。
- `allow_exit=true` 只是退出确认，不会自行触发退出；必须与 `request_exit=true` 同时使用。
- 只有当脏资源全部处理完后，才会允许关闭编辑器。
- 返回 `closed_world_browser_tab_count`、`unloaded_late_shutdown_editor_module_count`、`unloaded_late_shutdown_editor_modules[]`，用于确认退出前清理是否执行。

## Parameters

- `close_all_asset_editors`：默认 `false`。
- `close_world_browser_tabs`：默认 `false`。
- `request_exit`：默认 `false`；为 `true` 时要求 `allow_exit=true`。
- `allow_exit`：默认 `false`；必须是 JSON boolean，类型错误返回 `invalid_allow_exit`。
- `unload_late_shutdown_editor_modules`：默认 `false`，只在已确认的退出请求中执行。
- `exit_delay_seconds`：退出请求延迟，限制为 `0..10` 秒。

## Returns

- `request_exit` / `allow_exit` / `close_requested` / `closed`。
- `dirty_resource_count` / `dirty_resources[]`。
- `closed_world_browser_tab_count`、`unloaded_late_shutdown_editor_module_count`、`unloaded_late_shutdown_editor_modules[]`。

## Validation

未显式确认退出时应确认 `request_exit=false`、`close_requested=false`、`closed=false`。退出前必须先确认 `dirty_resource_count=0`；`editor_has_unresolved_dirty_resources` 表示未安排退出。
