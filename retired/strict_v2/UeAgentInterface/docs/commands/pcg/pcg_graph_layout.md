---
command: pcg_graph_layout
category: pcg
title: 指令列表
summary: 自动排布 PCG Graph Editor 节点
aliases: []
tags: [pcg]
status: active
---

# `pcg_graph_layout`

## LLM Compact

- status: active.
- purpose: 自动排布 PCG Graph Editor 节点
- key_inputs: `asset_path`, `compile_after_layout`, `graph_selector`, `layout_options`, `save`, `save_after_layout`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `compile_after_layout`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `graph_selector`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `layout_options`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_layout`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
