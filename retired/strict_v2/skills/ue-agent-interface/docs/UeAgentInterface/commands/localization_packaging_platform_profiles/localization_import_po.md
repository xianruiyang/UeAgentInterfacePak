---
command: localization_import_po
category: localization_packaging_platform_profiles
title: Localization
summary: 导入 PO 文件到 target/culture 目录
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `localization_import_po`

## LLM Compact

- status: active.
- purpose: 导入 PO 文件到 target/culture 目录
- key_inputs: `dry_run`, `target`, `backup`, `culture`, `po_file`
- key_returns: `backup_paths[]`, `imported_count`, `translated_count`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `dry_run`：只计划/报告不写入；删除类命令通常默认 true，执行删除需显式 false。
- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `backup`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `culture`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `po_file`：文件路径字段；长 JSON/结果优先走文件。

## Returns

- `backup_paths[]`：backup_paths 列表摘要；大列表应写入 output/artifact 或 debug。
- `imported_count`：数量摘要。
- `translated_count`：数量摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
