---
command: anim_sequence_set_notify_track
category: animation_assets_skeleton
title: Animation Sequence
summary: 新增 / 更新 / 删除 notify track
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_set_notify_track`

## LLM Compact

- status: active.
- purpose: 新增 / 更新 / 删除 notify track
- key_inputs: `asset_path`, `remove`, `save_after_set`, `track_color`, `track_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `remove`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `track_color`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `track_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
