---
command: control_rig_shape_library_validate_json
category: control_rig_folder_format
title: Control Rig Shape Library
summary: 校验单文件 JSON
aliases: []
tags: [control_rig_folder_format]
status: active
---

# `control_rig_shape_library_validate_json`

## LLM Compact

- status: active.
- purpose: 校验单文件 JSON
- key_inputs: `asset_path`, `json_file`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 这是只读校验入口；不得把 validate 结果当成已写入状态。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- validation: 检查 `valid/issues/json_issues`；validate 不产生写入副作用。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。
- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

检查 `valid/issues/json_issues`；validate 不产生写入副作用。
