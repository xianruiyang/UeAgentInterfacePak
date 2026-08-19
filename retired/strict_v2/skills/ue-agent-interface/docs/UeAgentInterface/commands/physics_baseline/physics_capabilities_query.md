---
command: physics_capabilities_query
category: physics_baseline
title: 指令总览
summary: 查询基础物理可用性、碰撞 profile/channel、项目物理设置摘要和排除的可选插件
aliases: []
tags: [physics_baseline]
status: active
---

# `physics_capabilities_query`

## LLM Compact

- status: active.
- purpose: 查询基础物理可用性、碰撞 profile/channel、项目物理设置摘要和排除的可选插件
- key_inputs: `include_collision_profiles`, `include_optional_plugin_status`, `include_project_settings`
- key_returns: `available_classes[]`, `baseline_physics_available`, `collision_profiles[]`, `excluded_optional_plugins[]`, `physics_settings_summary`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `include_collision_profiles`：布尔/开关字段；默认值以本命令契约为准。
- `include_optional_plugin_status`：布尔/开关字段；默认值以本命令契约为准。
- `include_project_settings`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `available_classes[]`：available_classes 列表摘要；大列表应写入 output/artifact 或 debug。
- `baseline_physics_available`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `collision_profiles[]`：collision_profiles 列表摘要；大列表应写入 output/artifact 或 debug。
- `excluded_optional_plugins[]`：excluded_optional_plugins 列表摘要；大列表应写入 output/artifact 或 debug。
- `physics_settings_summary`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
