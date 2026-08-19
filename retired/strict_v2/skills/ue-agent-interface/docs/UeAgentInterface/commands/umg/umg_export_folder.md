---
command: umg_export_folder
category: umg
title: UMG 统一 HJSON 导出
summary: 通过只读快照导出 Widget Blueprint 的单文件 authoring workspace
aliases: []
tags: [umg, authoring, hjson]
status: active
---

# `umg_export_folder`

将 Widget Blueprint 导出为一个 `index.hjson`。命令只负责定位资产、选择目录和 Export profile；输出字段由独立的 `uai.export.umg.asset` contract 决定。

## Parameters

- `asset_path`：目标 Widget Blueprint 包路径。
- `folder_path`：可选输出目录；省略时使用 `Saved/UeAssetFolders/WidgetBlueprint` 下的资产目录。
- `profile`：`llm_authoring`、`readback`、`debug` 或 `validation`，默认 `llm_authoring`。

## Workspace

`index.hjson` 包含 `operation`、`target` 和 `provider_extension`。扩展内联表达 parent class、class defaults、variables、delegates、Widget tree、native PanelSlot、bindings、animations 和 Blueprint graphs。

Widget、binding、animation、graph 和 node 集合使用稳定 key 的 object map。Widget GUID 可用时作为 key；仅在 UE 没有 GUID 时使用 `widget:<name>`。Widget 与 Slot 属性统一使用结构化属性描述符和 canonical value codec；基本类型为 `{ literal: ... }`，常见向量与颜色为 `{ components: [...] }`。

Export 只消费 `StateSnapshot`，不得修改资产或 dirty state。默认 profile 不输出 `operations`、`control_type`、冗余 `category_path` 或 `value_text`。不再生成或接受旧的 `asset.hjson`、`widget_tree.hjson`、`members/**`、`bindings/**`、`animations/**` 和 `graphs/**` 主结构。

## Returns

返回规范化 `asset_path`、`folder_path`、`root_path`、实际 `profile`、`file_count`、`character_count` 和 `estimated_tokens`。当前 `file_count` 必须为 `1`。

## Validation

检查 `file_count=1`，并用安全 HJSON parser 解析 `index.hjson`。需要验证可编辑性时执行 `Export -> Apply -> Export`，比较 Widget、native Slot 和相关稳定 identity。
