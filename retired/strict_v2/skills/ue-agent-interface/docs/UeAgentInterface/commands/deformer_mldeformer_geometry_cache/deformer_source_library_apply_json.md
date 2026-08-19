---
command: deformer_source_library_apply_json
category: deformer_mldeformer_geometry_cache
title: Deformer Source Library / Mesh Deformer Collection
summary: 应用显式 `apply=true` 的属性项
aliases: []
tags: [deformer_mldeformer_geometry_cache]
status: active
---

# `deformer_source_library_apply_json`

## LLM Compact

- status: active.
- purpose: 应用显式 `apply=true` 的属性项
- key_inputs: `dry_run`, `json_file`, `save_after_apply`, `validate_only`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。

## Parameters

- `dry_run`：只计划/报告不写入；删除类命令通常默认 true，执行删除需显式 false。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。
- `validate_only`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
