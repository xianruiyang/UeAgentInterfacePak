---
command: montage_update_segment
category: montage
title: Segment
summary: **Deprecated for authoring**：修改已有动画段
aliases: []
tags: [montage, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：修改已有动画段
deprecated_replacement: []
---

# `montage_update_segment`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：修改已有动画段
- key_inputs: `asset_path`, `anim_end_time`, `anim_start_time`, `animation_asset`, `loop_count`, `play_rate`, `save_after_set`, `segment_index` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `anim_end_time`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `anim_start_time`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `animation_asset`：资产引用；通常传 UE 资产路径。
- `loop_count`：数量摘要。
- `play_rate`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。
- `segment_index`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `slot_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `start_pos`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
