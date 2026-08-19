---
command: level_actor_export_json
category: level_content
title: 指令
summary: Actor-only 查询兼容别名
aliases: []
tags: [level_content]
status: active
---

# `level_actor_export_json`

## LLM Compact

- status: active.
- purpose: Actor-only 查询兼容别名
- key_inputs: `output_file`, `selection`, `projection`, `include_bounds`, `include_components`
- key_returns: `actor_only=true`, `resources[]`, `output_file`, `publisher`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- validation: 提供 `output_file` 时验证完整 single-file receipt 与 HJSON parse。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。

## Parameters

- `output_file`：可选 single-file HJSON artifact。提供时通过 owned single-file publisher 原子发布。
- `selection`、`projection`：可选目标选择和投影。
- `include_bounds`、`include_components`：可选 Actor 查询扩展。

## Returns

除 Actor-only 查询数据外，写文件成功时返回 `output_file`、`output_format=hjson_authoring`、`entry_file`、`written_relative_files`、`output_written_full=true` 和 `publisher` transaction receipt。

## Validation

提供 `output_file` 时，验证完整 single-file receipt、size/hash、HJSON parse、publisher 和 request/session/freshness；不能只检查路径存在。
