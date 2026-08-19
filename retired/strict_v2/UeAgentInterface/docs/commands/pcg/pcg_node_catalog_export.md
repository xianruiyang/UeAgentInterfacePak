---
command: pcg_node_catalog_export
category: pcg
title: 指令列表
summary: 导出可用 `UPCGSettings` 节点目录
aliases: []
tags: [pcg]
status: active
---

# `pcg_node_catalog_export`

## LLM Compact

- status: active.
- purpose: 导出可用 `UPCGSettings` 节点目录
- key_inputs: `output_file`, `include_deprecated`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `include_deprecated`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
