---
command: ai_perception_runtime_snapshot
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: AI Perception
summary: 当前感知状态快照
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `ai_perception_runtime_snapshot`

## LLM Compact

- status: active.
- purpose: 当前感知状态快照
- key_inputs: `actor`, `controller`, `include_stimuli`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `controller`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_stimuli`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
