---
command: anim_sequence_get_info
category: animation_assets_skeleton
title: `anim_sequence_get_info`
summary: 读取 AnimSequence 资产摘要
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_get_info`

## LLM Compact

- status: active.
- purpose: 读取 AnimSequence 资产摘要
- key_inputs: `asset_path`, `include_curve_keys`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `include_curve_keys`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
