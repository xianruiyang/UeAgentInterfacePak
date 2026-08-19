---
command: blackboard_export_json
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Blackboard
summary: 导出单文件 HJSON
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject]
status: active
---

# `blackboard_export_json`

## LLM Compact

- status: active.
- purpose: 导出单文件 HJSON
- key_inputs: `asset_path`, `output_file`, `include_parent_keys`, `include_validation`
- key_returns: `coverage_report`, `output_file`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- 命令名保留历史 `json`；authoring 文件格式为 HJSON，`output_file` 传 `.json` 会规范化写到同名 `.hjson`。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；authoring 文件使用 HJSON，`.json` 后缀会规范化为 `.hjson`。大结果应写文件，不要内联到 compact data。
- `include_parent_keys`：布尔/开关字段；默认值以本命令契约为准。
- `include_validation`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `coverage_report`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `output_file`：文件路径字段；长 HJSON authoring 结果优先走文件。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
