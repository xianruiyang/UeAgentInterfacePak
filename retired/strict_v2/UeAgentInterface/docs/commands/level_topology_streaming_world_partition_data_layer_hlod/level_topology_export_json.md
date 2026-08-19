---
command: level_topology_export_json
category: level_topology_streaming_world_partition_data_layer_hlod
title: 拓扑编排
summary: 导出当前拓扑快照
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_topology_export_json`

## LLM Compact

- status: active.
- purpose: 导出当前拓扑快照
- key_inputs: `output_file`, `actor_assignment_limit`, `include_actor_assignments`, `include_data_layers`, `include_hlod`, `include_streaming_levels`, `include_world_partition`
- key_returns: `feature_gates`, `schema`, `actor_assignments[]`, `data_layers[]`, `streaming_levels[]`, `world_partition`
- note: 大对象或长列表优先传 `output_file`，authoring 文件使用 HJSON；`.json` 仅是路径别名，会规范化到同名 `.hjson`，不会写出 JSON 文件。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，authoring 文件使用 HJSON；`.json` 输出路径会规范化到同名 `.hjson`，compact 返回只保留摘要、路径和 `output_format`。
- 命令名中的 `json` 是历史 API 名；inline `json`、`topology`、`content`、`json_text` 仍是请求体兼容输入，不代表 authoring 文件格式。

## Parameters

- `output_file`：输出 artifact 路径，文件使用 HJSON authoring 格式；传 `.json` 只会写到同名 `.hjson`，不会同时产生 `.json`。大结果应写文件，不要内联到 compact data。
- `actor_assignment_limit`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_actor_assignments`：布尔/开关字段；默认值以本命令契约为准。
- `include_data_layers`：布尔/开关字段；默认值以本命令契约为准。
- `include_hlod`：布尔/开关字段；默认值以本命令契约为准。
- `include_streaming_levels`：布尔/开关字段；默认值以本命令契约为准。
- `include_world_partition`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `feature_gates`：功能门禁/不可用能力摘要。
- `schema`：返回 payload schema。
- `actor_assignments[]`：actor_assignments 列表摘要；大列表应写入 output/artifact 或 debug。
- `data_layers[]`：data_layers 列表摘要；大列表应写入 output/artifact 或 debug。
- `streaming_levels[]`：streaming_levels 列表摘要；大列表应写入 output/artifact 或 debug。
- `world_partition`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `output_file` / `output_format`：完整导出文件路径与实际落盘格式；传入 `output_file` 时返回。

## Validation

传 `output_file` 时检查返回 `output_file` 的实际后缀为 `.hjson`、`output_format=hjson_authoring`，再用 `level_topology_validate_json` 读取该文件验证可用性。
