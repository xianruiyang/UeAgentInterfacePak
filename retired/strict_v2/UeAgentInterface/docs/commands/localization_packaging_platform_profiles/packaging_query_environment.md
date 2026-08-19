---
command: packaging_query_environment
category: localization_packaging_platform_profiles
title: Packaging
summary: 查询 UAT、UnrealEditor-Cmd、UnrealPak、target platform 和 SDK 状态
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_query_environment`

## LLM Compact

- status: active.
- purpose: 查询 UAT、UnrealEditor-Cmd、UnrealPak、target platform 和 SDK 状态
- key_inputs: `include_sdks`, `include_tools`
- key_returns: `target_platforms[]`, `tools[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_sdks`：布尔/开关字段；默认值以本命令契约为准。
- `include_tools`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `target_platforms[]`：target_platforms 列表摘要；大列表应写入 output/artifact 或 debug。
- `tools[]`：tools 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
