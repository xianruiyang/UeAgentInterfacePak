---
command: editor_prepare_exit
category: core_level
title: `editor_prepare_exit`
summary: 退出前按策略保存/丢弃并请求关闭编辑器
aliases: []
tags: [core_level]
status: active
---

# `editor_prepare_exit`

## LLM Compact

- status: active.
- purpose: 退出前按策略保存/丢弃并请求关闭编辑器
- key_inputs: `save_current_level`, `save_all_dirty`, `save_asset_paths`, `discard_current_level`, `discard_all_dirty`, `discard_asset_paths`, `allow_discard`, `close_all_asset_editors`, `close_world_browser_tabs`, `unload_late_shutdown_editor_modules`, `request_exit`, `allow_exit`
- key_returns: `saved_package_count`, `explicit_discarded_package_count`, `auto_discarded_package_count`, `remaining_dirty_resource_count`, `dirty_resources[]`, `request_exit`, `allow_exit`, `allow_discard`
- note: 所有保存、丢弃、关闭窗口和退出动作默认均为 `false`；空参数不会丢弃 dirty 状态或请求退出。
- note: 任一丢弃请求必须显式 `allow_discard=true`；退出请求必须显式 `allow_exit=true`。确认缺失时在任何保存、丢弃或退出副作用前失败。
- note: 若清理后仍存在 dirty 资源，会返回失败 `editor_has_unresolved_dirty_resources`，不会请求退出。
- note: 返回 `remaining_dirty_resource_count`、`closed_world_browser_tab_count`、`unloaded_late_shutdown_editor_module_count`、`unloaded_late_shutdown_editor_modules[]`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 该命令用于编译、发布或自动化结束前按显式策略保存/丢弃，再按显式开关关闭窗口或请求退出。
- 默认不保存、不丢弃、不关闭窗口、不卸载模块、不退出。
- `discard_current_level=true`、`discard_all_dirty=true` / `discard_all=true`，或非空 `discard_asset_paths` 均要求 `allow_discard=true`。
- `request_exit=true` 要求 `allow_exit=true`；两类确认都必须是 JSON boolean。
- 若清理后仍存在 dirty 资源，会返回失败 `editor_has_unresolved_dirty_resources`，不会请求退出。
- 返回 `remaining_dirty_resource_count`、`closed_world_browser_tab_count`、`unloaded_late_shutdown_editor_module_count`、`unloaded_late_shutdown_editor_modules[]`。

## Parameters

- `save_current_level`、`save_all_dirty` / `save_all`：默认 `false`。
- `save_asset_paths`：显式保存的资产路径列表；保存不需要 `allow_discard`。
- `discard_current_level`、`discard_all_dirty` / `discard_all`：默认 `false`；启用时要求 `allow_discard=true`。
- `discard_asset_paths`：显式丢弃 dirty 状态的资产路径列表；非空时要求 `allow_discard=true`。
- `allow_discard`：默认 `false`；确认允许清除 dirty 标记。
- `close_all_asset_editors`、`close_world_browser_tabs`、`unload_late_shutdown_editor_modules`：默认 `false`。
- `request_exit`：默认 `false`；启用时要求 `allow_exit=true`。
- `allow_exit`：默认 `false`；确认允许安排 Editor 退出。
- `only_save_dirty`：默认 `true`。

## Returns

- `saved_package_count`、`explicit_discarded_package_count`、`auto_discarded_package_count`。
- `remaining_dirty_resource_count` / `dirty_resources[]`。
- `request_exit` / `allow_exit` / `allow_discard`。
- `save_asset_not_found[]` / `discard_asset_not_found[]` 及窗口、模块清理计数。

## Validation

丢弃被阻断时确认 discarded 计数未增加；退出前确认 `remaining_dirty_resource_count=0`。缺少 `allow_exit` 或 `allow_discard` 时命令在副作用前失败。
