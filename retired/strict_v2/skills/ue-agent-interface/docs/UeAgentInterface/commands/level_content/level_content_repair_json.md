---
command: level_content_repair_json
category: level_content
title: 指令
summary: 诊断并可安全修复 folder/托管内容残留
aliases: []
tags: [level_content]
status: active
---

# `level_content_repair_json`

## LLM Compact

- status: active.
- purpose: 诊断并可安全修复 folder/托管内容残留
- key_inputs: `folder_root`, `apply_safe`, `cleanup_empty_folders`
- key_returns: `applied`, `schema`, `diagnostics[]`, `repair_results[]`
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- validation: 写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。

## Authoring Notes

- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。

## Parameters

- `folder_root`：托管范围根 folder；场景清理时是 Outliner folder，不是 `/Game` 资产目录。
- `apply_safe`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `cleanup_empty_folders`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `applied`：是否实际执行修复或写入。
- `schema`：返回 payload schema。
- `diagnostics[]`：diagnostics 列表摘要；大列表应写入 output/artifact 或 debug。
- `repair_results[]`：repair_results 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。
