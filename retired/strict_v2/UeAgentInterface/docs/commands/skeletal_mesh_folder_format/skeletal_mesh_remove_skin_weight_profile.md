---
command: skeletal_mesh_remove_skin_weight_profile
category: skeletal_mesh_folder_format
title: 命令
summary: 删除 Skin Weight Profile 或指定 LOD 的 profile 数据
aliases: []
tags: [skeletal_mesh_folder_format]
status: active
---

# `skeletal_mesh_remove_skin_weight_profile`

## LLM Compact

- status: active.
- purpose: 删除 Skin Weight Profile 或指定 LOD 的 profile 数据
- key_inputs: `asset_path`, `allow_destructive`, `lod_index`, `profile_name`, `save_after_apply`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- note: 该命令会删除整个 Skin Weight Profile 或指定 LOD 数据；`allow_destructive` 默认 false，未显式设为 true 时返回 `allow_destructive_required`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `allow_destructive`：破坏性删除确认；默认 `false`，执行删除必须显式设为 `true`。
- `lod_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `profile_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
