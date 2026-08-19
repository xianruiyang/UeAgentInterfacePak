---
command: ik_rig_preview_solve
category: ikrig_ikretargeter
title: `ik_rig_preview_solve`
summary: 不进 PIE 的 IK Rig 预览求解探针
aliases: []
tags: [ikrig_ikretargeter]
status: active
---

# `ik_rig_preview_solve`

## LLM Compact

- status: active.
- purpose: 不进 PIE 的 IK Rig 预览求解探针
- key_inputs: `asset_path`, `goals[]`, `include_all_bones`, `max_output_bones`, `sample_bones[]`, `skeletal_mesh_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 如果 `initialized=false`，命令失败并返回 `ik_rig_preview_solve_initialize_failed`，同时 `data` 里保留 IK Rig logger 诊断。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 如果 `initialized=false`，命令失败并返回 `ik_rig_preview_solve_initialize_failed`，同时 `data` 里保留 IK Rig logger 诊断。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `goals[]`：goals 列表。
- `include_all_bones`：布尔/开关字段；默认值以本命令契约为准。
- `max_output_bones`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sample_bones[]`：sample_bones 列表。
- `skeletal_mesh_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
