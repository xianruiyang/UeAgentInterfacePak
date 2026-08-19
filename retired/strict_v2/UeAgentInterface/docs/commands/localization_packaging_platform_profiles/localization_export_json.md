---
command: localization_export_json
category: localization_packaging_platform_profiles
title: Localization
summary: 导出本地化拓扑 JSON
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `localization_export_json`

## LLM Compact

- status: active.
- purpose: 导出本地化拓扑 JSON
- key_inputs: `output_file`, `target`, `include_entries`, `include_word_count`
- key_returns: `schema=uai.localization.v1`, `string_tables[]`, `targets[]`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。

## Parameters

- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `include_entries`：布尔/开关字段；默认值以本命令契约为准。
- `include_word_count`：数量摘要。

## Returns

- `schema=uai.localization.v1`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `string_tables[]`：string_tables 列表摘要；大列表应写入 output/artifact 或 debug。
- `targets[]`：targets 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
