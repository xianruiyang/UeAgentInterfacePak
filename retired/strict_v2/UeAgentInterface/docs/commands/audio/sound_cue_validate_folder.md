---
command: sound_cue_validate_folder
category: audio
title: Sound Cue Validate
summary: 只读检查统一 Sound Cue workspace 及计划操作
aliases: []
tags: [audio, sound_cue, authoring]
status: active
---

# `sound_cue_validate_folder`

## Parameters

- `folder_path`：必填，目录内必须只有 `index.hjson`。
- `asset_path`：可选，用于覆盖或核对文档目标。

验证目标、operation、节点 class、稳定 ID、root、连接 child index、位置数组和节点属性，不发布或保存资产。返回 `asset_exists`、`would_create`、`no_op`、`planned` 及检查计数；失败时返回结构化错误。Validate 成功不代表 Apply 已执行。
