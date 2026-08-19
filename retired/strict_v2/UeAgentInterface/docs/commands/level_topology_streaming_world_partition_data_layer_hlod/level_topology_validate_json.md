---
command: level_topology_validate_json
category: level_topology_streaming_world_partition_data_layer_hlod
title: 拓扑编排
summary: 校验 HJSON 拓扑的可执行性
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_topology_validate_json`

## LLM Compact

- status: active.
- purpose: 校验 HJSON 拓扑的可执行性
- key_inputs: `json_file|input_file`, `json|topology|content|json_text`
- key_returns: `status`, `error_count`, `issues[]`, `source`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 至少包含 `streaming_levels`、`data_layers`、`actor_assignments`、`world_partition`、`hlod`、`tasks` 之一；空拓扑失败。
- validation: 检查 `valid/issues/json_issues`；validate 不产生写入副作用。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。
- `json_file`/`input_file` 传 `.json` 时规范化为同名 `.hjson` 再读取；命令名中的 `json` 是历史 API 名。
- streaming operation、DataLayer operation 和 `membership_mode` 均按严格枚举校验，未知值进入 `issues[]` 并使 `valid=false`。

## Parameters

- `json_file` / `input_file`：HJSON authoring 文件路径；`.json` 后缀会规范化为 `.hjson`。
- `json` / `topology` / `content`：兼容的 inline object 输入；`json_text` 为兼容的 inline JSON 文本。
- `membership_mode`：在 `data_layers[]` item 中严格为 `add|remove|replace|clear`。
- 空对象或不含任何 actionable domain 的输入返回 `missing_validation_expectation`。

## Returns

- `status`：`valid` 或 `invalid`。
- `error_count`：error issue 数量。
- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `source`：inline key 或规范化后的 `.hjson` 文件路径。

## Validation

检查 `status`、`error_count`、`issues[]` 和 `source`；validate 不产生写入副作用。
