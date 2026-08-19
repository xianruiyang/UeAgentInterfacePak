---
command: curve_export_json
category: core_level
title: `curve_export_json`
summary: 导出 Curve 资产为结构化 HJSON
aliases: []
tags: [core_level]
status: active
---

# `curve_export_json`

## LLM Compact

- status: active.
- purpose: 导出 Curve 资产为结构化 HJSON
- key_inputs: `asset_path`, `output_file`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- 命令名保留历史 `json`；authoring 文件格式为 HJSON。`output_file` 传 `.json` 会规范化写到同名 `.hjson`，`json_file` 传 `.json` 时按同名 `.hjson` 读取。
- `curve_json`、`value_json` 等字段名是曲线/值的结构化负载，不是文件格式残留。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；authoring 文件使用 HJSON，`.json` 后缀会规范化为 `.hjson`。大结果应写文件，不要内联到 compact data。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
