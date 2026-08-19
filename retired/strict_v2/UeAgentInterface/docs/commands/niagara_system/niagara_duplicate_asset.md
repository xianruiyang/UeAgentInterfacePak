---
command: niagara_duplicate_asset
category: niagara_system
title: 资产级操作
summary: 复制 Niagara 资产
aliases: []
tags: [niagara_system]
status: active
---

# `niagara_duplicate_asset`

## LLM Compact

- status: active.
- purpose: 复制 Niagara 资产
- key_inputs: `source_asset_path`, `target_asset_path`
- key_returns: `source_asset_path`, `target_asset_path`, `target_object_path`, `asset_kind`, `saved`, `opened_editor`, `repaired_emitter_version_count`。
- note: `source_asset_path` 使用 `mounted_read`，可读取 `/Game`、`/Engine` 和插件 Content mount；`target_asset_path` 使用 `project_write`，只能写入 `/Game`。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `source_asset_path`：只读源 Niagara 资产。接受规范化的 `/Game`、`/Engine` 和插件 Content mount 路径，例如 `/Niagara/...`；实际挂载、存在性和 Niagara 类型由 UE 运行时验证。
- `target_asset_path`：复制目标 package 路径，只允许 `/Game/...`。

## Returns

- `source_asset_path`、`target_asset_path`、`target_object_path`、`asset_kind`。
- `saved`、`opened_editor`、`repaired_emitter_version_count`。

## Validation

复制后读取 `target_asset_path` 和 `asset_kind`，再用对应 Niagara readback 验证目标资产。非法或不存在的 source 必须在创建 target package 前失败；非 `/Game` target 必须在 HTTP 前被 typed preflight 拒绝。
