---
command: control_rig_bake_to_animation
category: control_rig_folder_format
title: Control Rig 命令
summary: 从 Sequencer 显式 Bake To Animation
aliases: []
tags: [control_rig_folder_format]
status: active
---

# `control_rig_bake_to_animation`

## LLM Compact

- status: active.
- purpose: 从 Sequencer 显式 Bake To Animation
- key_inputs: `binding_guid`, `binding_id`, `output_anim_sequence`, `preview_skeletal_mesh`, `sequence_path`, `target_skeleton`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。

## Parameters

- `binding_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `binding_id`：稳定 id，用于精确定位或后续操作。
- `output_anim_sequence`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `preview_skeletal_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sequence_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `target_skeleton`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
