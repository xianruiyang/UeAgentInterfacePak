---
command: hlod_layer_validate_json
category: level_topology_streaming_world_partition_data_layer_hlod
title: HLOD
summary: 校验 HLOD Layer HJSON authoring
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `hlod_layer_validate_json`

## LLM Compact

- status: active.
- purpose: 校验 HLOD Layer HJSON authoring
- key_inputs: `json_file|input_file`, `json|topology|content|json_text`
- key_returns: `status`, `error_count`, `issues[]`, `asset_path`, `source`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 这是只读校验入口；不得把 validate 结果当成已写入状态。
- validation: 检查 `valid/issues/json_issues`；validate 不产生写入副作用。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。
- `json_file`/`input_file` 传 `.json` 时规范化为同名 `.hjson` 再读取；命令名中的 `json` 是历史 API 名。

## Parameters

- `json_file` / `input_file`：HJSON authoring 文件路径；`.json` 后缀会规范化为 `.hjson`。
- `json` / `topology` / `content`：兼容的 inline object 输入；`json_text` 为兼容的 inline JSON 文本。

## Returns

- `status`：`valid` 或 `invalid`。
- `error_count`：error issue 数量。
- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `asset_path`、`source`：规范化资产路径和输入来源。

## Validation

检查 `status`、`error_count`、`issues[]`；validate 不产生写入副作用。文件输入时同时确认 `source` 为规范化后的 `.hjson` 路径。
