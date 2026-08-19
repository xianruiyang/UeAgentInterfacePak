---
command: navigation_path_probe
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Navigation
summary: 批量路径探针
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `navigation_path_probe`

## LLM Compact

- status: active.
- purpose: 批量路径探针
- key_inputs: `accept_partial_path`, `start`, `end`, `targets[]`
- key_returns: `all_paths_found`, `results[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `accept_partial_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `start`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `end`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `targets[]`：targets 列表。

## Returns

- `all_paths_found`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `results[]`：results 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
