---
command: navigation_export_config_json
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Navigation
summary: 导出导航配置摘要
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `navigation_export_config_json`

## LLM Compact

- status: active.
- purpose: 导出导航配置摘要
- key_inputs: `output_file`
- key_returns: `output_file`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。

## Returns

- `output_file`：文件路径字段；长 JSON/结果优先走文件。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
