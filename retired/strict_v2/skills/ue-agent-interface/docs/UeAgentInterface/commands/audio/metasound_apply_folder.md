---
command: metasound_apply_folder
category: audio
title: MetaSound Apply
summary: 从统一单文件 HJSON workspace 创建或修改 MetaSound
aliases: []
tags: [audio, metasound, authoring]
status: active
---

# `metasound_apply_folder`

## LLM Compact

- inputs: `folder_path` 必填；`asset_path` 可选并作为目标覆盖。
- source: 只读取 `<folder_path>/index.hjson`，未知文件直接拒绝。
- lifecycle: `operation` 选择 `create`、`update` 或 `upsert`；MetaSound 会走 Builder API 并编译、按契约保存。

## Editable Content

- `properties[]`：根 MetaSound UObject 的公共属性描述符。
- `provider_extension.settings.asset_type`：`source` 或 `patch`；已有资产不可改变类型。
- `provider_extension.members.inputs|outputs`：名称、数据类型和结构化 literal 默认值。
- `provider_extension.graph.nodes|edges`：以稳定逻辑节点 ID、class name、pin name 表达，不接受原始 UE GUID。
- `provider_extension.interfaces`：只读，必须与当前状态一致。

不接受旧多文件格式、legacy alias、raw/debug 属性面，也不读取历史 `dry_run`、`create_if_missing`、`validate_only`、`compile_after_apply` 或 `save_after_apply` 参数。

## Returns

返回 `status`、`phase`、`resolved_operation`、`asset_path`、`object_path`、`units_checked`、`mutations_applied`、`applied` 和回滚状态；失败时附带 `error_code`、`error_detail`。

## Validation

先调用 `metasound_validate_folder`；Apply 成功后重新 Export，并验证成员、节点、连接和 literal 的结构化读回。
