---
command: navmesh_spawn_bounds_volume
category: core_level
title: Navigation Bounds 放置
summary: **Deprecated for Level Content authoring**：创建 `ANavMeshBoundsVolume`、Brush Bounds 和 `OnNavigationBoundsUpdated` 已由 Level Content `nav_mesh_bounds_volume` adapter 覆盖。
aliases: []
tags: [core_level, deprecated]
status: deprecated
deprecated_scope: authoring
deprecated_reason: **Deprecated for Level Content authoring**：创建 `ANavMeshBoundsVolume`、Brush Bounds 和 `OnNavigationBoundsUpdated` 已由 Level Content `nav_mesh_bounds_volume` adapter 覆盖。
deprecated_replacement: []
---

# `navmesh_spawn_bounds_volume`

## LLM Compact

- status: deprecated.
- purpose: **Deprecated for Level Content authoring**：创建 `ANavMeshBoundsVolume`、Brush Bounds 和 `OnNavigationBoundsUpdated` 已由 Level Content `nav_mesh_bounds_volume` adapter 覆盖。
- key_inputs: `bounds.center`, `extent`, `bounds.min`, `max`, `kind=nav_mesh_bounds_volume`, `resources[]`, `update_navigation_bounds`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。
- validation: 确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。

## Authoring Notes

- 生命周期：废弃指令只用于兼容、迁移、诊断或修复；新 authoring 不应选用。

## Parameters

- `bounds.center/extent`：bounds 的中心和半尺寸。
- `bounds.min/max`：bounds 的最小/最大角。
- `kind=nav_mesh_bounds_volume`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `resources[]`：resources 列表。
- `update_navigation_bounds`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

确认迁移目标可覆盖当前用途；只有兼容/迁移/诊断/修复场景才继续使用，并记录原因。
