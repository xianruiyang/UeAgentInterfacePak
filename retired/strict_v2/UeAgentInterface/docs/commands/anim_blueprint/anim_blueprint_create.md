---
command: anim_blueprint_create
category: anim_blueprint
title: `anim_blueprint_create`
summary: 创建普通 AnimBlueprint 资产
aliases: []
tags: [anim_blueprint]
status: active
---

# `anim_blueprint_create`

## LLM Compact

- status: active.
- purpose: 创建普通 AnimBlueprint 资产
- key_inputs: `asset_path`, `compile_after_create`, `open_editor`, `parent_class`, `preview_skeletal_mesh`, `save_after_create`, `target_skeleton`, `template`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 默认父类：`/Script/Engine.AnimInstance`
- note: 显式传 `target_skeleton`
- note: 只传 `preview_skeletal_mesh`，由网格反推 skeleton
- note: 非模板动画蓝图如果最终拿不到 skeleton，会直接失败
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 默认父类：`/Script/Engine.AnimInstance`
- 显式传 `target_skeleton`
- 只传 `preview_skeletal_mesh`，由网格反推 skeleton
- 非模板动画蓝图如果最终拿不到 skeleton，会直接失败

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `compile_after_create`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `open_editor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `parent_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `preview_skeletal_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。
- `target_skeleton`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `template`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
