---
command: blackboard_create
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Blackboard
summary: 创建 `UBlackboardData`
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `blackboard_create`

## LLM Compact

- status: active.
- purpose: 创建 `UBlackboardData`
- key_inputs: `asset_path`, `keys[]`, `parent_blackboard`, `save_after_create`
- key_returns: `saved`, `created_asset`, `dirty`, `keys[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `keys[]`：keys 列表。
- `parent_blackboard`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `saved`：是否保存资源或关卡。
- `dirty`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `keys[]`：keys 列表摘要；大列表应写入 output/artifact 或 debug。
- `created_asset`：资产操作结果摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
