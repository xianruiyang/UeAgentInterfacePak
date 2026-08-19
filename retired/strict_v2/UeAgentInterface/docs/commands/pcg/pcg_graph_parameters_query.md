---
command: pcg_graph_parameters_query
category: pcg
title: 指令列表
summary: 查询 Graph 或 GraphInstance 参数包
aliases: []
tags: [pcg]
status: active
---

# `pcg_graph_parameters_query`

## LLM Compact

- status: active.
- purpose: 查询 Graph 或 GraphInstance 参数包
- key_inputs: `asset_path`
- key_returns: `asset_path`, `parameter_count`, `parameters`。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- `parameter_count`：真实 Property Bag 中的参数数量。
- `parameters`：canonical 参数包对象，固定为 `{ schema: [], fields: {} }`；容器和复合类型在 `schema[]` 中递归携带类型元数据。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
