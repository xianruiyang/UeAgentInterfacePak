---
command: niagara_get_compile_log
category: niagara_system
title: System 属性与编译
summary: 读取编译日志与事件
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_get_compile_log`

## LLM Compact

- status: active.
- purpose: 读取编译日志与事件
- key_inputs: `asset_path` 或 `emitter_asset_path`, `compile_before_read`, `include_events`, `max_events_per_script`, `severity_filter`
- key_returns: `asset_kind`, `asset_path`, `compile_context`, `compilation_complete`, `has_error`, `has_warning`, `error_script_count`, `warning_script_count`, `total_compile_event_count`, `scripts`
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: `compile_before_read` 默认 false；普通读日志不会触发编译。独立 Emitter 显式编译时按 UE 原生规则放入临时 System 上下文，并同步等待上下文编译完成，不会脱离 Emitter 上下文逐个编译 Script。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `emitter_asset_path`：standalone Emitter 的类型化路径别名，与 `asset_path` 二选一；两者通过同一加载、编译和读回实现。
- `compile_before_read`：默认 false；设为 true 才在读取前请求编译。
- `force_compile`：`compile_before_read=true` 时是否强制重新编译，默认 true。
- `wait_for_complete`：System 资产是否等待编译完成，默认 true。独立 Emitter 使用临时 System，因该上下文不能跨请求存活，所以始终同步等待；实际行为读 `wait_for_complete_effective`。
- `refresh_before_compile`：System 资产编译前是否执行结构刷新，默认 true；Emitter 的临时 System 会按 UE 原生流程重建 Emitter 节点。
- `include_events`：布尔/开关字段；默认值以本命令契约为准。
- `max_events_per_script`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `severity_filter`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `asset_kind` / `asset_path` / `object_path`：实际读取的 Niagara 资产类型与规范化路径。
- `compile_context`：`cached_asset_scripts`、`system_asset`、`script_asset` 或 `transient_system_for_emitter`，用于区分事件来自缓存还是哪种真实编译上下文。
- `compilation_requested` / `compilation_complete`：是否发起编译以及该编译是否完成。
- `wait_for_complete`：调用方请求值；`wait_for_complete_supported` 表示目标支持等待；`wait_for_complete_effective` 表示实际是否等待。
- `restored_dirty_state`：只读编译若临时改变了原资产 package dirty 状态，命令是否已恢复调用前状态。
- `has_error` / `has_warning` / `error_script_count` / `warning_script_count`：本次读取上下文中的脚本级汇总。
- `scripts`：按 `include_events` / `severity_filter` / `max_events_per_script` 过滤的逐 Script 状态和事件。独立 Emitter 编译后的 Script 对象属于临时 System，`owner_path` 仍指向原 Emitter，`owner_type` 为 `emitter_transient_system`。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
