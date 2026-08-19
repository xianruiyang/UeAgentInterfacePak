---
command: montage_add_notify
category: montage
title: Notify / Branching Point
summary: **Deprecated for authoring**：新增普通 Notify 或命名 Notify
aliases: []
tags: [montage, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：新增普通 Notify 或命名 Notify
deprecated_replacement: []
---

# `montage_add_notify`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：新增普通 Notify 或命名 Notify
- key_inputs: `asset_path`, `can_be_filtered_via_request`, `notify_class`, `notify_color`, `notify_filter_lod`, `notify_filter_type`, `notify_name`, `notify_trigger_chance` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `can_be_filtered_via_request`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_color`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_filter_lod`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_filter_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `notify_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `notify_trigger_chance`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_add`：布尔/开关字段；默认值以本命令契约为准。
- `tick_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `branching_point`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `time_seconds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `track_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `trigger_on_dedicated_server`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `trigger_on_follower`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `trigger_weight_threshold`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
