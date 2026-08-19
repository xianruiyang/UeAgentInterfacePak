---
command: string_table_validate_json
category: localization_packaging_platform_profiles
title: String Table
summary: 校验 key/source/metadata 和重复 key
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `string_table_validate_json`

## LLM Compact

- status: active.
- purpose: 校验 key/source/metadata 和重复 key
- key_inputs: `json_file`, `json`
- key_returns: `valid`, `error_count`, `issues[]`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 这是只读校验入口；不得把 validate 结果当成已写入状态。
- validation: 检查 `valid/issues/json_issues`；validate 不产生写入副作用。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。

## Parameters

- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `valid`：校验是否通过。
- `error_count`：数量摘要。
- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

检查 `valid/issues/json_issues`；validate 不产生写入副作用。
