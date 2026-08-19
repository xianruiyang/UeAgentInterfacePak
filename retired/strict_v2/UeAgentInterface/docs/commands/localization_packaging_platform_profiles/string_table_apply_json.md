---
command: string_table_apply_json
category: localization_packaging_platform_profiles
title: String Table
summary: 创建或更新 `UStringTable` entry/metadata
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `string_table_apply_json`

## LLM Compact

- status: active.
- purpose: 创建或更新 `UStringTable` entry/metadata
- key_inputs: `asset_path`, `dry_run`, `json_file`, `backup`, `json`, `save_after_apply`
- key_returns: `dry_run`, `changed_count`, `created`, `backup_paths[]`, `readback`
- behavior: `dry_run` 默认 `true`；默认只计算并返回变更，不创建或修改 String Table。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- 先使用默认 `dry_run=true` 检查 `results/changed_count`；确认后显式传 `dry_run=false`，再通过 export/query 验证实际资产状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `dry_run`：默认 `true`。为 `true` 时只计划/报告，不创建或修改资产；实际应用必须显式传 `false`。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `backup`：默认 `true`；实际写入时为已有目标创建备份。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_apply`：默认 `false`；控制实际应用后是否保存资产。

## Returns

- `changed_count`：数量摘要。
- `created`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `backup_paths[]`：本次实际写入创建的备份路径；dry-run 不创建备份。
- `dry_run`：回显本次是否为只计划模式。
- `readback`：应用结果读回；dry-run 中用于表达计划结果，不可视为资产已持久化。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
