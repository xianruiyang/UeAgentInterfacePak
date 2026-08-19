---
command: packaging_export_profile_json
category: localization_packaging_platform_profiles
title: Packaging
summary: 导出 transient BuildCookRun profile
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_export_profile_json`

## LLM Compact

- status: active.
- purpose: 导出 transient BuildCookRun profile
- key_inputs: `output_file`, `configuration`, `include_project_settings`, `platform`
- key_returns: `pipeline`, `schema=uai.packaging.v1`, `settings_refs[]`, `target`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- packaging `target`、`pipeline`、`content`、`output`、`options` section 带 selector/availability/operations 等 authoring metadata。
- 默认 authoring 不依赖 report/debug 字段；构建报告通过 packaging report/task 命令读取。

## Parameters

- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `configuration`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_project_settings`：布尔/开关字段；默认值以本命令契约为准。
- `platform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `pipeline`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `schema=uai.packaging.v1`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `settings_refs[]`：settings_refs 列表摘要；大列表应写入 output/artifact 或 debug。
- `target`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
