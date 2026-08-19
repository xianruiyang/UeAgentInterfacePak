---
command: sound_submix_export_folder
category: audio
title: Sound Submix Export
summary: 将 Sound Submix 导出为统一单文件 HJSON workspace
aliases: []
tags: [audio, sound_submix, authoring]
status: active
---

# `sound_submix_export_folder`

## LLM Compact

- inputs: `asset_path` 必填；`folder_path`、`profile` 可选。
- output: workspace 中只生成 `index.hjson`。
- edit: `properties[]` 以及 `provider_extension.settings` 中的 class、parent、effect chain；`children` 为派生只读信息。

旧 `asset.hjson`、`graph.hjson`、`effects.hjson`、`analysis_settings.hjson` 和其他额外文件不再生成或接受。

## Returns

返回 workspace 状态、目标、profile、文件清单、metrics 和 token budget。成功时 `written_files` 只包含 `index.hjson`。

## Validation

用 `sound_submix_validate_folder` 校验，Apply 后重新导出比较 class、parent、effect chain 和派生 children。
