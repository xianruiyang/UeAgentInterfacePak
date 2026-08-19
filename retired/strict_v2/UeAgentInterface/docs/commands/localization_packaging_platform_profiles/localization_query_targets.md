---
command: localization_query_targets
category: localization_packaging_platform_profiles
title: Localization
summary: 查询 Localization target、culture、manifest/archive/locres/PO 文件
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `localization_query_targets`

## LLM Compact

- status: active.
- purpose: 查询 Localization target、culture、manifest/archive/locres/PO 文件
- key_inputs: `include_files`, `include_stats`
- key_returns: `config_root`, `content_root`, `target_count`, `targets[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_files`：布尔/开关字段；默认值以本命令契约为准。
- `include_stats`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `config_root`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `content_root`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_count`：数量摘要。
- `targets[]`：targets 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
