---
command: level_create_blank
category: core_level
title: `level_create_blank` / `level_open`
summary: 创建并打开新的空 persistent Level 资产
aliases: []
tags: [core_level]
status: active
---

# `level_create_blank`

## LLM Compact

- status: active.
- purpose: 创建并打开新的空 persistent Level 资产
- key_inputs: `asset_path`, `level_path`, `overwrite_policy`, `save_existing_map`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 用途：创建或打开一个独立的 persistent Level 资产。需要在干净场景中做自动化演示、截图或 smoke 时，优先创建专用 map，再通过 Level Content JSON 写入场景实例，避免把临时内容混入当前业务关卡。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 用途：创建或打开一个独立的 persistent Level 资产。需要在干净场景中做自动化演示、截图或 smoke 时，优先创建专用 map，再通过 Level Content JSON 写入场景实例，避免把临时内容混入当前业务关卡。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `level_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `overwrite_policy`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_existing_map`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
