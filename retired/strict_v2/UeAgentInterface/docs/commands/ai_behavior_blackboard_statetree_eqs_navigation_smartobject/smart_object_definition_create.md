---
command: smart_object_definition_create
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Smart Object Definition
summary: 创建 Definition
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `smart_object_definition_create`

## LLM Compact

- status: active.
- purpose: 创建 Definition
- key_inputs: `asset_path`, `behavior_definitions[]`, `save_after_create`, `slots[]`, `tags[]`
- key_returns: `created_asset`, `slots[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `behavior_definitions[]`：behavior_definitions 列表。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。
- `slots[]`：slots 列表。
- `tags[]`：tags 列表。

## Returns

- `slots[]`：slots 列表摘要；大列表应写入 output/artifact 或 debug。
- `created_asset`：资产操作结果摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
