---
command: geometry_cache_validate_against_skeletal_mesh
category: deformer_mldeformer_geometry_cache
title: Geometry Cache / Alembic
summary: 校验 Geometry Cache 与 SkeletalMesh 引用关系
aliases: []
tags: [deformer_mldeformer_geometry_cache]
status: active
---

# `geometry_cache_validate_against_skeletal_mesh`

## LLM Compact

- status: active.
- purpose: 校验 Geometry Cache 与 SkeletalMesh 引用关系
- key_inputs: `geometry_cache`, `geometry_cache_path`, `skeletal_mesh`, `skeletal_mesh_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `geometry_cache`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `geometry_cache_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `skeletal_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `skeletal_mesh_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
