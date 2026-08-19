---
command: scalability_apply_json
category: localization_packaging_platform_profiles
title: Platform Profiles
summary: 写入项目 `DefaultScalability.ini`
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `scalability_apply_json`

## LLM Compact

- status: active.
- purpose: 写入项目 `DefaultScalability.ini`
- key_inputs: `dry_run`, `json_file`, `backup`, `json`
- key_returns: `changes[]`, `readback`
- behavior: `dry_run=true`、`backup=true`；先执行完整 Scalability/INI 安全校验，通过后才允许写入。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- group section 必须是包含 `Quality@` 的非空单行安全名称，不得包含 `=`、`[`、`]`；key 必须非空且不得包含换行或 `=`；value 必须是字符串且不得包含换行或 `=`。
- 先保留默认 `dry_run=true` 审阅 `changes[]`；实际写入必须显式传 `dry_run=false`，再检查 `readback` 或 export。

## Parameters

- `dry_run`：默认 `true`；只报告变更，不修改 `DefaultScalability.ini`、不创建备份。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `backup`：默认 `true`；仅实际写入时创建备份，返回到 `backup_paths[]`。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `changes[]`：changes 列表摘要；大列表应写入 output/artifact 或 debug。
- `readback`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `backup_paths[]`：实际写入创建的备份路径；dry-run 为空。

## Validation

安全校验失败时返回 `scalability_validate_failed`，并在 `issues` 中给出 `scalability_section_invalid`、`scalability_key_invalid` 或 `scalability_value_invalid`；此时不写文件。实际 apply 后检查 `readback` 或 export；不能只看 `success=true`。
