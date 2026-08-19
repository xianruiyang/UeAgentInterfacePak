---
command: sound_cue_create
category: audio
title: Sound Cue Create
summary: 通过统一 Audio lifecycle 创建空 Sound Cue
aliases: []
tags: [audio, sound_cue, authoring]
status: active
---

# `sound_cue_create`

## Parameters

- `asset_path`：必填，目标 `/Game/...` 资产路径。
- `replace_existing`：可选，默认 `false`；为 `true` 时使用 `upsert`。
- `save_after_create`：可选，默认 `true`。

该命令是统一 Sound Cue Apply lifecycle 的最小创建包装。要创建带节点和连接的 Cue，应在 `index.hjson` 中提供 `provider_extension.graph` 并调用 `sound_cue_apply_folder`。

## Returns

返回统一 Apply 结果，并附带 `created_asset`。创建后用 `sound_cue_export_folder` 读回验证。
