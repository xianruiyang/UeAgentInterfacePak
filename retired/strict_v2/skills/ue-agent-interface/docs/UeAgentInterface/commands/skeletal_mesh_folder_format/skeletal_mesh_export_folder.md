---
command: skeletal_mesh_export_folder
category: skeletal_mesh_folder_format
title: Skeletal Mesh 单文件导出
summary: 通过统一 Animation 快照管线导出 index.hjson
aliases: []
tags: [skeletal_mesh, animation, authoring, export, hjson]
status: active
---

# `skeletal_mesh_export_folder`

## LLM Compact

- 将一个 Skeletal Mesh 导出为只包含 `index.hjson` 的 workspace。
- 默认 profile 为 `llm_authoring`；另支持 `readback`、`debug`、`validation`。
- Export 只由 Export contract 决定，不限制 Apply 可以接受的合法输入。
- 成功后检查 `status=written`、`written_files` 和 `workspace_root`。

## Workspace Contract

- workspace 只允许 `index.hjson`，不接受旧多文件目录、旧 JSON 或 legacy 字段别名。
- 根结构包含 `operation`、`target`、可选 `properties` 和 `provider_extension`。
- `properties` 使用共享结构化属性值；`AssetImportData` 等 UE-owned 子对象导出为递归 `owned_object`，不依赖原资产内部对象路径。
- `provider_extension` 保存 `settings`、`materials`、`sockets`、`summary`、`lods`、`sections`、`morph_targets`、`import_data`。
- summary/LOD/section 等只读内容用于识别、校验和读回；显式提交冲突值会在 preflight 被拒绝。
- 默认 profile 不输出 `operations`、`control_type`、`category_path`；`value_text` 只在 `readback/debug` profile 保留。

## Parameters

- `asset_path`：必填，目标 Skeletal Mesh 的 `/Game/...` 资产路径。
- `folder_path`：可选，输出 workspace 根目录。
- `profile`：可选，`llm_authoring|readback|debug|validation`。

## Returns

- `status`：`written` 或 `failed`。
- `asset_path`、`workspace_root`、`profile_id`。
- `written_files`：成功时只包含 `index.hjson`。
- `contract_id`、`contract_version`、`metrics`、`token_budget`。
- 失败时可返回 `error_code`、`error_detail`、`file_id`、`field_id`。

## Validation

导出后使用 `skeletal_mesh_validate_folder` 做只读预检；需要确认真实 UE 状态时，再 apply 并调用 Skeletal Mesh 读回命令。

