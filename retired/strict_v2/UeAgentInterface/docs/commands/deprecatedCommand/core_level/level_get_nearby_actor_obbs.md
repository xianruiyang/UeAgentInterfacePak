---
command: level_get_nearby_actor_obbs
category: core_level
title: 场景空间感知兼容入口
summary: **Deprecated for whitebox spatial perception authoring**：Actor 级 OBB 会把体素、开洞结构、多组件 Actor 或长条结构折成单个粗盒，容易误导 LLM 判断通行空间、门洞、楼梯开槽和局部碰撞。旧入口仅保留 compatibility、diagnostic、migration、repair 和 smoke 场景。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for whitebox spatial perception authoring**：Actor 级 OBB 会把体素、开洞结构、多组件 Actor 或长条结构折成单个粗盒，容易误导 LLM 判断通行空间、门洞、楼梯开槽和局部碰撞。旧入口仅保留 compatibility、diagnostic、migration、repair 和 smoke 场景。
deprecated_replacement: [level_get_nearby_mesh_shapes]
---

# `level_get_nearby_actor_obbs`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for whitebox spatial perception authoring**：Actor 级 OBB 会把体素、开洞结构、多组件 Actor 或长条结构折成单个粗盒，容易误导 LLM 判断通行空间、门洞、楼梯开槽和局部碰撞。旧入口仅保留 compatibility、diagnostic、migration、repair 和 smoke 场景。
- key_inputs: `level_get_nearby_mesh_shapes`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `level_get_nearby_mesh_shapes`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
