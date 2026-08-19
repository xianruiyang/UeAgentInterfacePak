---
command: niagara_apply_stack_issue_fix
category: niagara_system
title: `niagara_apply_stack_issue_fix`
summary: 应用 Stack issue 提供的修复项
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_apply_stack_issue_fix`

## LLM Compact

- status: active.
- purpose: 应用 Stack issue 提供的修复项
- key_inputs: `asset_path`, `fix_index`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: issue selector：可用 `issue_unique_identifier`、`module_node_guid`、`entry_path`、`scope_type`、`scope_name`、`emitter_name`、`emitter_id`、`emitter_index` 等字段缩小匹配范围。
- note: 执行 fix 后会调用 System refresh：同步 overview、重算 emitter execution order、失效 cached traversal data，并通知 Niagara ViewModel。
- note: `open_editor_if_needed` 默认 false；命令不会为了查找或应用 fix 隐式打开 Niagara 编辑器。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- issue selector：可用 `issue_unique_identifier`、`module_node_guid`、`entry_path`、`scope_type`、`scope_name`、`emitter_name`、`emitter_id`、`emitter_index` 等字段缩小匹配范围。
- 执行 fix 后会调用 System refresh：同步 overview、重算 emitter execution order、失效 cached traversal data，并通知 Niagara ViewModel。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `fix_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `open_editor_if_needed`：默认 false；设为 true 才允许打开 Niagara 编辑器以访问 UI-only Stack fix。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
