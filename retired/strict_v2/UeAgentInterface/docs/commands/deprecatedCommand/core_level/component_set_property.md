---
command: component_set_property
category: core_level
title: 属性写入
summary: **Deprecated for Level Content authoring**：组件反射属性 patch 可跟随资源声明；`BodyInstance.* / Collision* / CanCharacterStepUpOn` 已在 Level Content 中补齐物理状态刷新，`BodyInstance.CollisionProfileName` 会调用 `SetCollisionProfileName`。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for Level Content authoring**：组件反射属性 patch 可跟随资源声明；`BodyInstance.* / Collision* / CanCharacterStepUpOn` 已在 Level Content 中补齐物理状态刷新，`BodyInstance.CollisionProfileName` 会调用 `SetCollisionProfileName`。
deprecated_replacement: []
---

# `component_set_property`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for Level Content authoring**：组件反射属性 patch 可跟随资源声明；`BodyInstance.* / Collision* / CanCharacterStepUpOn` 已在 Level Content 中补齐物理状态刷新，`BodyInstance.CollisionProfileName` 会调用 `SetCollisionProfileName`。
- key_inputs: `ComponentName.PropertyName`, `components[].properties`, `resources[].properties`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `ComponentName.PropertyName`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `components[].properties`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `resources[].properties`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
