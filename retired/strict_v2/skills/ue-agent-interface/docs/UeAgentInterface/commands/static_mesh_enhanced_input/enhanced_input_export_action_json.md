---
command: enhanced_input_export_action_json
category: static_mesh_enhanced_input
title: EnhancedInput
summary: 导出 `InputAction` 单文件 JSON
aliases: []
tags: [static_mesh_enhanced_input]
status: active
---

# `enhanced_input_export_action_json`

## LLM Compact

- status: active.
- purpose: 导出 `InputAction` 单文件 JSON
- key_inputs: `asset_path`, `output_file`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 必填：`asset_path`
- note: 可选：`output_file`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 必填：`asset_path`
- 可选：`output_file`
- 返回 action 的固定 authoring 字段和当前值，不再附加一份重复的 `authoring_fields[]` metadata。
- 修改时直接编辑 `value_type`、`consume_input`、`trigger_when_paused`、`reserve_all_mappings`、`modifier_classes[]` 和 `trigger_classes[]`。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
