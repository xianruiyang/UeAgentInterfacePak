---
command: packaging_report_artifacts
category: localization_packaging_platform_profiles
title: Packaging
summary: 扫描 archive 目录产物
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_report_artifacts`

## LLM Compact

- status: active.
- purpose: 扫描 archive 目录产物
- key_inputs: `archive_dir`, `include_hashes`, `platform`
- key_returns: `artifacts[]`, `missing_expected[]`, `total_size`
- behavior: 只读扫描；`archive_dir` 仅允许项目 UAI-owned `Saved/UeAgentInterface/Packages` 根或其后代目录。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 路径边界在递归扫描和 hash 计算前校验，不能用任意 `Saved`、项目外路径或路径穿越扩大扫描范围。

## Parameters

- `archive_dir`：默认项目 `Saved/UeAgentInterface/Packages`；显式值也必须解析到该根或其后代目录。
- `include_hashes`：默认 `false`；为 `true` 时对边界内文件计算 MD5。
- `platform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `artifacts[]`：artifacts 列表摘要；大列表应写入 output/artifact 或 debug。
- `missing_expected[]`：missing_expected 列表摘要；大列表应写入 output/artifact 或 debug。
- `total_size`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

路径越界返回 `archive_dir_not_uai_owned`。成功时检查规范化后的 `archive_dir`、`artifacts[]` 和 `total_size`。
