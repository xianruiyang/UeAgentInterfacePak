---
command: platform_config_export_json
category: localization_packaging_platform_profiles
title: Platform Profiles
summary: 导出平台 config 合并摘要
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `platform_config_export_json`

## LLM Compact

- status: active.
- purpose: 导出平台 config 合并摘要
- key_inputs: `output_file`, `include_sources`, `platform`, `sections[]`
- key_returns: `merged_values{}`, `source_files[]`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。

## Parameters

- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `include_sources`：布尔/开关字段；默认值以本命令契约为准。
- `platform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sections[]`：sections 列表。

## Returns

- `merged_values{}`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source_files[]`：source_files 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
