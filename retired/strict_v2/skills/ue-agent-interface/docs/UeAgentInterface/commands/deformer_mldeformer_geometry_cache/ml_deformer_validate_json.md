---
command: ml_deformer_validate_json
category: deformer_mldeformer_geometry_cache
title: ML Deformer
summary: 校验 JSON 与属性候选项
aliases: []
tags: [deformer_mldeformer_geometry_cache]
status: active
---

# `ml_deformer_validate_json`

## LLM Compact

- status: active.
- purpose: 校验 JSON 与属性候选项
- key_inputs: `json_file`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 这是只读校验入口；不得把 validate 结果当成已写入状态。
- validation: 检查 `valid/issues/json_issues`；validate 不产生写入副作用。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。

## Parameters

- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

检查 `valid/issues/json_issues`；validate 不产生写入副作用。
