---
command: render_target_create_static_texture
category: texture_render_target_media
title: RenderTarget
summary: 从 2D RT 创建静态 Texture2D；接受 `render_target + destination_path + destination_name`，原生路径失败时会用读回像素创建 Texture2D。
aliases: []
tags: [texture_render_target_media]
status: active
---

# `render_target_create_static_texture`

## LLM Compact

- status: active.
- purpose: 从 2D RT 创建静态 Texture2D；接受 `render_target + destination_path + destination_name`，原生路径失败时会用读回像素创建 Texture2D。
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
