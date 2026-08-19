---
command: skeletal_mesh_validate_morph_targets
category: skeletal_mesh_folder_format
title: 命令
summary: 校验 Morph Target 与 LOD/数量摘要
aliases: []
tags: [skeletal_mesh_folder_format]
status: active
---

# `skeletal_mesh_validate_morph_targets`

## LLM Compact

- status: active.
- purpose: 校验 Morph Target 与 LOD/数量摘要
- key_inputs: `asset_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
