---
command: ik_retargeter_auto_align_pose
category: ikrig_ikretargeter
title: `ik_retargeter_auto_align_pose`
summary: 对当前或指定 retarget pose 执行自动姿势对齐
aliases: []
tags: [ikrig_ikretargeter]
status: active
---

# `ik_retargeter_auto_align_pose`

## LLM Compact

- status: active.
- purpose: 对当前或指定 retarget pose 执行自动姿势对齐
- key_inputs: `asset_path`, `auto_align_all`, `auto_align_bones[]`, `bones[]`, `auto_align_method`, `create_if_missing`, `pose_name`, `reset_*` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `auto_align_all`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `auto_align_bones[]`：auto_align_bones 列表。
- `bones[]`：bones 列表。
- `auto_align_method`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `pose_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `reset_*`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `set_current`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `snap_bone_to_ground`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source_or_target`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
