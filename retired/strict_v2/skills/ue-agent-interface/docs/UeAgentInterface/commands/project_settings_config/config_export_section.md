---
command: config_export_section
category: project_settings_config
title: Config Fallback
summary: 导出受限项目 `.ini` 的 section
aliases: []
tags: [project_settings_config]
status: active
---

# `config_export_section`

## LLM Compact

- status: active.
- purpose: 导出受限项目 `.ini` 的 section
- key_inputs: `output_file`, `config_file`, `output_path`, `section`
- key_returns: `schema`, `entries[]`, `entry_count`, `section_value_hash`, `source=config_file_fallback`, `source_path`, `values{}`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `config_file`：文件路径字段；长 JSON/结果优先走文件。
- `output_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `section`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `schema`：返回 payload schema。
- `entries[]`：entries 列表摘要；大列表应写入 output/artifact 或 debug。
- `entry_count`：数量摘要。
- `section_value_hash`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source=config_file_fallback`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `values{}`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
