---
command: volume_texture_apply_folder
category: texture_render_target_media
title: Reflection HJSON Authoring
summary: 通过统一 Reflection HJSON authoring 域执行 `volume_texture` 的 `apply`。
aliases: []
tags: [texture_render_target_media, reflection_authoring]
status: active
---

# `volume_texture_apply_folder`

## LLM Compact

- status: active
- purpose: 对完整目录或单 HJSON source 执行 preflight、事务 mutation、读回验证和失败回滚。
- profile: `volume_texture`
- operation: `apply`
- canonical_format: 单文件 `index.hjson`，字段为 `operation`、`target`、`properties`。
- implementation: `Domains/Reflection/Authoring`；不调用旧 profile serializer/reader/writer。

## Parameters

- `folder_path` / `input_folder` / `json_folder` 或 `json_file` / `input_file` 至少提供一个；`asset_path` 是可选 expected identity；`save` 可覆盖 source 保存策略。

## HJSON Contract

- `target.asset_path` 是稳定 identity，`target.asset_kind` 必须是 `volume_texture`。
- `target.class_path` 可作为具体类约束；创建时必须是 profile 允许的非抽象类。
- `properties[]` 使用共享递归 UObject/UStruct/container property descriptor。
- 目录 source 只允许 `index.hjson`；未知文件、重复 target、未解析依赖和 cycle 直接失败。
- 完整规则见 [Reflection Asset Authoring Domain](../../hjson-authoring/10_ReflectionAssetDomain.md)。

## Returns

- 返回 `status`、`phase`、`resolved_operation`、mutation 数、create/remove/no-op 和 rollback 状态。

## Validation

Apply 内部强制写后 shared snapshot verification；失败时检查 `error_code`、`error_detail` 和 `phase`。
