---
command: static_mesh_get_local_corners
category: static_mesh_enhanced_input
title: StaticMesh 文件夹式 HJSON 主流程
summary: 读取局部包围盒 8 个角点
aliases: []
tags: [static_mesh_enhanced_input]
status: active
---

# `static_mesh_get_local_corners`

## LLM Compact

- status: active.
- purpose: 读取局部包围盒 8 个角点
- key_inputs: `asset_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增这两个命令的目的，是让脚本在批量搭建和对齐时少解析无关字段
- note: 只想知道模型尺寸、中心、包围盒：用 `static_mesh_get_bounds`
- note: 想做角点级几何判断：用 `static_mesh_get_local_corners`
- note: 想看完整网格摘要：用 `static_mesh_get_info`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增这两个命令的目的，是让脚本在批量搭建和对齐时少解析无关字段
- 只想知道模型尺寸、中心、包围盒：用 `static_mesh_get_bounds`
- 想做角点级几何判断：用 `static_mesh_get_local_corners`
- 想看完整网格摘要：用 `static_mesh_get_info`

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
