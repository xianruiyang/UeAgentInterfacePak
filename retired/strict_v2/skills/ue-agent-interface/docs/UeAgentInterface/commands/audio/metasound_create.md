---
command: metasound_create
category: audio
title: MetaSound Create
summary: 通过统一 Audio lifecycle 创建 MetaSound Source 或 Patch
aliases: []
tags: [audio, metasound, authoring]
status: active
---

# `metasound_create`

## Parameters

- `asset_path`：必填，目标 `/Game/...` 资产路径。
- `asset_type`：可选，`source`（默认）或 `patch`。
- `replace_existing`：可选，默认 `false`；为 `true` 时使用 `upsert`。
- `save_after_create`：可选，默认 `true`。

该命令是统一 MetaSound Apply lifecycle 的最小创建包装，不维护独立创建实现。复杂初始成员和图内容应写入 `index.hjson` 后调用 `metasound_apply_folder`。

## Returns

返回统一 Apply 结果，并附带 `created_asset`。创建后用 `metasound_export_folder` 读回验证。
