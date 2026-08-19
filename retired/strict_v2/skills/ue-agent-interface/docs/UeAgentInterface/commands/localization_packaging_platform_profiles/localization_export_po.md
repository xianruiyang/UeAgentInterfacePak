---
command: localization_export_po
category: localization_packaging_platform_profiles
title: Localization
summary: 扫描并导出 PO 文件
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `localization_export_po`

## LLM Compact

- status: active.
- purpose: 扫描并导出 PO 文件
- key_inputs: `target`, `cultures[]`, `execute`, `output_dir`
- key_returns: `entry_count`, `po_files[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `cultures[]`：cultures 列表。
- `execute`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `output_dir`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `entry_count`：数量摘要。
- `po_files[]`：po_files 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
