---
command: blendspace_validate_json
category: animation_assets_skeleton
title: BlendSpace
summary: 只读校验 BlendSpace JSON
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `blendspace_validate_json`

## LLM Compact

- status: active.
- purpose: 只读校验 BlendSpace JSON
- key_inputs: `asset_path`, `json_file`, `json`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 这是只读校验入口；不得把 validate 结果当成已写入状态。
- validation: 检查 `valid/issues/json_issues`；validate 不产生写入副作用。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

检查 `valid/issues/json_issues`；validate 不产生写入副作用。
