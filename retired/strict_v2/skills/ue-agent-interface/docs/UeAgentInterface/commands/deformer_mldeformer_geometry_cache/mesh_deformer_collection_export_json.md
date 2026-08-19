---
command: mesh_deformer_collection_export_json
category: deformer_mldeformer_geometry_cache
title: Deformer Source Library / Mesh Deformer Collection
summary: 导出 Collection 单文件属性 JSON
aliases: []
tags: [deformer_mldeformer_geometry_cache]
status: active
---

# `mesh_deformer_collection_export_json`

## LLM Compact

- status: active.
- purpose: 导出 Collection 单文件属性 JSON
- key_inputs: `asset_path`, `output_file`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
