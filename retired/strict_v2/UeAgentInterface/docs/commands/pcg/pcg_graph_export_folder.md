---
command: pcg_graph_export_folder
category: pcg
title: PCG Graph HJSON Export
summary: 通过统一只读快照管线导出单个 PCG Graph index.hjson
aliases: []
tags: [pcg, authoring, hjson, export]
status: active
---

# `pcg_graph_export_folder`

## LLM Compact

- Export 只写 `<folder_path>/index.hjson`，不生成 manifest、asset、graph、layout、details 或 references 中间目录。
- Export 复用 PCG 状态采集、语义投影、profile 和 HJSON writer，不调用 Apply，也不修改资产。
- 输出只由 Export profile 与投影规则决定；Apply 可接受的控制字段不要求出现在导出文件中。
- 节点、pin、edge、参数和可编辑属性均使用统一稳定身份与 typed value。

## Exported Shape

`index.hjson` 包含：

- `operation: update`。
- `target.asset_kind: pcg_graph` 与规范化 `target.asset_path`。
- `properties`：可编辑 PCG Graph 根属性。
- `provider_extension.graph.nodes`：以稳定节点身份为 key，包含 `role` 或 `settings_class`、二维 `position`、节点 Settings `properties`、`input_pins` 和 `output_pins`。
- `provider_extension.graph.edges`：以 `FromNode:FromPin->ToNode:ToPin` 为 key 的结构化连接。
- `provider_extension.graph.parameters`：结构化 property bag。

导出不会添加 `replace_nodes`、`compile`、`save` 等 Apply 控制，也不会输出 legacy 位置或兼容副本。

## Parameters

- `asset_path`：PCG Graph 资产；也接受 `graph`、`graph_asset_path`。
- `folder_path`：输出目录；也接受命令参数别名 `input_folder`、`folder`。
- `profile`：`llm_authoring | readback | debug | validation`，默认 `llm_authoring`。

## Result And Verification

结果包含 `contract_id`、`contract_version`、`profile_id`、`workspace_root`、`files`、`written_files` 和 HJSON 指标。成功时 `written_files` 必须只有一个 `index.hjson`；文件可由 `pcg_graph_validate_folder` 直接预检，并可在不修改内容时完成 deterministic export/apply/export round-trip。
