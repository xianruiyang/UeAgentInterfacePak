---
command: data_layer_apply_asset_json
category: level_topology_streaming_world_partition_data_layer_hlod
title: DataLayer
summary: 按 HJSON authoring 创建或更新 DataLayerAsset
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `data_layer_apply_asset_json`

## LLM Compact

- status: active.
- purpose: 按 HJSON authoring 创建或更新 DataLayerAsset
- key_inputs: `asset_path`, `json_file|input_file`, `json|topology|content|json_text`, `overwrite_policy`, `save_after_apply`, `transaction`
- key_returns: `source` 及 `data_layer_create_asset` 的资产读回字段
- behavior: `overwrite_policy` 严格为 `fail|replace`，默认 `replace`；文件输入统一为 HJSON。
- validation: apply 后用 `data_layer_query` 或资产读回比较目标字段。

## Authoring Notes

- 命令名中的 `json` 是历史 API 名，不代表 authoring 文件仍使用 JSON。
- `json_file`/`input_file` 传入 `.json` 时会先规范化为同名 `.hjson` 再读取；不会读取原 `.json` 文件。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file` / `input_file`：HJSON authoring 文件路径；`.json` 后缀会规范化为 `.hjson`。
- `json` / `topology` / `content`：兼容的 inline object 输入。
- `json_text`：兼容的 inline JSON 文本输入；不改变文件格式为 HJSON 的约定。
- `overwrite_policy`：默认 `replace`；严格枚举 `fail|replace`，未知值返回 `overwrite_policy_invalid`。
- `save_after_apply`：默认 `false`。
- `transaction`：默认 `true`。

## Returns

- 返回 `data_layer_create_asset` 的资产结构字段，并附带实际 `source`；文件输入时 `source` 为规范化后的 `.hjson` 路径。

## Validation

apply 后用 `data_layer_query` 或资产读回比较 `asset_path`、类型和属性；文件输入同时检查 `source` 已规范化为 `.hjson`。
