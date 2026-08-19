---
command: ik_retargeter_create
category: ikrig_ikretargeter
title: IK Retargeter
summary: 创建 IK Retargeter 最小资产
aliases: []
tags: [ikrig_ikretargeter]
status: active
---

# `ik_retargeter_create`

## LLM Compact

- status: active.
- purpose: 创建 IK Retargeter 最小资产
- key_inputs: `asset_path`, `add_default_ops`, `save_after_create`, `source_ik_rig`, `source_preview_mesh`, `target_ik_rig`, `target_preview_mesh`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `add_default_ops`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。
- `source_ik_rig`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source_preview_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_ik_rig`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_preview_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
