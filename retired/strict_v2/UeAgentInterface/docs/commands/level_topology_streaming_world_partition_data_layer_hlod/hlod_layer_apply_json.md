---
command: hlod_layer_apply_json
category: level_topology_streaming_world_partition_data_layer_hlod
title: HLOD
summary: 按 HJSON authoring 创建或回写 HLOD Layer
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `hlod_layer_apply_json`

## LLM Compact

- status: active.
- purpose: 按 HJSON authoring 创建或回写 HLOD Layer
- key_inputs: `asset_path`, `json_file`, `json`, `overwrite_policy`, `save_after_apply`
- key_returns: `property_results[]`, `status`
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: HJSON authoring 新增内容时先最小 authoring -> apply -> export readback -> patch 必要字段 -> 再 apply 验证。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- `json_file`/`input_file` 传入 `.json` 时会规范化为同名 `.hjson` 再读取；命令名中的 `json` 仅是历史 API 名。
- `overwrite_policy` 严格为 `fail|replace`，默认 `replace`；未知值返回 `overwrite_policy_invalid`。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file` / `input_file`：HJSON authoring 文件路径；`.json` 后缀会规范化为 `.hjson`。
- `json` / `topology` / `content`：兼容的 inline object 输入；`json_text` 为兼容的 inline JSON 文本。
- `overwrite_policy`：默认 `replace`；严格枚举 `fail|replace`。
- `save_after_apply`：默认 `false`。
- `transaction`：默认 `true`。

## Returns

- `property_results[]`：property_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

apply 后立刻用 `hlod_layer_export_json` 读回，比较资产路径、layer type、cell size、loading range、parent layer 和 class 属性；文件输入还应检查返回 `source` 为规范化后的 `.hjson` 路径。
