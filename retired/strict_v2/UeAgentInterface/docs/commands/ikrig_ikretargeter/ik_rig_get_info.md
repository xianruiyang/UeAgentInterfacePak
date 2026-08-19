---
command: ik_rig_get_info
category: ikrig_ikretargeter
title: `ik_rig_get_info`
summary: 读取 IK Rig 摘要
aliases: []
tags: [ikrig_ikretargeter]
status: active
---

# `ik_rig_get_info`

## LLM Compact

- status: active.
- purpose: 读取 IK Rig 摘要
- key_inputs: `asset_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
