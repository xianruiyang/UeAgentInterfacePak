---
command: platform_profile_validate_packaging
category: localization_packaging_platform_profiles
title: Platform Profiles
summary: 联合校验 packaging profile、platform 和 device profile
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `platform_profile_validate_packaging`

## LLM Compact

- status: active.
- purpose: 联合校验 packaging profile、platform 和 device profile
- key_inputs: `device_profile`, `packaging_json`, `platform`
- key_returns: `valid`, `issues[]`, `warnings[]`
- behavior: 只读联合校验；packaging 部分使用与 `packaging_validate_profile_json` 相同的 token、路径和环境安全规则。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- platform 必须是简单且 shell-safe 的标识；map 必须是存在的 UE long package name；culture 必须合法且 shell-safe。
- packaging archive 必须位于项目 `Saved/UeAgentInterface/Packages` 根或其后代目录；同时校验 configuration、RunUAT 和可选 DeviceProfile。

## Parameters

- `device_profile`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `packaging_json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `platform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `valid`：校验是否通过。
- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `warnings[]`：warnings 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

检查 `valid/issues/warnings`；任何 packaging 安全 issue 都必须视为阻断项，不能在后续 run 中绕过。
