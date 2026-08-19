---
command: localization_diff_json
category: localization_packaging_platform_profiles
title: Localization
summary: 比较目标 JSON 与当前发现状态
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `localization_diff_json`

## LLM Compact

- status: active.
- purpose: 比较目标 JSON 与当前发现状态
- key_inputs: `json_file`, `json`
- key_returns: `changed`, `diff_count`, `diffs[]`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `changed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `diff_count`：数量摘要。
- `diffs[]`：diffs 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
