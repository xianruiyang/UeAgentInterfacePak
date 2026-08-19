---
command: smart_object_definition_validate_json
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Smart Object Definition
summary: 只读校验 JSON
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `smart_object_definition_validate_json`

## LLM Compact

- status: active.
- purpose: 只读校验 JSON
- key_inputs: `asset_path`, `json_file`, `strict`
- key_returns: `coverage_report`, `json_issues[]`, `status`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 这是只读校验入口；不得把 validate 结果当成已写入状态。
- validation: 检查 `valid/issues/json_issues`；validate 不产生写入副作用。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `strict`：严格校验模式。

## Returns

- `coverage_report`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `json_issues[]`：json_issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

检查 `valid/issues/json_issues`；validate 不产生写入副作用。
