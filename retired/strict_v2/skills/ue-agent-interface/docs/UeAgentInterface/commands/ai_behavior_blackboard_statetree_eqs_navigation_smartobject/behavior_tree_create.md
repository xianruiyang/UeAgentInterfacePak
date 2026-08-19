---
command: behavior_tree_create
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Behavior Tree
summary: 创建最小 BT
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `behavior_tree_create`

## LLM Compact

- status: active.
- purpose: 创建最小 BT
- key_inputs: `asset_path`, `blackboard_asset`, `root_composite`, `save_after_create`
- key_returns: `created_asset`, `nodes[]`, `root_id`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `blackboard_asset`：资产引用；通常传 UE 资产路径。
- `root_composite`：根对象或根节点配置。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `nodes[]`：nodes 列表摘要；大列表应写入 output/artifact 或 debug。
- `created_asset`：资产操作结果摘要。
- `root_id`：根节点 id。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
