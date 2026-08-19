---
command: device_profile_query
category: localization_packaging_platform_profiles
title: Platform Profiles
summary: 查询 DeviceProfile、继承链和 CVar
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `device_profile_query`

## LLM Compact

- status: active.
- purpose: 查询 DeviceProfile、继承链和 CVar
- key_inputs: `include_inherited`, `profile`
- key_returns: `cvars`, `inheritance_chain[]`, `profiles[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_inherited`：布尔/开关字段；默认值以本命令契约为准。
- `profile`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `cvars`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `inheritance_chain[]`：inheritance_chain 列表摘要；大列表应写入 output/artifact 或 debug。
- `profiles[]`：profiles 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
