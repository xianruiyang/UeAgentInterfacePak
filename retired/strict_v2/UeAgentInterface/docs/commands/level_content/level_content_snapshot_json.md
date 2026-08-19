---
command: level_content_snapshot_json
category: level_content
title: 指令
summary: 生成可回写的当前场景快照
aliases: []
tags: [level_content]
status: active
---

# `level_content_snapshot_json`

## LLM Compact

- status: active.
- purpose: 生成可回写的当前场景快照
- key_inputs: `output_file`, `projection`, `selection`
- key_returns: `resources[]`, `schema`, `organization`, `snapshot=true`
- behavior: 只读查询类命令；大结果应写入 `output_file`。
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- validation: 写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。

## Parameters

- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `include_bounds`、`include_components`：可选快照扩展。
- `projection`：查询投影；控制是否包含 bounds/components/properties 等额外字段。
- `selection`：目标选择器；支持的字段由命令定义。

## Returns

- `resources[]`：查询/快照资源列表；大列表优先输出到文件。
- `schema`：返回 payload schema。
- `organization`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `snapshot=true`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- 写文件成功时另返回 `entry_file`、`written_relative_files`、`output_written_full=true` 和 `publisher` transaction receipt。

## Validation

提供 `output_file` 时，验证完整 single-file receipt、size/hash、HJSON parse、publisher 和 request/session/freshness；不能只检查路径存在。
