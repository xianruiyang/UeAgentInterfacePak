---
command: pcg_graph_parameters_apply_json
category: pcg
title: 指令列表
summary: 写入 Graph 或 GraphInstance 参数包
aliases: []
tags: [pcg]
status: active
---

# `pcg_graph_parameters_apply_json`

## LLM Compact

- status: active.
- purpose: 写入 Graph 或 GraphInstance 参数包
- key_inputs: `asset_path`, `parameters`, `save`
- key_returns: `applied_count`, `parameter_count`, `parameters`, `issues`, `error_count`。
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `parameters`：canonical 参数包对象 `{ schema: [], fields: {} }`；每个 schema descriptor 必须给出 `name`、`value_kind`，并为容器、struct、enum、reference 递归提供所需类型元数据。
- `save`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `applied_count`：本次成功写入的参数数。
- `parameter_count`：写后真实 Property Bag 参数总数。
- `parameters`：写后读回的 canonical 参数包。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
