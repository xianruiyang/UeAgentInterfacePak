---
command: montage_list_skeleton_slots
category: montage
title: 资产与基础信息
summary: 列出 Skeleton 上的 Slot/Group
aliases: []
tags: [montage]
status: active
---

# `montage_list_skeleton_slots`

## LLM Compact

- status: active.
- purpose: 列出 Skeleton 上的 Slot/Group
- key_inputs: `asset_path`, `skeleton_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `skeleton_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
