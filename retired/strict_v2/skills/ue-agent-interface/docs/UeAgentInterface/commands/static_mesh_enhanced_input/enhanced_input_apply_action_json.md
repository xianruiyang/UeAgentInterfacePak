---
command: enhanced_input_apply_action_json
category: static_mesh_enhanced_input
title: EnhancedInput
summary: 从单文件 JSON 回写 `InputAction`
aliases: []
tags: [static_mesh_enhanced_input]
status: active
---

# `enhanced_input_apply_action_json`

## LLM Compact

- status: active.
- purpose: 从单文件 JSON 回写 `InputAction`
- key_inputs: `asset_path`, `json_file`, `create_if_missing`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 推荐参数：`json_file`、`save_after_apply`
- note: 可选：`asset_path`
- note: 不填时默认取 JSON 里的 `asset_path`
- note: 可选：`create_if_missing`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 推荐参数：`json_file`、`save_after_apply`
- 可选：`asset_path`
- 不填时默认取 JSON 里的 `asset_path`
- 可选：`create_if_missing`
- 默认 `true`

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
