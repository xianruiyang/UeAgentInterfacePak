---
command: node_catalog_categories
category: node_graph
title: 指令列表
summary: 查询同一候选源的分类/分组统计；当 LLM 不确定 UE 菜单分类时先用它缩小范围
aliases: []
tags: [node_graph]
status: active
---

# `node_catalog_categories`

## LLM Compact

- status: active.
- purpose: 查询同一候选源的分类/分组统计；当 LLM 不确定 UE 菜单分类时先用它缩小范围
- key_inputs: `catalog_type`, `context`, `filters`, `query.text`
- key_returns: `warnings`, `category_tree`, `counts`, `groups`
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `catalog_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `context`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `filters`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `query.text`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `warnings`：警告摘要。
- `category_tree`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `counts`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `groups`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
