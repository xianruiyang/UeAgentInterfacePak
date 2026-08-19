---
command: asset_import_texture
category: core_level
title: `asset_import_texture`
summary: 导入外部贴图为 Texture2D
aliases: []
tags: [core_level]
status: active
---

# `asset_import_texture`

## LLM Compact

- status: active.
- purpose: 导入外部贴图为 Texture2D
- key_inputs: `source_filename`, `destination_path`, `destination_name`, `allow_overwrite`, `replace_existing`, `replace_existing_settings`, `save_after_import`, `srgb`, `compression_settings`, `mip_gen_settings`, `lod_group`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 通用导入字段：`imported_object_count`、`imported_objects[]`、`primary_asset_path` 等。
- note: 该命令只负责把外部贴图正式导入为 UE Texture2D，并在导入后回读关键属性；材质图、Niagara Renderer、SubUV 行列数等仍走对应资产的 JSON / folder workflow。
- note: 枚举字段解析失败、布尔字段类型错误、扩展名不支持、UE 工厂拒绝导入都会返回硬错误，不会静默忽略。
- note: 默认不覆盖已有资产。只有显式 `allow_overwrite=true` 或兼容确认 `replace_existing=true` 才允许覆盖；二者必须是 JSON boolean。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 通用导入字段：`imported_object_count`、`imported_objects[]`、`primary_asset_path` 等。
- 该命令只负责把外部贴图正式导入为 UE Texture2D，并在导入后回读关键属性；材质图、Niagara Renderer、SubUV 行列数等仍走对应资产的 JSON / folder workflow。
- 枚举字段解析失败、布尔字段类型错误、扩展名不支持、UE 工厂拒绝导入都会返回硬错误，不会静默忽略。
- `allow_overwrite` 与 `replace_existing` 是同一覆盖确认语义：任一显式为 `true` 时启用覆盖；两者都省略或为 `false` 时 `bReplaceExisting=false`，不得覆盖已有 Texture2D。

## Parameters

- `destination_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `srgb`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `compression_settings`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `mip_gen_settings`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `lod_group`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `destination_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `source_filename`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `allow_overwrite`：默认 `false`；显式允许覆盖同名已有资产。
- `replace_existing`：默认 `false`；兼容覆盖确认，显式 `true` 等价于 `allow_overwrite=true`。
- `replace_existing_settings`：默认 `true`；仅控制覆盖时的现有设置处理，不构成覆盖授权。
- `save_after_import`：默认 `true`。

## Returns

- 通用导入结果：`imported_object_count`、`imported_objects[]`、`primary_asset_path`。
- 安全读回：`replace_existing`、`allow_overwrite`、`replace_existing_settings`、`save_after_import`。
- Texture2D 读回：`texture_asset_path`、`texture_size_x`、`texture_size_y`、`srgb`、`compression_settings`、`mip_gen_settings`、`lod_group`。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
