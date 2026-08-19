---
command: asset_move
category: core_level
title: Core / Session
summary: 通过 UE AssetTools 移动或重命名资产
aliases: []
tags: [core_level]
status: active
---

# `asset_move`

## LLM Compact

- status: active.
- purpose: 通过 UE AssetTools 移动或重命名资产
- key_inputs: `source_asset_path` / `asset_path`, `destination_asset_path`, `destination_folder`, `destination_name`, `dry_run`, `allow_destructive`, `overwrite_existing`, `save_after_move`
- key_returns: `source_asset_path`, `asset_path`, `destination_folder`, `destination_name`, `changed`, `saved`, `dry_run`, `allow_destructive`, `overwrite_existing`, `source_asset_exists_after`, `source_redirector_exists_after`, `target_asset_exists_after`
- behavior: 默认 `dry_run=true`；真实移动必须显式传 `dry_run=false` 和 `allow_destructive=true`。覆盖已有目标还必须单独显式传 `overwrite_existing=true`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- `allow_destructive` 只授权移动/重命名，不授权覆盖目标；`overwrite_existing` 只放宽目标已存在保护，不能替代移动授权。
- AssetTools 移动后源位置可能保留 `ObjectRedirector`。`source_asset_exists_after=false` 表示原资产身份已离开源路径；Redirector 是否仍存在由 `source_redirector_exists_after` 单独报告。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `dry_run`：默认 `true`；只解析源和目标并报告 `would_move=true`，不调用 AssetTools Rename。
- `allow_destructive`：默认 `false`；`dry_run=false` 时必须显式为 `true`，否则返回 `allow_destructive_required`，源和目标保持不变。
- `destination_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `destination_folder`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `destination_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `overwrite_existing`：默认 `false`；目标已存在时返回 `destination_asset_already_exists`。只有显式 `true` 才允许进入覆盖路径。
- `save_after_move`：默认 `true`。
- `source_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Returns

- `source_asset_path`：移动前规范化源包路径；`asset_path` / `object_path` 是目标读回。
- `changed` / `saved` / `dry_run` / `allow_destructive` / `overwrite_existing`。
- `source_asset_exists_after`：源路径是否仍有非 Redirector 资产。
- `source_redirector_exists_after`：源位置是否保留 Redirector。
- `target_asset_exists_after`：目标资产存在性读回。

## Validation

默认请求和缺少授权的执行请求后，应确认源仍存在、目标不存在。真实移动后必须确认 `changed=true`、`source_asset_exists_after=false`、`target_asset_exists_after=true`；需要移除 Redirector 时再单独执行带安全确认的 `asset_fixup_redirectors`。
