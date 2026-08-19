---
command: ik_rig_apply_auto_retarget_definition
category: ikrig_ikretargeter
title: IK Rig
summary: 对匹配模板的骨架自动生成 retarget definition
aliases: []
tags: [ikrig_ikretargeter]
status: active
---

# `ik_rig_apply_auto_retarget_definition`

## LLM Compact

- status: active.
- purpose: 对匹配模板的骨架自动生成 retarget definition
- key_inputs: `asset_path`, `save_after_set`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
