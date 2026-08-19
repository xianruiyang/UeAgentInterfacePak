---
command: blueprint_inspect_nodes
category: blueprint
title: 图与节点
summary: 列出图节点与引脚
aliases: []
tags: [blueprint]
status: active
---

# `blueprint_inspect_nodes`

## LLM Compact

- status: active.
- purpose: 列出图节点与引脚
- key_inputs: `asset_path`, `graph_name`, `include_pins`, `limit_per_graph`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `graph_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `include_pins`：布尔/开关字段；默认值以本命令契约为准。
- `limit_per_graph`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
