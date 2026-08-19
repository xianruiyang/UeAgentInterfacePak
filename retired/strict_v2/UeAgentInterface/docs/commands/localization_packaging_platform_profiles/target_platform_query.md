---
command: target_platform_query
category: localization_packaging_platform_profiles
title: Platform Profiles
summary: 查询当前引擎 target platform 与 SDK 状态
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `target_platform_query`

## LLM Compact

- status: active.
- purpose: 查询当前引擎 target platform 与 SDK 状态
- key_inputs: `include_sdk`, `include_texture_formats`
- key_returns: `sdk_status[]`, `target_platforms[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_sdk`：布尔/开关字段；默认值以本命令契约为准。
- `include_texture_formats`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `sdk_status[]`：sdk_status 列表摘要；大列表应写入 output/artifact 或 debug。
- `target_platforms[]`：target_platforms 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
