---
command: sound_cue_get_info
category: audio
title: SoundCue
summary: 读取 SoundCue 图摘要
aliases: []
tags: [audio]
status: active
---

# `sound_cue_get_info`

## LLM Compact

- status: active.
- purpose: 读取 SoundCue 图摘要
- key_inputs: `asset_path`, `include_nodes`, `include_properties`, `include_validation`
- key_returns: `edges[]`, `nodes[]`, `root_node_id`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `include_nodes`：布尔/开关字段；默认值以本命令契约为准。
- `include_properties`：布尔/开关字段；默认值以本命令契约为准。
- `include_validation`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `edges[]`：edges 列表摘要；大列表应写入 output/artifact 或 debug。
- `nodes[]`：nodes 列表摘要；大列表应写入 output/artifact 或 debug。
- `root_node_id`：稳定 id，用于精确定位或后续操作。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
