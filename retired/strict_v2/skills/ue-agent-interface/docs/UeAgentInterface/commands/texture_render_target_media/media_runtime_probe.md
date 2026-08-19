---
command: media_runtime_probe
category: texture_render_target_media
title: Media
summary: 校验 MediaPlayer 能否播放指定 MediaSource，可选尝试打开。
aliases: []
tags: [texture_render_target_media]
status: active
---

# `media_runtime_probe`

## LLM Compact

- status: active.
- purpose: 校验 MediaPlayer 能否播放指定 MediaSource，可选尝试打开。
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
