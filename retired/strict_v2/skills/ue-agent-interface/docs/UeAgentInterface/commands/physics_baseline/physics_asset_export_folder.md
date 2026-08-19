---
command: physics_asset_export_folder
category: physics_baseline
title: Reflection HJSON Authoring
summary: 通过统一 Reflection HJSON authoring 域执行 `physics_asset` 的 `export`。
aliases: []
tags: [physics_baseline, reflection_authoring]
status: active
---

# `physics_asset_export_folder`

## LLM Compact

- status: active
- purpose: 导出真实 UE 资产状态为单文件 canonical HJSON workspace。
- profile: `physics_asset`
- operation: `export`
- canonical_format: 单文件 `index.hjson`，字段为 `operation`、`target`、`properties`。
- implementation: `Domains/Reflection/Authoring`；不调用旧 profile serializer/reader/writer。

## Parameters

- `asset_path` 必填；`profile` 可选；`folder_path`、`output_folder`、`output_file` 任选其一，省略时使用 profile 默认 workspace。

## HJSON Contract

- `target.asset_path` 是稳定 identity，`target.asset_kind` 必须是 `physics_asset`。
- `target.class_path` 可作为具体类约束；创建时必须是 profile 允许的非抽象类。
- `properties[]` 使用共享递归 UObject/UStruct/container property descriptor。
- 目录 source 只允许 `index.hjson`；未知文件、重复 target、未解析依赖和 cycle 直接失败。
- 完整规则见 [Reflection Asset Authoring Domain](../../hjson-authoring/10_ReflectionAssetDomain.md)。

## Returns

- 返回统一 export workspace result：`status`、`workspace_root`、`files`、`written_files`、`metrics`、`asset_path`。

## Validation

解析写出的 HJSON；需要继续编辑时对同一 workspace 执行对应 Apply，并以 Apply 内置 shared snapshot verification 为准。
