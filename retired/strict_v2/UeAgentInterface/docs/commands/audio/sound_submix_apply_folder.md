---
command: sound_submix_apply_folder
category: audio
title: Sound Submix Apply
summary: 从统一单文件 HJSON workspace 创建或修改 Sound Submix
aliases: []
tags: [audio, sound_submix, authoring]
status: active
---

# `sound_submix_apply_folder`

## Parameters

- `folder_path`：必填，只读取 `index.hjson`。
- `asset_path`：可选，覆盖或核对文档目标。

`operation` 选择 `create`、`update` 或 `upsert`。`properties[]` 写根 UObject；`provider_extension.settings` 写 `submix_class`、`parent` 和 `effect_chain[]`。`provider_extension.children` 是 UE 层级派生只读字段，必须与当前状态一致，不能直接写入。

未知文件、旧多文件和 legacy alias 均被拒绝。返回统一 Apply 状态、目标、修改计数和回滚结果；成功后重新 Export 验证。
