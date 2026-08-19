---
command: skeletal_mesh_validate_folder
category: skeletal_mesh_folder_format
title: Skeletal Mesh 单文件校验
summary: 通过统一 preflight 校验 index.hjson，不写入资产
aliases: []
tags: [skeletal_mesh, animation, authoring, validate, hjson]
status: active
---

# `skeletal_mesh_validate_folder`

## LLM Compact

- 对完整 workspace 执行只读加载、exact-file、身份、依赖、领域文档和共享属性 preflight。
- 不应用 mutation、不编译、不保存。
- `no_op` 表示 authoring 状态是否无变化，与执行链是否需要编译或保存分开。
- Validate 成功只证明输入可执行，不代表资产已经写入。

## Parameters

- `folder_path`：必填，只包含 `index.hjson` 的 workspace 根目录。
- `asset_path`：可选，目标 Skeletal Mesh 身份断言。

## Returns

- `status`：`ready` 或 `failed`。
- `asset_path`、`requested_operation`、`units_checked`。
- `asset_exists`、`would_create`、`no_op`、`planned`。
- 失败时返回 `error_code` 和 `error_detail`。

## Validation

`status=ready` 后才进入 apply；若 `no_op=true`，表示当前 HJSON 与 UE authoring 状态一致。

