---
command: skeletal_mesh_preview_morph_target
category: skeletal_mesh_folder_format
title: 命令
summary: 用临时 SkeletalMeshComponent 设置 Morph 权重做无 UI 预览校验
aliases: []
tags: [skeletal_mesh_folder_format]
status: active
---

# `skeletal_mesh_preview_morph_target`

## LLM Compact

- status: active.
- purpose: 用临时 SkeletalMeshComponent 设置 Morph 权重做无 UI 预览校验
- key_inputs: `asset_path`, `name`, `morph_target`, `weight`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `name`：对象名称；创建时应保持稳定，避免同名歧义。
- `morph_target`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `weight`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
