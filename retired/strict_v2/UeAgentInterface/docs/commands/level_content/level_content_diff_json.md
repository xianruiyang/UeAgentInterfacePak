---
command: level_content_diff_json
category: level_content
title: 指令
summary: 比较目标 JSON 与当前场景差异
aliases: []
tags: [level_content]
status: active
---

# `level_content_diff_json`

## LLM Compact

- status: active.
- purpose: 比较目标 JSON 与当前场景差异
- key_inputs: `content`, `delete_policy`, `json_file`, `actor_only`
- key_returns: `schema`, `current_count`, `diffs[]`, `empty`, `target_count`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- note: 本命令比较单文件 Level Content JSON 与当前场景差异。比较两个 Level folder package 时使用 `level_diff_folder`。
- validation: 写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。

## Authoring Notes

- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- 本命令不比较两个 folder package；folder package 间的 Level/Actor/Component/Property/Reference 差异使用 `level_diff_folder`。

## Folder Workflow Boundary

- 继续使用本命令：比较一个目标 Level Content payload 与当前场景。
- 改用 `level_diff_folder`：比较 `level_export_folder` 产出的两个目录，按 `Level`、`Actor`、`Component`、`Property`、`Reference` 分组。
- 两者都是 active；本命令不废弃，但不承担 folder package diff。

## Parameters

- `content`：内联 HJSON authoring 内容；长内容优先写入文件再传 `json_file`。
- `delete_policy`：删除策略；写操作中用于限制可删除范围。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `actor_only`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `schema`：返回 payload schema。
- `current_count`：数量摘要。
- `diffs[]`：diffs 列表摘要；大列表应写入 output/artifact 或 debug。
- `empty`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_count`：数量摘要。

## Validation

写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。
