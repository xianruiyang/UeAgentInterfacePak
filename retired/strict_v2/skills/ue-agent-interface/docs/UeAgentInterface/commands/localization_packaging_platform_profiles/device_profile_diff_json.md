---
command: device_profile_diff_json
category: localization_packaging_platform_profiles
title: Platform Profiles
summary: 比较目标 DeviceProfile 与当前配置
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `device_profile_diff_json`

## LLM Compact

- status: active.
- purpose: 比较目标 DeviceProfile 与当前配置
- key_inputs: `json_file`, `json`
- key_returns: `added_cvars[]`, `changed_cvars[]`, `removed_cvars[]`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: diff 前执行与 `device_profile_validate_json` 相同的 INI 注入校验；非法 payload 不生成差异结果。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- `base_profile/device_type` 以及 CVar key/value 中的换行或 `=` 注入会以 `device_profile_validate_failed` 阻断 diff。

## Parameters

- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `added_cvars[]`：added_cvars 列表摘要；大列表应写入 output/artifact 或 debug。
- `changed_cvars[]`：changed_cvars 列表摘要；大列表应写入 output/artifact 或 debug。
- `removed_cvars[]`：removed_cvars 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

先确认 payload 通过校验，再读取 `added_cvars/changed_cvars/removed_cvars`；校验失败不产生写入副作用。
