---
command: ai_perception_get_component_info
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: AI Perception
summary: 读取 Perception listener / stimuli source 组件
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `ai_perception_get_component_info`

## LLM Compact

- status: active.
- purpose: 读取 Perception listener / stimuli source 组件
- key_inputs: `actor`, `component_name`, `include_sense_configs`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `component_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `include_sense_configs`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
