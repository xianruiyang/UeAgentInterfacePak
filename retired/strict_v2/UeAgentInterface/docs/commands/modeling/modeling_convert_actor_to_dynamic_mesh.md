---
command: modeling_convert_actor_to_dynamic_mesh
category: modeling
title: 将选中对象转换为 Dynamic Mesh Actor
summary: 强制使用 UE Modeling 的 Dynamic Mesh Actor 输出类型，并返回实际创建的 Actor
aliases: []
tags: [modeling]
status: active
---

# `modeling_convert_actor_to_dynamic_mesh`

## LLM Compact

- status: active.
- purpose: 将当前选中对象转换为新的 Dynamic Mesh Actor。
- key_inputs: `accept`, `tool_properties`
- key_returns: `accepted`, `output_type_policy`, `created_actor`
- validation: `accept=true` 时必须读回带 `UDynamicMeshComponent` 的实际输出 Actor。

## Authoring Notes

- 本命令固定 `output_type_policy=dynamic_mesh_actor_required`，不会继承 Modeling 全局默认输出类型。
- `tool_properties` 可设置普通工具属性，但不得覆盖 `CreateMeshObjectTypeProperties.OutputType`。
- 如果工具没有暴露 UE 原生的输出类型属性集，命令会在 Accept 前失败。

## Parameters

- `accept`：为 `true` 时接受工具并生成对象；为 `false` 时只启动工具。
- `tool_properties`：Modeling 工具属性数组，不能设置 `OutputType`。

## Returns

- `output_type_policy`：固定为 `dynamic_mesh_actor_required`。
- `default_output_type`：UE Modeling 实际应用的 Dynamic Mesh Actor 类型标识。
- `created_actor`：`accept=true` 后实际创建的 Dynamic Mesh Actor 摘要。

## Validation

`accept=true` 后同时校验命令返回与输出 Actor 的 `UDynamicMeshComponent`。命令成功但未得到真实动态网格输出视为失败。
