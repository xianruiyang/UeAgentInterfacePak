---
command: niagara_get_stack_issues
category: niagara_system
title: `niagara_get_stack_issues`
summary: 读取 Niagara Stack 红/黄/信息提示
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_get_stack_issues`

## LLM Compact

- status: active.
- purpose: 读取 Niagara Stack 红/黄/信息提示
- key_inputs: `asset_path`, `open_editor_if_needed`, `severity_filter`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 编译字段：`compile_before_read`、`force_compile`、`wait_for_complete`、`compilation_requested`、`compilation_complete`、`has_outstanding_compilation_requests`
- note: Emitter scope 额外包含 `emitter_latest_compile_status`、`emitter_handle_error_text`、`emitter_handle_error_color`、`emitter_handle_error_visibility`，用于区分 Stack issue 图标和 emitter 编译/状态提示
- note: System scope 额外包含 `system_latest_compile_status`
- note: `compile_before_read` 与 `open_editor_if_needed` 均默认 false；需要编译刷新或 UI-only/live Stack 状态时必须显式授权。
- note: 该命令是状态只读操作；即使 `compile_before_read=true` 或内部创建临时 ViewModel，也会恢复目标包调用前的 dirty 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- 编译字段：`compile_before_read`、`force_compile`、`wait_for_complete`、`compilation_requested`、`compilation_complete`、`has_outstanding_compilation_requests`
- Emitter scope 额外包含 `emitter_latest_compile_status`、`emitter_handle_error_text`、`emitter_handle_error_color`、`emitter_handle_error_visibility`，用于区分 Stack issue 图标和 emitter 编译/状态提示
- System scope 额外包含 `system_latest_compile_status`
- 要尽量匹配 UI 里鼠标悬停看到的红色感叹号文本，建议使用 `prefer_existing_view_model=true` 且 `open_editor_if_needed=true`。
- 未打开编辑器时命令会退回 data-processing ViewModel；这能读取部分 issue，但可能漏掉 UI-only / live Stack 状态。
- 命令结束后目标 Niagara System/Emitter 包的 dirty 状态与调用前一致；读取 Stack issue 不会制造额外保存决策。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `compile_before_read`：默认 false；设为 true 才在读取前请求编译。
- `open_editor_if_needed`：默认 false；设为 true 才允许打开 Niagara 编辑器。
- `severity_filter`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
