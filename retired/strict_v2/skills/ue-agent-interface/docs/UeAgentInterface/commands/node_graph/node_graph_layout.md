---
command: node_graph_layout
category: node_graph
title: 指令列表
summary: 对一个资产内指定或批量选中的节点连线图执行自动排布
aliases: []
tags: [node_graph]
status: active
---

# `node_graph_layout`

## LLM Compact

- status: active.
- purpose: 对一个资产内指定或批量选中的节点连线图执行自动排布
- key_inputs: `asset_path`, `adapter`, `compile_after_layout`, `graph_selector`, `layout_options`, `save_after_layout`
- key_returns: `saved`, `adapter`, `asset_path`, `changed`, `edge_count`, `graphs[]`, `moved_node_count`, `node_count` ...
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `adapter`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `compile_after_layout`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `graph_selector`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `layout_options`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_layout`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `saved`：是否保存资源或关卡。
- `adapter`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `changed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `edge_count`：数量摘要。
- `graphs[]`：graphs 列表摘要；大列表应写入 output/artifact 或 debug。
- `moved_node_count`：数量摘要。
- `node_count`：数量摘要。
- `nodes[]`：nodes 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
