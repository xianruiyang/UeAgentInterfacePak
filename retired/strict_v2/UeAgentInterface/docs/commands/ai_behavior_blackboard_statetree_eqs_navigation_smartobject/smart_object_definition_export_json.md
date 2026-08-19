---
command: smart_object_definition_export_json
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Smart Object Definition
summary: 导出单文件 JSON
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `smart_object_definition_export_json`

## LLM Compact

- status: active.
- purpose: 导出单文件 JSON
- key_inputs: `asset_path`, `output_file`, `include_validation`
- key_returns: `coverage_report`, `output_file`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `include_validation`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `coverage_report`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `output_file`：文件路径字段；长 JSON/结果优先走文件。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
