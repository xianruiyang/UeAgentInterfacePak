---
command: blendspace_create
category: animation_assets_skeleton
title: BlendSpace
summary: 创建 BlendSpace / BlendSpace1D / AimOffset / AimOffset1D
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `blendspace_create`

## LLM Compact

- status: active.
- purpose: 创建 BlendSpace / BlendSpace1D / AimOffset / AimOffset1D
- key_inputs: `asset_path`, `skeleton`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `skeleton`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
