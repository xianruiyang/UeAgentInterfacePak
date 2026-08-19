---
command: level_set_actor_transform
category: core_level
title: Transform / Attach / Folder / Tag
summary: **Deprecated for ordinary Level Content authoring**：普通 location/rotation/scale 最终态已由 resource transform 覆盖。带 `collision_aware` 的定点修复仍保留专用用途。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for ordinary Level Content authoring**：普通 location/rotation/scale 最终态已由 resource transform 覆盖。带 `collision_aware` 的定点修复仍保留专用用途。
deprecated_replacement: []
---

# `level_set_actor_transform`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for ordinary Level Content authoring**：普通 location/rotation/scale 最终态已由 resource transform 覆盖。带 `collision_aware` 的定点修复仍保留专用用途。
- key_inputs: `operation=patch`, `resources[].transform`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `operation=patch`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `resources[].transform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
