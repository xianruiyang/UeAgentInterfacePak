---
command: hlod_layer_export_json
category: level_topology_streaming_world_partition_data_layer_hlod
title: HLOD
summary: 导出 HLOD Layer HJSON authoring
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `hlod_layer_export_json`

## LLM Compact

- status: active.
- purpose: 导出 HLOD Layer HJSON authoring
- key_inputs: `asset_path`, `output_file`
- key_returns: `cell_size`, `layer_type`, `loading_range`, `parent_layer`
- note: `output_file` 统一写 HJSON；`.json` 仅是路径别名，会规范化到同名 `.hjson`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 命令名中的 `json` 是历史 API 名；authoring 输出始终使用 HJSON。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：HJSON authoring 输出路径；传 `.json` 会规范化写到同名 `.hjson`，不会同时产生 `.json`。

## Returns

- `cell_size`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `layer_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `loading_range`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `parent_layer`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `output_file` / `output_format`：传入输出路径时返回实际 `.hjson` 路径和 `hjson_authoring`。

## Validation

检查导出字段；传 `output_file` 时确认返回路径后缀为 `.hjson`、`output_format=hjson_authoring`，并用 `hlod_layer_validate_json` 读取该文件。
