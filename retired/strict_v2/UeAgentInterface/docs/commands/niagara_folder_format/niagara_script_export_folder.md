---
command: niagara_script_export_folder
category: niagara_folder_format
title: 将 standalone Niagara Script 导出为统一 index.hjson workspace
summary: 将 standalone Niagara Script 导出为统一 index.hjson workspace
aliases: []
tags: [niagara_folder_format, hjson_authoring, unified_apply_export]
status: active
---

# `niagara_script_export_folder`

## LLM Compact

- purpose: 将 standalone Niagara Script 导出为统一 index.hjson workspace
- key_inputs: `script_asset_path`（也接受 `asset_path` 作为定位别名）, `folder_path`, `profile`
- workspace: 单文件 `index.hjson`
- contract: `uai.export.niagara.asset`
- backend: `shared snapshot -> projector -> writer`

## Parameters

- `script_asset_path`（也接受 `asset_path` 作为定位别名）：必填，目标资产路径。
- `folder_path`：可选；省略时写入 `Saved/UeAssetFolders/NiagaraScript/<asset path>/`。
- `profile`：可选，默认 `llm_authoring`；支持 `llm_authoring`、`readback`、`debug`、`validation`。

Profile 预算按输出职责分级：`llm_authoring=196608`、`readback=196608`、`debug=393216`、`validation=32768` proxy token。预算是导出硬上限，不会填充、扩大实际输出或增加返回给调用方的字段；较高的可编辑容量用于完整保留合法的递归 Dynamic Input workspace。

## Behavior

- 从 `niagara.state` 捕获共享 snapshot，经 `uai.export.niagara.asset`、共享 projector 和共享 HJSON writer 写出。
- 输出目录由 Export 独占并在写入前重置；只生成一个 `index.hjson`，不生成 JSON 兼容文件。
- Export 不读取 Apply contract，不修改 UObject、Package dirty 状态或资产内容。
- `llm_authoring` 输出 `operation: update`、`target`，以及可用的 `provider_extension.stages`。
- standalone Module Script 的 stack-shaped Parameter Map 图会投影为 `stages -> modules -> dynamic_inputs`，与 System/Emitter 使用同一状态访问器和 projector。
- 原始低层节点、非 stack-shaped 自由连线和编辑器布局不投影；不能把本命令当作任意 Niagara Graph 序列化器。
- 本命令只接受 `asset_kind=script`；System 或 standalone Emitter 返回 `niagara_asset_kind_conflict`，应改用对应资产类型的 Export 命令。

## Returns

- Workspace 元数据：`schema`、`status`、`contract_id`、`contract_version`、`profile_id`、`workspace_root`、`token_budget`、`metrics`、`files`、`written_files`。
- 命令摘要：`asset_path`、`asset_kind`、`folder_path`、`file_count`。

## Validation

导出后解析 `index.hjson`；写入后再次调用本命令并比较结构化结果。不要依赖已删除的 `asset.hjson`、`settings/`、`emitters/`、`graphs/` 或 `validation/coverage_report.hjson`。
