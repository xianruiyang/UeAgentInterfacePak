---
command: ai_perception_validate_setup
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: AI Perception
summary: 校验 listener/source 基础关系
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `ai_perception_validate_setup`

## LLM Compact

- status: active.
- purpose: 校验 listener/source 基础关系
- key_inputs: `actor`, `blueprint_asset`, `component_name`, `required_senses[]`, `stimuli_sources[]`
- key_returns: `json_issues[]`, `listener`, `status`, `stimuli_sources[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `blueprint_asset`：资产引用；通常传 UE 资产路径。
- `component_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `required_senses[]`：required_senses 列表。
- `stimuli_sources[]`：stimuli_sources 列表。

## Returns

- `json_issues[]`：json_issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `listener`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stimuli_sources[]`：stimuli_sources 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
