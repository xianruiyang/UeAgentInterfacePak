---
command: niagara_emitter_export_folder
category: niagara_emitter
title: 将 standalone Niagara Emitter 导出为统一 index.hjson workspace
summary: 将 standalone Niagara Emitter 导出为统一 index.hjson workspace
aliases: []
tags: [niagara_emitter, hjson_authoring, unified_apply_export]
status: active
---

# `niagara_emitter_export_folder`

## LLM Compact

- purpose: 将 standalone Niagara Emitter 导出为统一 index.hjson workspace
- key_inputs: `emitter_asset_path`（也接受 `asset_path` 作为定位别名）, `folder_path`, `profile`
- workspace: 单文件 `index.hjson`
- contract: `uai.export.niagara.asset`
- backend: `shared snapshot -> projector -> writer`

## Parameters

- `emitter_asset_path`（也接受 `asset_path` 作为定位别名）：必填，目标资产路径。
- `folder_path`：可选；省略时写入 `Saved/UeAssetFolders/NiagaraEmitter/<asset path>/`。
- `profile`：可选，默认 `llm_authoring`；支持 `llm_authoring`、`readback`、`debug`、`validation`。

Profile 预算按输出职责分级：`llm_authoring=196608`、`readback=196608`、`debug=393216`、`validation=32768` proxy token。预算是导出硬上限，不会填充、扩大实际输出或增加返回给调用方的字段；较高的可编辑容量用于完整保留合法的递归 Module/Dynamic Input workspace。

## Behavior

- 从 `niagara.state` 捕获共享 snapshot，经 `uai.export.niagara.asset`、共享 projector 和共享 HJSON writer 写出。
- 输出目录由 Export 独占并在写入前重置；只生成一个 `index.hjson`，不生成 JSON 兼容文件。
- Export 不读取 Apply contract，不修改 UObject、Package dirty 状态或资产内容。
- `llm_authoring` 输出 `operation: update`、`target`，以及可用的 `provider_extension.stages`。
- 当前可编辑投影覆盖 emitter/stage identity、module script/order/input、递归 dynamic input，以及存在时的 Renderer、Event Handler 身份和 profile 允许的结构化属性。System User Parameter 不适用于 standalone Emitter；Data Interface 的任意对象拓扑和任意 Script graph topology 不在本纵切的 Export 范围内。
- 本命令只接受 `asset_kind=emitter`；System 或 standalone Script 返回 `niagara_asset_kind_conflict`，应改用对应资产类型的 Export 命令。

## Returns

- Workspace 元数据：`schema`、`status`、`contract_id`、`contract_version`、`profile_id`、`workspace_root`、`token_budget`、`metrics`、`files`、`written_files`。
- 命令摘要：`asset_path`、`asset_kind`、`folder_path`、`file_count`。

## Validation

导出后解析 `index.hjson`；写入后再次调用本命令并比较结构化结果。不要依赖已删除的 `asset.hjson`、`settings/`、`emitters/`、`graphs/` 或 `validation/coverage_report.hjson`。
