---
command: enhanced_input_export_mapping_context_json
category: static_mesh_enhanced_input
title: EnhancedInput
summary: 导出 `InputMappingContext` 单文件 JSON
aliases: []
tags: [static_mesh_enhanced_input]
status: active
---

# `enhanced_input_export_mapping_context_json`

## LLM Compact

- status: active.
- purpose: 导出 `InputMappingContext` 单文件 JSON
- key_inputs: `asset_path`, `output_file`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 必填：`asset_path`
- note: 可选：`output_file`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 必填：`asset_path`
- 可选：`output_file`
- 返回固定字段和 `mappings[]` 当前值，不再附加重复的 `authoring_fields[]` metadata。
- `mappings[]` 项以 `index` 定位，并直接包含 `key`、`action_path`、`modifier_classes[]` 与 `trigger_classes[]`。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
