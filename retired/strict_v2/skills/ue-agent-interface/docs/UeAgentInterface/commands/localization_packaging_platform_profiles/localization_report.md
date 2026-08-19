---
command: localization_report
category: localization_packaging_platform_profiles
title: Localization
summary: 汇总 PO 覆盖和缺失信息
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `localization_report`

## LLM Compact

- status: active.
- purpose: 汇总 PO 覆盖和缺失信息
- key_inputs: `target`, `cultures[]`, `include_assets`
- key_returns: `coverage_by_culture[]`, `missing[]`, `stale[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `cultures[]`：cultures 列表。
- `include_assets`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `coverage_by_culture[]`：coverage_by_culture 列表摘要；大列表应写入 output/artifact 或 debug。
- `missing[]`：missing 列表摘要；大列表应写入 output/artifact 或 debug。
- `stale[]`：stale 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
