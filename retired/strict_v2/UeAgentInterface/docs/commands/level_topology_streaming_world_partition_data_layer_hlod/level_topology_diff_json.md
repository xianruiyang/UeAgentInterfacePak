---
command: level_topology_diff_json
category: level_topology_streaming_world_partition_data_layer_hlod
title: 拓扑编排
summary: 比较 HJSON 拓扑与当前场景
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_topology_diff_json`

## LLM Compact

- status: active.
- purpose: 比较 HJSON 拓扑与当前场景
- key_inputs: `json_file|input_file`, `json|topology|content|json_text`
- key_returns: `changed`, `diff_count`, `diffs[]`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 只读比较，不修改 UE 状态。命令名中的 `json` 是历史 API 名。
- `json_file`/`input_file` 传 `.json` 时规范化为同名 `.hjson` 再读取。

## Parameters

- `json_file` / `input_file`：HJSON authoring 文件路径；`.json` 后缀会规范化为 `.hjson`。
- `json` / `topology` / `content`：兼容的 inline object 输入；`json_text` 为兼容的 inline JSON 文本。

## Returns

- `changed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `diff_count`：数量摘要。
- `diffs[]`：diffs 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

检查 `changed`、`diff_count`、`diffs[]` 和 `source`；文件输入时 `source` 应为规范化后的 `.hjson` 路径。
