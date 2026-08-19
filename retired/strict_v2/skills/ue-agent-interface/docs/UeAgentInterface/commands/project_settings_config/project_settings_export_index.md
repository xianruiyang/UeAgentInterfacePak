---
command: project_settings_export_index
category: project_settings_config
title: Project Settings
summary: 反射当前所有 Settings container/category/section 并导出目录索引
aliases: []
tags: [project_settings_config]
status: active
---

# `project_settings_export_index`

## LLM Compact

- status: active.
- purpose: 反射当前所有 Settings container/category/section 并导出目录索引
- key_inputs: `container`, `include_developer_sections`, `include_field_counts`, `include_plugin_sections`, `include_readonly_sections`, `include_unsupported_sections`, `output_directory`, `output_path` ...
- key_returns: `schema`, `filters{}`, `index_file`, `manifest.entries[]`, `manifest_file`, `plugin_fingerprint`, `plugin_fingerprint_hash`, `section_count` ...
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `container`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_developer_sections`：布尔/开关字段；默认值以本命令契约为准。
- `include_field_counts`：布尔/开关字段；默认值以本命令契约为准。
- `include_plugin_sections`：布尔/开关字段；默认值以本命令契约为准。
- `include_readonly_sections`：布尔/开关字段；默认值以本命令契约为准。
- `include_unsupported_sections`：布尔/开关字段；默认值以本命令契约为准。
- `output_directory`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `output_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `write_files`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `schema`：返回 payload schema。
- `filters{}`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `index_file`：文件路径字段；长 JSON/结果优先走文件。
- `manifest.entries[]`：manifest.entries 列表摘要；大列表应写入 output/artifact 或 debug。
- `manifest_file`：文件路径字段；长 JSON/结果优先走文件。
- `plugin_fingerprint`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `plugin_fingerprint_hash`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `section_count`：数量摘要。
- `sections[]`：sections 列表摘要；大列表应写入 output/artifact 或 debug。
- `settings_registry_hash`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `summary`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
