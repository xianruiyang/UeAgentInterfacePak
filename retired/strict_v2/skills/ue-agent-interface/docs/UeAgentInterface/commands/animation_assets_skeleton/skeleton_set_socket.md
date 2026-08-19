---
command: skeleton_set_socket
category: animation_assets_skeleton
title: `skeleton_set_socket`
summary: skeleton_set_socket command contract.
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `skeleton_set_socket`

## LLM Compact

- status: active.
- purpose: skeleton_set_socket command contract.
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 不传 `remove` 时，命令会“存在则更新，不存在则创建”。
- note: 如果只想改偏移，不需要重建 socket。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 不传 `remove` 时，命令会“存在则更新，不存在则创建”。
- 如果只想改偏移，不需要重建 socket。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
