---
command: device_profile_export_json
category: localization_packaging_platform_profiles
title: Platform Profiles
summary: 导出 DeviceProfile JSON
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `device_profile_export_json`

## LLM Compact

- status: active.
- purpose: 导出 DeviceProfile JSON
- key_inputs: `output_file`, `include_inherited`, `profile`
- key_returns: `profiles[]`, `schema=uai.device_profile.v1`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- `profiles[]` 项带 selector/availability/operations 等 authoring metadata。
- `source_file` 仅作为只读来源信息；默认编辑应通过 profile name 和 cvar 字段表达。

## Parameters

- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `include_inherited`：布尔/开关字段；默认值以本命令契约为准。
- `profile`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `profiles[]`：profiles 列表摘要；大列表应写入 output/artifact 或 debug。
- `schema=uai.device_profile.v1`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
