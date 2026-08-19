---
command: material_create
category: material
title: 资产与编译
summary: 创建 `UMaterial`
aliases: []
tags: [material]
status: active
---

# `material_create`

## LLM Compact

- status: active.
- purpose: 创建 `UMaterial`
- key_inputs: `asset_path`, `compile_after_create`, `save_after_create`
- key_returns: `asset_path`, `object_path`, `class`, `compiled`, `saved`, `apply_status`, `resolved_operation`
- note: 创建通过统一 Material asset Apply provider；缺失初值来自 UE factory 默认机制，成功前完成状态读回。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 创建通过 `uai.apply_input.material.asset` 进入统一 preflight、事务、默认值和 readback；不会在命令层复制一套材质创建逻辑。

## Parameters

- `asset_path`：待创建的 `/Game/...` 资产路径。
- `compile_after_create`：创建并写入后是否编译，默认 `true`。
- `save_after_create`：创建并验证后是否保存，默认 `true`。

## Returns

- `asset_path`、`object_path`、`class`：创建后的实际对象身份。
- `compiled`、`saved`：本次调用请求并完成的生命周期操作。
- `apply_status`、`resolved_operation`：统一 Apply 的执行和 operation 解析结果。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
