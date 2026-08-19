---
command: localization_gather_text
category: localization_packaging_platform_profiles
title: Localization
summary: 生成或执行 GatherText commandlet 计划
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `localization_gather_text`

## LLM Compact

- status: active.
- purpose: 生成或执行 GatherText commandlet 计划
- key_inputs: `target`, `allow_commandlet`, `execute`, `timeout_seconds`
- key_returns: `commandlet_plan`, `log_file`, `report_file`, `status`, `task_id`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `allow_commandlet`：布尔/开关字段；默认值以本命令契约为准。
- `execute`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `timeout_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `commandlet_plan`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `log_file`：文件路径字段；长 JSON/结果优先走文件。
- `report_file`：文件路径字段；长 JSON/结果优先走文件。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `task_id`：稳定 id，用于精确定位或后续操作。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
