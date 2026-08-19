---
command: localization_compile_text
category: localization_packaging_platform_profiles
title: Localization
summary: 生成或执行文本资源编译计划
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `localization_compile_text`

## LLM Compact

- status: active.
- purpose: 生成或执行文本资源编译计划
- key_inputs: `target`, `allow_commandlet`, `cultures[]`, `execute`, `timeout_seconds`
- key_returns: `compiled_count`, `locres_files[]`, `status`, `task_id`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `allow_commandlet`：布尔/开关字段；默认值以本命令契约为准。
- `cultures[]`：cultures 列表。
- `execute`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `timeout_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `compiled_count`：数量摘要。
- `locres_files[]`：locres_files 列表摘要；大列表应写入 output/artifact 或 debug。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `task_id`：稳定 id，用于精确定位或后续操作。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
