---
command: geometry_cache_screenshot_frame
category: deformer_mldeformer_geometry_cache
title: Geometry Cache / Alembic
summary: 无 UI 读取指定帧/时间的 Geometry Cache 采样摘要
aliases: []
tags: [deformer_mldeformer_geometry_cache]
status: active
---

# `geometry_cache_screenshot_frame`

## LLM Compact

- status: active.
- purpose: 无 UI 读取指定帧/时间的 Geometry Cache 采样摘要
- key_inputs: `asset_path`, `frame_index`, `time_seconds`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `frame_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `time_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
