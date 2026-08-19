---
command: niagara_list_assets
category: niagara_system
title: 资产级操作
summary: 列出 Niagara 资产
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_list_assets`

## LLM Compact

- status: active.
- purpose: 列出 Niagara 资产
- key_inputs: `limit`, `root_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `limit`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `root_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
