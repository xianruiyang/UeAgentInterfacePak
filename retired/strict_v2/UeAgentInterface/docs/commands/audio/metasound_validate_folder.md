---
command: metasound_validate_folder
category: audio
title: MetaSound Validate
summary: 只读检查统一 MetaSound workspace 及计划操作
aliases: []
tags: [audio, metasound, authoring]
status: active
---

# `metasound_validate_folder`

## Parameters

- `folder_path`：必填，目录内必须只有 `index.hjson`。
- `asset_path`：可选，用于覆盖或核对文档目标。

## Behavior

解析与 Apply 相同的统一输入契约，验证 operation、目标身份、只读字段、成员、结构化 literal、节点和 pin 连接，但不发布、不保存资产。旧多文件和任意额外文件均被拒绝。

## Returns

返回 `status`、`asset_path`、`requested_operation`、`units_checked`、`asset_exists`、`would_create`、`no_op` 和 `planned`；失败时附带 `error_code`、`error_detail`。Validate 结果不是已写入状态。
