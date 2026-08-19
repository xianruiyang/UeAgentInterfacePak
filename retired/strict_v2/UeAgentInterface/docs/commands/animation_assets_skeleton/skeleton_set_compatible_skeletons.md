---
command: skeleton_set_compatible_skeletons
category: animation_assets_skeleton
title: `skeleton_set_compatible_skeletons`
summary: skeleton_set_compatible_skeletons command contract.
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `skeleton_set_compatible_skeletons`

## LLM Compact

- status: active.
- purpose: skeleton_set_compatible_skeletons command contract.
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 这是 skeleton 兼容关系的统一入口，避免继续拆 `add/remove/clear/set_use_retarget_modes` 多条命令。
- note: 不允许把自己加为 compatible skeleton。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这是 skeleton 兼容关系的统一入口，避免继续拆 `add/remove/clear/set_use_retarget_modes` 多条命令。
- 不允许把自己加为 compatible skeleton。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
