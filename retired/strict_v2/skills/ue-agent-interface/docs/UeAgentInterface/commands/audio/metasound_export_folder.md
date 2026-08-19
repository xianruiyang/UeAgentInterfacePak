---
command: metasound_export_folder
category: audio
title: MetaSound Export
summary: 将 MetaSound 导出为统一单文件 HJSON workspace
aliases: []
tags: [audio, metasound, authoring]
status: active
---

# `metasound_export_folder`

## LLM Compact

- inputs: `asset_path` 必填；`folder_path`、`profile` 可选。
- output: workspace 中只生成 `index.hjson`。
- edit: 修改 `target`、`properties`、`provider_extension.settings|members|graph`；`interfaces` 为只读校验字段。

## Workspace Contract

`index.hjson` 包含 `operation`、`target`、可选根对象 `properties[]` 和 `provider_extension`。MetaSound 图使用稳定逻辑节点 ID 与 pin 名称，不导出 UE node/vertex GUID。旧 `asset.hjson`、`members/`、`graphs/` 和其他额外文件不再生成，也不被 Apply 接受。

Export 只决定暴露内容，不限制 Apply 可接受的结构化输入。`profile` 默认为 `llm_authoring`；`readback`/`debug` 可增加读回信息，但仍保持单文件 workspace。

## Returns

返回 `status`、`asset_path`、`workspace_root`、`profile_id`、`files[]`、`written_files[]`、`metrics` 和 `token_budget`。成功时 `written_files` 只包含 `index.hjson`。

## Validation

导出后用 `metasound_validate_folder` 校验；Apply 后重新导出并按结构化状态比较，不能只检查命令成功标记。
