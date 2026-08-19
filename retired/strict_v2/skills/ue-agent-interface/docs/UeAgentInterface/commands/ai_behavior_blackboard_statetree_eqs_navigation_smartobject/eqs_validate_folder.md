---
command: eqs_validate_folder
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: Reflection HJSON Authoring
summary: 通过统一 Reflection HJSON authoring 域执行 `eqs` 的 `validate`。
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject, reflection_authoring]
status: active
---

# `eqs_validate_folder`

## LLM Compact

- status: active
- purpose: 只执行完整 workspace load、contract 检查和 preflight，不修改 UE 状态。
- profile: `eqs`
- operation: `validate`
- canonical_format: 单文件 `index.hjson`，字段为 `operation`、`target`、`properties`。
- implementation: `Domains/Reflection/Authoring`；不调用旧 profile serializer/reader/writer。

## Parameters

- `folder_path` / `input_folder` / `json_folder` 或 `json_file` / `input_file` 至少提供一个；`asset_path` 是可选 expected identity。

## HJSON Contract

- `target.asset_path` 是稳定 identity，`target.asset_kind` 必须是 `eqs`。
- `target.class_path` 可作为具体类约束；创建时必须是 profile 允许的非抽象类。
- `properties[]` 使用共享递归 UObject/UStruct/container property descriptor。
- 目录 source 只允许 `index.hjson`；未知文件、重复 target、未解析依赖和 cycle 直接失败。
- 完整规则见 [Reflection Asset Authoring Domain](../../hjson-authoring/10_ReflectionAssetDomain.md)。

## Returns

- 返回 `ready/failed`、source operation、目标存在性、would-create、no-op 和 preflight 单元数。

## Validation

该命令只验证 authoring source，不替代领域 `validate_setup`、`validate_usage` 或 runtime probe。
