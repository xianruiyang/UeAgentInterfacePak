---
command: asset_duplicate
category: core_level
title: Core / Session
summary: 复制资产到指定路径
aliases: []
tags: [core_level]
status: active
---

# `asset_duplicate`

## LLM Compact

- status: active.
- purpose: 复制资产到指定路径
- key_inputs: `destination_asset_path`, `save_after_duplicate`, `source_asset_path`
- key_returns: `source_asset_path`, `destination_asset_path`, `asset_path`, `object_path`, `class`, `saved`。
- note: source 使用 `mounted_read`，允许插件 Content mount；destination 使用 `project_write`，只能写入 `/Game`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `destination_asset_path`：复制目标 package 路径，只允许 `/Game/...`。
- `save_after_duplicate`：布尔/开关字段；默认值以本命令契约为准。
- `source_asset_path`：只读源资产，接受 `/Game`、`/Engine` 和插件 Content mount；实际存在性由 UE 运行时验证。

## Returns

- `source_asset_path`、`destination_asset_path`、`asset_path`、`object_path`、`class`、`saved`。

## Validation

复制后读取 `destination_asset_path`、`class` 和 `saved`，并用适合目标资产类型的 readback 验证结果。非 `/Game` destination 必须在 HTTP 前被 typed preflight 拒绝。
