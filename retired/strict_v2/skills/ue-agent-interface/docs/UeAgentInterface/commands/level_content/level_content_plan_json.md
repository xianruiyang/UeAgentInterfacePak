---
command: level_content_plan_json
category: level_content
title: 指令
summary: 只读生成执行计划和风险清单
aliases: []
tags: [level_content]
status: active
---

# `level_content_plan_json`

## LLM Compact

- status: active.
- purpose: 只读生成执行计划和风险清单
- key_inputs: `content`, `dry_run`, `json_file`, `mode`, `strict`
- key_returns: `feature_gates`, `schema`, `can_apply`, `steps[]`, `validation`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- validation: 写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。

## Authoring Notes

- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。

## Parameters

- `content`：内联 HJSON authoring 内容；长内容优先写入文件再传 `json_file`。
- `dry_run`：只计划/报告不写入；删除类命令通常默认 true，执行删除需显式 false。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `mode`：命令模式；具体枚举以本命令契约为准。
- `strict`：严格校验模式。

## Returns

- `feature_gates`：功能门禁/不可用能力摘要。
- `schema`：返回 payload schema。
- `can_apply`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `steps[]`：steps 列表摘要；大列表应写入 output/artifact 或 debug。
- `validation`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。
