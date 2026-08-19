---
command: level_content_merge_json
category: level_content
title: 指令
summary: 合并 base/current/target 三份 Level Content JSON
aliases: []
tags: [level_content]
status: active
---

# `level_content_merge_json`

## LLM Compact

- status: active.
- purpose: 合并 base/current/target 三份 Level Content JSON
- key_inputs: `target`, `base`, `conflict_policy`, `current`
- key_returns: `schema`, `conflict_count`, `conflicts[]`, `merged_json`
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- validation: 写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。

## Authoring Notes

- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。

## Parameters

- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `base`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `conflict_policy`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `current`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `schema`：返回 payload schema。
- `conflict_count`：数量摘要。
- `conflicts[]`：conflicts 列表摘要；大列表应写入 output/artifact 或 debug。
- `merged_json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。
