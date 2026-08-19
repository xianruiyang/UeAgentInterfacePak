---
command: niagara_export_folder
category: niagara_folder_format
title: 将 Niagara System 导出为统一 index.hjson workspace
summary: 将 Niagara System 导出为统一 index.hjson workspace
aliases: []
tags: [niagara_folder_format, hjson_authoring, unified_apply_export]
status: active
---

# `niagara_export_folder`

## LLM Compact

- purpose: 将 Niagara System 导出为统一 index.hjson workspace
- key_inputs: `asset_path`, `folder_path`, `profile`
- workspace: 单文件 `index.hjson`
- contract: `uai.export.niagara.asset`
- backend: `shared snapshot -> projector -> writer`

## Parameters

- `asset_path`：必填，目标资产路径。
- `folder_path`：可选；省略时写入 `Saved/UeAssetFolders/NiagaraSystem/<asset path>/`。
- `profile`：可选，默认 `llm_authoring`；支持 `llm_authoring`、`readback`、`debug`、`validation`。

Profile 预算按输出职责分级：`llm_authoring=16777216`、`readback=16777216`、`debug=33554432`、`validation=32768` proxy token。可再次导入的 authoring/readback workspace 是 durable artifact，其 proxy gate 不得比共享 `64 MiB` canonical output resource budget 更早拒绝合法结构；token 节省发生在 response projection，不裁剪完整 Niagara System workspace。`validation` 仍是只读紧凑投影。

## Behavior

- `modules.*.inputs` 与递归 `dynamic_inputs.*.inputs` 使用同一输入源契约。字面量保持 `value_kind` 与 canonical `value`；已连接 Niagara 参数导出为 `{ value: { source: linked_input, linked_parameter: Particles.RibbonLinkOrder } }`。Apply 通过 Niagara graph 语义创建或替换链接，并按参数名读回校验。
- 同一 owner input 的字面量、linked input 与 dynamic input 互斥；不得同时声明多个来源。

- 从 `niagara.state` 捕获共享 snapshot，经 `uai.export.niagara.asset`、共享 projector 和共享 HJSON writer 写出。
- 输出目录由 Export 独占并在写入前重置；只生成一个 `index.hjson`，不生成 JSON 兼容文件。
- Export 不读取 Apply contract，不修改 UObject、Package dirty 状态或资产内容。
- `llm_authoring` 输出 `operation: update`、`target`，以及可用的 `provider_extension.stages`。
- 当前可编辑投影覆盖 emitter/stage identity、module script/order/input、递归 dynamic input、System User Parameter，以及存在时的 Renderer、Event Handler 身份和 profile 允许的结构化属性。Data Interface 的任意对象拓扑和任意 Script graph topology 不在本纵切的 Export 范围内。
- 本命令只接受 `asset_kind=system`；standalone Emitter 或 Script 返回 `niagara_asset_kind_conflict`，应改用各自的 Export 命令，不得通过关闭 preflight 绕过。

## Returns

- Workspace 元数据：`schema`、`status`、`contract_id`、`contract_version`、`profile_id`、`workspace_root`、`token_budget`、`metrics`、`files`、`written_files`。
- 命令摘要：`asset_path`、`asset_kind`、`folder_path`、`file_count`。

## Validation

导出后解析 `index.hjson`；写入后再次调用本命令并比较结构化结果。不要依赖已删除的 `asset.hjson`、`settings/`、`emitters/`、`graphs/` 或 `validation/coverage_report.hjson`。
