---
command: packaging_parse_log
category: localization_packaging_platform_profiles
title: Packaging
summary: 解析 UAT/cook log 的 error/warning
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_parse_log`

## LLM Compact

- status: active.
- purpose: 解析 UAT/cook log 的 error/warning
- key_inputs: `classify_errors`, `log_file`
- key_returns: `errors[]`, `phase_summary`, `warnings[]`
- behavior: 只读；`log_file` 必须位于项目 UAI-owned `Saved/UeAgentInterface` 根或其后代目录。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 不读取任意项目文件或外部路径。路径解析后越出 UAI-owned Saved 根会在文件读取前被拒绝。

## Parameters

- `classify_errors`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `log_file`：必填；必须解析到项目 `Saved/UeAgentInterface` 根或其后代文件。

## Returns

- `errors[]`：errors 列表摘要；大列表应写入 output/artifact 或 debug。
- `phase_summary`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `warnings[]`：warnings 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

路径越界返回 `log_file_not_uai_owned`；允许范围内文件不存在或不可读返回 `log_file_not_found`。成功时检查规范化后的 `log_file` 以及 `errors/warnings/phase_summary`。
