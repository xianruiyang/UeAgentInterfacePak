---
command: anim_blueprint_graph_get_view
category: anim_blueprint
title: 图视图 / 预览视口 / 截图
summary: 读取指定图的平移/缩放
aliases: []
tags: [anim_blueprint]
status: active
---

# `anim_blueprint_graph_get_view`

## LLM Compact

- status: active.
- purpose: 读取指定图的平移/缩放
- key_inputs: `asset_path`, `open_editor_if_needed`, `graph_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `open_editor_if_needed`：默认 `false`；只有显式传 `true` 时才允许打开 Anim Blueprint Editor，未打开且未授权时返回 `blueprint_editor_not_opened`。
- `graph_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
