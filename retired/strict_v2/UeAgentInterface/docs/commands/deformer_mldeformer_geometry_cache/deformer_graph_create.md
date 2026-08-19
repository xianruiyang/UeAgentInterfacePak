---
command: deformer_graph_create
category: deformer_mldeformer_geometry_cache
title: Deformer Graph Folder Workflow
summary: 创建空 Deformer Graph 资产
aliases: []
tags: [deformer_mldeformer_geometry_cache]
status: active
---

# `deformer_graph_create`

## LLM Compact

- status: active.
- purpose: 创建空 Deformer Graph 资产
- key_inputs: `asset_path`, `class_path`, `save_after_create`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `class_path`：UE class path；未传时部分命令会按 `kind` 推导。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
