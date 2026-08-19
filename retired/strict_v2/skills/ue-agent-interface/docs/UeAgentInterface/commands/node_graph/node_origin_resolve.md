---
command: node_origin_resolve
category: node_graph
title: 指令列表
summary: 根据 catalog 候选、`kind/name/full_name`、JSON 指针或 UE 对象身份返回资产/源码路径
aliases: []
tags: [node_graph]
status: active
---

# `node_origin_resolve`

## LLM Compact

- status: active.
- purpose: 根据 catalog 候选、`kind/name/full_name`、JSON 指针或 UE 对象身份返回资产/源码路径
- key_inputs: `target.candidate_id`, `target.hjson_file`, `json_pointer`, `target.kind`, `name`, `full_name`, `target.source`
- key_returns: `warnings`, `origin.asset_paths`, `package_paths`, `package_files`, `code_paths[]`, `resolved`, `status`, `target`
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `target.candidate_id`：直接使用 `node_catalog_search` 唯一 exact/detail 返回的 canonical candidate id。命令会通过同一 Catalog identity 回查原始 `kind/full_name`，不解析手工拼接的 legacy 字符串。
- `target.hjson_file/json_pointer`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `target.kind/name/full_name`：可作为冗余断言；与 `candidate_id` 指向不一致时以 `target_identity_conflict` fail-fast，不会覆盖 canonical identity。
- `target.source`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。

## Returns

- `warnings`：警告摘要。
- `origin.asset_paths`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `package_paths`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `package_files`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `code_paths[]`：code_paths 列表摘要；大列表应写入 output/artifact 或 debug。
- `resolved`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
