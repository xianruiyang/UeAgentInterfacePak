---
command: hlod_layer_create_json
category: level_topology_streaming_world_partition_data_layer_hlod
title: HLOD
summary: 按 HJSON authoring 创建或更新 HLOD Layer 资产
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `hlod_layer_create_json`

## LLM Compact

- status: active.
- purpose: 按 HJSON authoring 创建或更新 HLOD Layer 资产
- key_inputs: `asset_path`, `json_file`, `json`, `overwrite_policy`, `save_after_apply`
- key_returns: `asset_path`, `layer_type`, `status`
- behavior: `overwrite_policy` 严格为 `fail|replace`，默认 `replace`；文件输入统一为 HJSON。
- validation: 创建后立即用 `hlod_layer_export_json` 读回关键字段。

## Authoring Notes

- `hlod_layer_create_json` 与 apply 使用同一创建/更新契约；命令名中的 `json` 是历史 API 名。
- `json_file`/`input_file` 传入 `.json` 时会规范化为同名 `.hjson` 再读取。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file` / `input_file`：HJSON authoring 文件路径；`.json` 后缀会规范化为 `.hjson`。
- `json` / `topology` / `content`：兼容的 inline object 输入；`json_text` 为兼容的 inline JSON 文本。
- `overwrite_policy`：默认 `replace`；严格枚举 `fail|replace`，未知值返回 `overwrite_policy_invalid`。
- `save_after_apply`：默认 `false`。
- `transaction`：默认 `true`。

## Returns

- `asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `layer_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

成功后用 `hlod_layer_export_json` 读回，并检查文件输入返回的 `source` 已规范化为 `.hjson`。
