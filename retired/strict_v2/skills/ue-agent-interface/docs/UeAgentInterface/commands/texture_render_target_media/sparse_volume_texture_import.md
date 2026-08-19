---
command: sparse_volume_texture_import
category: texture_render_target_media
title: SVT / TextureGraph / 2D 派生资产
summary: 导入或重导入 OpenVDB/SVT。
aliases: []
tags: [texture_render_target_media]
status: active
---

# `sparse_volume_texture_import`

## LLM Compact

- status: active.
- purpose: 导入或重导入 OpenVDB/SVT。
- key_inputs: `source_file`, `destination_path`, `destination_name`, `replace_existing`, `allow_overwrite`, `save_after_import`.
- key_returns: `asset_path`, `source_file`, `replace_existing`, `allow_overwrite`, `frame_count`, `resolution`, `attributes`.
- safety: `replace_existing` 和 `allow_overwrite` 默认均为 `false`；目标已存在且未显式允许覆盖时返回 `import_target_exists_requires_allow_overwrite`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `source_file`：OpenVDB/SVT 源文件路径，必填。
- `destination_path`：目标 UE package 文件夹，必填。
- `destination_name`：可选目标资产名；省略时使用源文件名。
- `replace_existing` / `allow_overwrite`：显式覆盖确认，默认 `false`。
- `save_after_import`：导入后是否保存，默认 `true`。

## Returns

- 返回导入资产路径、源文件、覆盖决策及 SVT 结构化读回信息。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
