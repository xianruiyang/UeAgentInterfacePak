---
command: metasound_get_info
category: audio
title: MetaSound
summary: 读取 MetaSound 摘要
aliases: []
tags: [audio]
status: active
---

# `metasound_get_info`

## LLM Compact

- status: active.
- purpose: 读取 MetaSound 摘要
- key_inputs: `asset_path`, `include_graph`, `include_interfaces`, `include_validation`
- key_returns: `compile_report`, `inputs[]`, `nodes[]`, `outputs[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `include_graph`：布尔/开关字段；默认值以本命令契约为准。
- `include_interfaces`：布尔/开关字段；默认值以本命令契约为准。
- `include_validation`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `compile_report`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `inputs[]`：inputs 列表摘要；大列表应写入 output/artifact 或 debug。
- `nodes[]`：nodes 列表摘要；大列表应写入 output/artifact 或 debug。
- `outputs[]`：outputs 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
