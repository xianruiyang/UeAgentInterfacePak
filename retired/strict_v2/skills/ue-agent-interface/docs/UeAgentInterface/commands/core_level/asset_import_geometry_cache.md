---
command: asset_import_geometry_cache
category: core_level
title: `asset_import_geometry_cache`
summary: 导入 Geometry Cache / Alembic
aliases: []
tags: [core_level]
status: active
---

# `asset_import_geometry_cache`

## LLM Compact

- status: active.
- purpose: 导入 Geometry Cache / Alembic
- key_inputs: `source_file`, `destination_path`, `allow_overwrite`, `replace_existing`
- key_returns: `source_file`, `destination_path`, `imported_assets[]`, `imported_asset_count`, `replace_existing`, `allow_overwrite`, `plugin_status`
- note: 通过 UE 自动导入管线导入缓存资产。
- note: 返回 `imported_assets[]`、`imported_asset_count` 和 `plugin_status`。
- note: Geometry Cache 内部逐帧顶点数据不通过 JSON 编辑；导入后使用 `geometry_cache_get_info` 与 `geometry_cache_validate_against_skeletal_mesh` 做验证。详见 `18_Deformer_MLDeformer_GeometryCache.md`。
- note: 默认不覆盖已有 Geometry Cache。只有显式 `allow_overwrite=true` 或兼容确认 `replace_existing=true` 才允许覆盖；非 boolean 确认值返回硬错误。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 通过 UE 自动导入管线导入缓存资产。
- 返回 `imported_assets[]`、`imported_asset_count` 和 `plugin_status`。
- Geometry Cache 内部逐帧顶点数据不通过 JSON 编辑；导入后使用 `geometry_cache_get_info` 与 `geometry_cache_validate_against_skeletal_mesh` 做验证。详见 `18_Deformer_MLDeformer_GeometryCache.md`。
- `allow_overwrite` 与 `replace_existing` 是同一覆盖确认语义：任一显式为 `true` 时启用覆盖；两者都省略或为 `false` 时不覆盖已有资产。

## Parameters

- `destination_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `source_file`：文件路径字段；长 JSON/结果优先走文件。
- `allow_overwrite`：默认 `false`；显式允许覆盖同名已有 Geometry Cache。
- `replace_existing`：默认 `false`；兼容覆盖确认，显式 `true` 等价于 `allow_overwrite=true`。

## Returns

- `source_file` / `destination_path`。
- `imported_assets[]` / `imported_asset_count` / `plugin_status`。
- `replace_existing` / `allow_overwrite`：本次导入实际采用的覆盖策略。

## Validation

先检查 `replace_existing` / `allow_overwrite` 是否符合请求，再用 `geometry_cache_get_info` 与 `geometry_cache_validate_against_skeletal_mesh` 读回导入资产；不能只依据 `imported_asset_count` 验收内容兼容性。
