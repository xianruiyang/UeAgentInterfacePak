---
command: blueprint_export_folder
category: blueprint
title: Blueprint 统一 HJSON 导出
summary: 通过只读快照导出任意 Blueprintable 类的单文件 authoring workspace
aliases: []
tags: [blueprint, authoring, hjson]
status: active
---

# `blueprint_export_folder`

将 Blueprint 导出为一个 `index.hjson`。命令只定位资产和选择 Export profile；所有内容字段由独立的 `uai.export.blueprint.asset` contract 决定。Actor Blueprint 与其他 Blueprint 共用资产、class defaults、成员和图结构，只有 Actor Blueprint 扩展导出 SCS/CDO components。

## Parameters

- `asset_path`：目标 Blueprint 包路径；父类必须是 UE 允许创建 Blueprint 的类。
- `output_folder`：可选输出 workspace。机器 verification readback 会把它改写到 request-scoped owned root，不能复用 Apply 输入目录。
- `profile`：`llm_authoring`、`readback`、`debug` 或 `validation`，默认 `llm_authoring`。

## Workspace

`index.hjson` 包含 `operation`、`target`、Blueprint 可编辑属性以及 `provider_extension`。`provider_extension` 内联表达 parent class、class defaults、variables、delegates、event/function/macro graphs、nodes、pin defaults 和 edges；Actor Blueprint 额外包含 SCS/CDO components。

成员、组件、图和节点集合使用稳定 key 的 object map。GUID 可用时以 GUID 建立 identity；只有 UE 对象没有 GUID 时才使用 name/kind fallback。属性值继续使用共享结构化 value codec。

Export 只消费 `StateSnapshot`。compound projection 不读取 UObject，Export 前后资产状态和 dirty state 必须保持不变。默认 profile 不输出 `operations`、`control_type`、冗余 `category_path` 或 `value_text`。

## Returns

返回 `uai.export_workspace_result.v1` 的共享 workspace writer 结果，包括相对 `entry_file`、完整 `written_relative_files`、绝对 `written_files` 和 `publisher`，并补充 `asset_path`、`asset_kind`、`folder_path` 和 `file_count`。`asset_kind` 对 Actor 子类为 `actor_blueprint`，其他 Blueprintable 类为 `blueprint`；当前 `file_count` 为 `1`。

## Validation

检查 `status=written`、`file_count=1`，并验证 request/session/freshness、完整相对文件集、size/hash、HJSON parse、identity/profile/contract 和 publisher receipt。需要验证可编辑性时执行 `Export -> Apply -> 独立 request-owned Export`，比较结构化结果。
