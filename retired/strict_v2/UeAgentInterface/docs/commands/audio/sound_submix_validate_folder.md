---
command: sound_submix_validate_folder
category: audio
title: Sound Submix Validate
summary: 只读检查统一 Sound Submix workspace 及计划操作
aliases: []
tags: [audio, sound_submix, authoring]
status: active
---

# `sound_submix_validate_folder`

## Parameters

- `folder_path`：必填，目录内必须只有 `index.hjson`。
- `asset_path`：可选，用于覆盖或核对文档目标。

验证 operation、目标、submix class、parent、effect preset 引用和只读 children，但不发布、不保存资产。返回 `asset_exists`、`would_create`、`no_op`、`planned` 和检查计数；Validate 成功不代表资产已修改。
