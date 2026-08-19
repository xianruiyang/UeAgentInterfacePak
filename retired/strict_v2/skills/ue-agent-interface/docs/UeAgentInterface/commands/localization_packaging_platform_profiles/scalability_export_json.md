---
command: scalability_export_json
category: localization_packaging_platform_profiles
title: Platform Profiles
summary: 导出 Scalability group 配置
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `scalability_export_json`

## LLM Compact

- status: active.
- purpose: 导出 Scalability group 配置
- key_inputs: `output_file`, `platform`
- key_returns: `group_count`, `groups[]`, `quality_levels[]`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- scalability group/section 带 selector/availability/operations 等 authoring metadata。
- 默认 authoring 不依赖 report/debug 字段；apply 仍消费既有 group/value 字段。

## Parameters

- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `platform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `group_count`：数量摘要。
- `groups[]`：groups 列表摘要；大列表应写入 output/artifact 或 debug。
- `quality_levels[]`：quality_levels 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
