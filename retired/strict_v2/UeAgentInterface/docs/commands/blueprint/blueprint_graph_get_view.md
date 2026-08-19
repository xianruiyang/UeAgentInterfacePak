---
command: blueprint_graph_get_view
category: blueprint
title: 图视图控制（新增）
summary: 获取指定图的平移/缩放
aliases: []
tags: [blueprint]
status: active
---

# `blueprint_graph_get_view`

## LLM Compact

- status: active.
- purpose: 获取指定图的平移/缩放
- key_inputs: `asset_path`, `open_editor_if_needed`, `graph_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `open_editor_if_needed`：默认 `false`；只有显式传 `true` 时才允许打开 Blueprint Editor，未打开且未授权时返回 `blueprint_editor_not_opened`。
- `graph_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
