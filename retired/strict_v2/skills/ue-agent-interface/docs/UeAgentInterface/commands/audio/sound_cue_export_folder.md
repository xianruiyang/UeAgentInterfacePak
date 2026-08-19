---
command: sound_cue_export_folder
category: audio
title: Sound Cue Export
summary: 将 Sound Cue 导出为统一单文件 HJSON workspace
aliases: []
tags: [audio, sound_cue, authoring]
status: active
---

# `sound_cue_export_folder`

## LLM Compact

- inputs: `asset_path` 必填；`folder_path`、`profile` 可选。
- output: workspace 中只生成 `index.hjson`。
- graph: `provider_extension.graph` 内联 root、节点、连接、节点属性和二维布局。

节点使用稳定逻辑 ID；节点类型由 `class_path` 表达，普通属性走共享 property descriptor/codec。旧 `asset.hjson`、`nodes.hjson`、`edges.hjson`、`layout.hjson` 和额外目录不再生成。

## Returns

返回 `status`、`asset_path`、`workspace_root`、`profile_id`、`files[]`、`written_files[]`、`metrics` 和 `token_budget`。成功时 `written_files` 只包含 `index.hjson`。

## Validation

用 `sound_cue_validate_folder` 校验，Apply 后重新导出比较 root、节点、child index、节点属性和位置。
