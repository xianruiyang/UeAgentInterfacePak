---
command: config_apply_section
category: project_settings_config
title: Config Fallback
summary: 对受限 `.ini` section 执行 set/remove 并读回
aliases: []
tags: [project_settings_config]
status: active
---

# `config_apply_section`

## LLM Compact

- status: active.
- purpose: 对受限 `.ini` section 执行 set/remove 并读回
- key_inputs: `dry_run`, `backup`, `config_file`, `options{}`, `read_back`, `remove[]`, `section`, `set{}`
- key_returns: `schema`, `success`, `backup_file`, `backup_path`, `changes[]`, `errors[]`, `operation_count`, `read_back` ...
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `dry_run`：只计划/报告不写入；删除类命令通常默认 true，执行删除需显式 false。
- `backup`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `config_file`：文件路径字段；长 JSON/结果优先走文件。
- `options{}`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `read_back`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `remove[]`：remove 列表。
- `section`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `set{}`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `schema`：返回 payload schema。
- `success`：命令业务是否成功；仍需按返回字段读回验收。
- `backup_file`：文件路径字段；长 JSON/结果优先走文件。
- `backup_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `changes[]`：changes 列表摘要；大列表应写入 output/artifact 或 debug。
- `errors[]`：errors 列表摘要；大列表应写入 output/artifact 或 debug。
- `operation_count`：数量摘要。
- `read_back`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `results[]`：results 列表摘要；大列表应写入 output/artifact 或 debug。
- `source=config_file_fallback`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `warnings[]`：warnings 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
