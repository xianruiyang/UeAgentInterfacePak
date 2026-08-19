---
command: data_asset_validate_json
category: data_driven_data_asset_data_table
title: DataAsset / PrimaryDataAsset
summary: 只读验证 JSON 是否可导入
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `data_asset_validate_json`

## LLM Compact

- status: active.
- purpose: 只读验证 JSON 是否可导入
- key_inputs: `asset_path`, `class_path`, `json_file`, `json`, `reference_policy`, `validate_references`
- key_returns: `valid`, `field_results[]`, `issues[]`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 这是只读校验入口；不得把 validate 结果当成已写入状态。
- validation: 检查 `valid/issues/json_issues`；validate 不产生写入副作用。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `class_path`：UE class path；未传时部分命令会按 `kind` 推导。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `reference_policy`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `validate_references`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `valid`：校验是否通过。
- `field_results[]`：field_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

检查 `valid/issues/json_issues`；validate 不产生写入副作用。
