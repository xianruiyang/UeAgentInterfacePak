---
command: blackboard_apply_json
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Blackboard
summary: 回写 HJSON payload
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `blackboard_apply_json`

## LLM Compact

- status: active.
- purpose: 回写 HJSON payload
- key_inputs: `asset_path`, `dry_run`, `json_file`, `allow_destructive`, `create_if_missing`, `save_after_apply`, `validate_only`
- key_returns: `saved`, `changed`, `coverage_report`, `created_asset`, `property_results[]`
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `dry_run`：只计划/报告不写入；删除类命令通常默认 true，执行删除需显式 false。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `allow_destructive`：布尔/开关字段；默认值以本命令契约为准。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。
- `validate_only`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `saved`：是否保存资源或关卡。
- `changed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `coverage_report`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `property_results[]`：property_results 列表摘要；大列表应写入 output/artifact 或 debug。
- `created_asset`：资产操作结果摘要。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
