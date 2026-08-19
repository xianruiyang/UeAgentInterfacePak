---
command: node_graph_list
category: node_graph
title: 指令列表
summary: 枚举一个资产内可由通用节点图排布入口识别的图
aliases: []
tags: [node_graph]
status: active
---

# `node_graph_list`

## LLM Compact

- status: active.
- purpose: 枚举一个资产内可由通用节点图排布入口识别的图
- key_inputs: `asset_path`, `adapter`, `graph_selector`, `include_nested_graphs`
- key_returns: `adapter`, `asset_class`, `asset_path`, `graph_count`, `graphs[]`, `object_path`
- behavior: 只读查询类命令；大结果应写入 `output_file`。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `adapter`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `graph_selector`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_nested_graphs`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `adapter`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `asset_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `graph_count`：数量摘要。
- `graphs[]`：graphs 列表摘要；大列表应写入 output/artifact 或 debug。
- `object_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
