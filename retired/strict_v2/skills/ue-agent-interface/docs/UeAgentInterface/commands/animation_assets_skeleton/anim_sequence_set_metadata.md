---
command: anim_sequence_set_metadata
category: animation_assets_skeleton
title: `anim_sequence_set_metadata`
summary: 统一管理 AnimSequence metadata 生命周期
aliases: []
tags: [animation_assets_skeleton]
status: active
---

# `anim_sequence_set_metadata`

## LLM Compact

- status: active.
- purpose: 统一管理 AnimSequence metadata 生命周期
- key_inputs: `asset_path`, `clear_all`, `metadata_class_path`, `metadata_values`, `remove`, `save_after_set`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 这是 AnimSequence metadata 生命周期的统一入口，避免继续拆 `add_metadata / remove_metadata / clear_metadata` 多条命令。
- note: 传 `metadata_class_path` 且不带 `remove` 时，会“如果不存在则添加”，默认不重复创建同类 metadata。
- note: 传 `remove=true` 时，按类删除该序列上的全部同类 metadata。
- note: metadata 类必须是具体的 `UAnimMetaData` 派生类，不能是抽象基类。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这是 AnimSequence metadata 生命周期的统一入口，避免继续拆 `add_metadata / remove_metadata / clear_metadata` 多条命令。
- 传 `metadata_class_path` 且不带 `remove` 时，会“如果不存在则添加”，默认不重复创建同类 metadata。
- 传 `remove=true` 时，按类删除该序列上的全部同类 metadata。
- metadata 类必须是具体的 `UAnimMetaData` 派生类，不能是抽象基类。
- > 废弃写入命令已迁移到 `deprecatedCommand/13_AnimationAssets_Skeleton.md` 的对应章节。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `clear_all`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `metadata_class_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `metadata_values`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `remove`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
