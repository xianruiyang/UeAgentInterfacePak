---
command: data_asset_diff_json
category: data_driven_data_asset_data_table
title: DataAsset / PrimaryDataAsset
summary: 比较 JSON 目标字段与资产当前值
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `data_asset_diff_json`

## LLM Compact

- status: active.
- purpose: 比较 JSON 目标字段与资产当前值
- key_inputs: `asset_path`, `json_file`, `json`
- key_returns: `changed`, `changed_count`, `field_diffs[]`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `changed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `changed_count`：数量摘要。
- `field_diffs[]`：field_diffs 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
