---
command: niagara_user_parameter_list
category: niagara_system
title: System User 参数 CRUD
summary: 列出 User 参数
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_user_parameter_list`

## LLM Compact

- status: active.
- purpose: 列出 User 参数
- key_inputs: `asset_path`, `include_values`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 只读查询类命令；大结果应写入 `output_file`。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `include_values`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
