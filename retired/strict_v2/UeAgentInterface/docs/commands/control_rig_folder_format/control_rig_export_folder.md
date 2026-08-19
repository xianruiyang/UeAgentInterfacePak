---
command: control_rig_export_folder
category: control_rig_folder_format
title: Control Rig Structured Export
summary: Export one Control Rig as index.hjson
aliases: []
tags: [control_rig, authoring, export]
status: active
---

# `control_rig_export_folder`

Exports one `UControlRigBlueprint` through the shared read-only snapshot, projection, and HJSON writer pipeline.

Inputs: required `asset_path`; optional `folder_path`; optional `profile` (`llm_authoring`, `readback`, `debug`, or `validation`). If `folder_path` is omitted, the command resolves the project default asset workspace.

The command publishes its complete one-file plan through the owned staging publisher and writes exactly one `index.hjson`. It does not reset final before staging, compile, save, or mutate the asset. `llm_authoring` is the default profile.

The response is the shared export workspace result: `status`, `contract_id`, `profile_id`, `workspace_root`, `written_files`, and HJSON metrics, plus normalized `asset_path`.

See [Rigging Structured Authoring](../../hjson-authoring/09_RiggingApplyDomain.md) for document fields and transform spaces.
