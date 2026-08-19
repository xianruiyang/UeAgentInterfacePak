---
command: device_profile_resolve_cvars
category: localization_packaging_platform_profiles
title: Platform Profiles
summary: 解析 profile 继承后的最终 CVar
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `device_profile_resolve_cvars`

## LLM Compact

- status: active.
- purpose: 解析 profile 继承后的最终 CVar
- key_inputs: `include_sources`, `keys[]`, `profile`
- key_returns: `conflicts[]`, `inheritance_chain[]`, `resolved_cvars[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_sources`：布尔/开关字段；默认值以本命令契约为准。
- `keys[]`：keys 列表。
- `profile`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `conflicts[]`：conflicts 列表摘要；大列表应写入 output/artifact 或 debug。
- `inheritance_chain[]`：inheritance_chain 列表摘要；大列表应写入 output/artifact 或 debug。
- `resolved_cvars[]`：resolved_cvars 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
