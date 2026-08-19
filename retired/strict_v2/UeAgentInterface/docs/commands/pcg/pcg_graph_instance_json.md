---
command: pcg_graph_instance_json
category: pcg
title: 指令列表
summary: 创建/更新/读取 GraphInstance
aliases: []
tags: [pcg]
status: active
---

# `pcg_graph_instance_json`

## LLM Compact

- status: active.
- purpose: 创建/更新/读取 GraphInstance
- key_inputs: `asset_path`, `create`, `graph`, `parameters`, `save`
- key_returns: `asset_path`, `object_path`, `graph`, `created`, `parameter_count`, `parameters`。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `create`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `graph`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `parameters`：可选 canonical 参数包对象 `{ schema: [], fields: {} }`，不是 assignment 数组。
- `save`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `parameter_count`：GraphInstance 参数数量。
- `parameters`：写后读回的 canonical 参数包。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
