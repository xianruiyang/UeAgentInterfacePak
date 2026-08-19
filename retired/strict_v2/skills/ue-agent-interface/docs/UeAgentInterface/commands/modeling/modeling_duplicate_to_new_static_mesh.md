---
command: modeling_duplicate_to_new_static_mesh
category: modeling
title: 将选中网格复制为新的 Static Mesh 资产
summary: 强制使用 UE Modeling 的 Static Mesh 输出类型，并返回实际创建的 Actor 与资产路径
aliases: []
tags: [modeling]
status: active
---

# `modeling_duplicate_to_new_static_mesh`

## LLM Compact

- status: active.
- purpose: 将当前选中的单个网格对象复制为新的 Static Mesh 资产。
- key_inputs: `accept`, `tool_properties`
- key_returns: `accepted`, `output_type_policy`, `created_actor`, `created_asset_path`
- validation: `accept=true` 时必须读回 `created_actor.class=/Script/Engine.StaticMeshActor`，并确认 `created_asset_path` 可加载为 `UStaticMesh`。

## Authoring Notes

- 本命令固定 `output_type_policy=static_mesh_required`，不会继承 Modeling 全局默认输出类型。
- `tool_properties` 可设置 `OutputNewName` 等普通工具属性，但不得覆盖 `CreateMeshObjectTypeProperties.OutputType`；输出类型由命令语义唯一决定。
- 如果工具没有暴露 UE 原生的 `CreateMeshObjectTypeProperties`，命令会在 Accept 前失败，不会先生成错误类型的对象。

## Parameters

- `accept`：为 `true` 时接受工具并生成资产；为 `false` 时只启动工具。
- `tool_properties`：Modeling 工具属性数组。可设置名称等属性，不能设置 `OutputType`。

## Returns

- `output_type_policy`：固定为 `static_mesh_required`。
- `default_output_type`：UE Modeling 实际应用的 Static Mesh 类型标识。
- `created_actor`：`accept=true` 后实际创建的 `StaticMeshActor` 摘要。
- `created_asset_path`：`accept=true` 后实际创建的 `/Game/...` Static Mesh package path。

## Validation

`accept=true` 后同时校验命令返回、Actor 类型和 `created_asset_path` 的 `UStaticMesh` 读回。命令成功但缺少任一真实产物字段视为失败。
