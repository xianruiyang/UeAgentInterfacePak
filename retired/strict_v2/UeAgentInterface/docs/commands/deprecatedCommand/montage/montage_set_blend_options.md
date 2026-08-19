---
command: montage_set_blend_options
category: montage
title: 资产与基础信息
summary: **Deprecated for authoring**：设置 Blend 和 AutoBlendOut
aliases: []
tags: [montage, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for authoring**：设置 Blend 和 AutoBlendOut
deprecated_replacement: []
---

# `montage_set_blend_options`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for authoring**：设置 Blend 和 AutoBlendOut
- key_inputs: `asset_path`, `blend_in_time`, `blend_mode_in`, `out`, `blend_out_time`, `blend_out_trigger_time`, `enable_auto_blend_out`, `save_after_set`
- key_returns: `settings`
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `blend_in_time`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `blend_mode_in`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `out`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `blend_out_time`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `blend_out_trigger_time`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `enable_auto_blend_out`：布尔/开关字段；默认值以本命令契约为准。
- `save_after_set`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `settings`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
