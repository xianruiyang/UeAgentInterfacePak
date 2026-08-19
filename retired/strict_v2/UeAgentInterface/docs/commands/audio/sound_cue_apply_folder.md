---
command: sound_cue_apply_folder
category: audio
title: Sound Cue Apply
summary: 从统一单文件 HJSON workspace 创建或修改 Sound Cue
aliases: []
tags: [audio, sound_cue, authoring]
status: active
---

# `sound_cue_apply_folder`

## Parameters

- `folder_path`：必填，只读取 `index.hjson`。
- `asset_path`：可选，覆盖或核对文档目标。

`operation` 选择 `create`、`update` 或 `upsert`。`properties[]` 写根 Sound Cue；`provider_extension.graph` 写 `root_node_id`、`nodes[]` 和 `edges[]`。每个节点通过 `class_path` 构造并调用 UE 节点自身的 connector 初始化，再递归应用公共属性；连接使用 `from_node/to_node/child_index`。

未知文件、旧平铺文件、legacy alias 和 raw/debug 属性面均被拒绝。Apply 参数不包含历史 `allow_destructive`、`dry_run` 或 `save_after_apply` 开关。

## Returns

返回统一 Apply 状态、解析后的 operation、目标、检查/修改计数和回滚结果。成功后重新 Export 验证真实图状态。
