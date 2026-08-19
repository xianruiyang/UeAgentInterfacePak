---
command: texture_validate_settings
category: texture_render_target_media
title: Texture2D
summary: 按 `expected_usage=color/normal/mask/ui/data` 做只读语义校验。
aliases: []
tags: [texture_render_target_media]
status: active
---

# `texture_validate_settings`

## LLM Compact

- status: active.
- purpose: 按 `expected_usage=color/normal/mask/ui/data` 做只读语义校验。
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
