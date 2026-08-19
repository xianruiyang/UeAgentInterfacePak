---
command: metasound_compile
category: audio
title: MetaSound
summary: 编译 MetaSound
aliases: []
tags: [audio]
status: active
---

# `metasound_compile`

## LLM Compact

- status: active.
- purpose: 编译 MetaSound
- key_inputs: `asset_path`, `include_messages`, `save_after_compile`
- key_returns: `error_count`, `messages[]`, `warning_count`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `include_messages`：布尔/开关字段；默认值以本命令契约为准。
- `save_after_compile`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `error_count`：数量摘要。
- `messages[]`：messages 列表摘要；大列表应写入 output/artifact 或 debug。
- `warning_count`：数量摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
