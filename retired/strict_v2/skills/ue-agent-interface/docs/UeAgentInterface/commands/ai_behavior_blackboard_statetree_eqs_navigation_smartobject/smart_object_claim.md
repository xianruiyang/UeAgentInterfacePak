---
command: smart_object_claim
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Smart Object Runtime / Setup
summary: claim 查询结果
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `smart_object_claim`

## LLM Compact

- status: active.
- purpose: claim 查询结果
- key_inputs: `result_id`
- key_returns: `claim_handle`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `result_id`：稳定 id，用于精确定位或后续操作。

## Returns

- `claim_handle`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
