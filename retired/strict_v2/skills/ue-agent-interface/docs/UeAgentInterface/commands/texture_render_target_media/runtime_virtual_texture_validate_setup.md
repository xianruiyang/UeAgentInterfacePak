---
command: runtime_virtual_texture_validate_setup
category: texture_render_target_media
title: Virtual Texture / Runtime Virtual Texture
summary: 校验 RVT 关卡/材质使用关系。
aliases: []
tags: [texture_render_target_media]
status: active
---

# `runtime_virtual_texture_validate_setup`

## LLM Compact

- status: active.
- purpose: 校验 RVT 关卡/材质使用关系。
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
