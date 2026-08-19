---
command: level_align_face_to_face
category: core_level
title: `level_align_face_to_face`
summary: level_align_face_to_face command contract.
aliases: []
tags: [core_level]
status: active
---

# `level_align_face_to_face`

## LLM Compact

- status: active.
- purpose: level_align_face_to_face command contract.
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 或显式：`+x/-x/+y/-y/+z/-z`（会推导 `axis`）
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 或显式：`+x/-x/+y/-y/+z/-z`（会推导 `axis`）

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
