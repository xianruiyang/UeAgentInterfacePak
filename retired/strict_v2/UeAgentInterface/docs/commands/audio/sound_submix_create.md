---
command: sound_submix_create
category: audio
title: Sound Submix Create
summary: 通过统一 Audio lifecycle 创建 Sound Submix
aliases: []
tags: [audio, sound_submix, authoring]
status: active
---

# `sound_submix_create`

## Parameters

- `asset_path`：必填，目标 `/Game/...` 资产路径。
- `submix_class`：可选，UE Sound Submix 类路径；缺失时使用 profile 默认类。
- `parent_submix`：可选，父 Submix 资产路径。
- `replace_existing`：可选，默认 `false`；为 `true` 时使用 `upsert`。
- `save_after_create`：可选，默认 `true`。

该命令是统一 Sound Submix Apply lifecycle 的最小创建包装。效果链和其他初始属性应写入 `index.hjson` 后调用 `sound_submix_apply_folder`。

## Returns

返回统一 Apply 结果，并附带 `created_asset`。创建后用 `sound_submix_export_folder` 读回验证。
