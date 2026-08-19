---
command: anim_blueprint_layout_graph
category: anim_blueprint
title: Blueprint 级逻辑编辑
summary: 自动排版指定 AnimBlueprint 图节点
aliases: []
tags: [anim_blueprint]
status: active
---

# `anim_blueprint_layout_graph`

## LLM Compact

- status: active.
- purpose: 自动排版指定 AnimBlueprint 图节点
- key_inputs: `asset_path`, `dry_run`, `compile_after_layout`, `graph_name`, `horizontal_spacing`, `node_padding`, `save_after_layout`, `vertical_spacing`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `dry_run`：只计划/报告不写入；删除类命令通常默认 true，执行删除需显式 false。
- `compile_after_layout`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `graph_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `horizontal_spacing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `node_padding`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_layout`：布尔/开关字段；默认值以本命令契约为准。
- `vertical_spacing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
