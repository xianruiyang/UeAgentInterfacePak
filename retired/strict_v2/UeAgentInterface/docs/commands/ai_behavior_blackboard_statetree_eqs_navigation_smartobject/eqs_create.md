---
command: eqs_create
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: EQS
summary: 创建 `UEnvQuery`
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `eqs_create`

## LLM Compact

- status: active.
- purpose: 创建 `UEnvQuery`
- key_inputs: `asset_path`, `save_after_create`, `template`
- key_returns: `created_asset`, `options[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。
- `template`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `options[]`：options 列表摘要；大列表应写入 output/artifact 或 debug。
- `created_asset`：资产操作结果摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
