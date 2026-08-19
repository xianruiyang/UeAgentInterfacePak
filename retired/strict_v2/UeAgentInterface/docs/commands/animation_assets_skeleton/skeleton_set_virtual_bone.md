---
command: skeleton_set_virtual_bone
category: animation_assets_skeleton
title: `skeleton_set_virtual_bone`
summary: skeleton_set_virtual_bone command contract.
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `skeleton_set_virtual_bone`

## LLM Compact

- status: active.
- purpose: skeleton_set_virtual_bone command contract.
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 不传 `virtual_bone_name` 时，会让 UE 自动生成标准名字。
- note: 删除时按 `virtual_bone_name` 删除。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 不传 `virtual_bone_name` 时，会让 UE 自动生成标准名字。
- 删除时按 `virtual_bone_name` 删除。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
