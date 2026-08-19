---
command: modeling_set_pivot
category: modeling
title: `modeling_set_pivot`
summary: modeling_set_pivot command contract.
aliases: []
tags: [modeling]
status: active
---

# `modeling_set_pivot`

## LLM Compact

- status: active.
- purpose: modeling_set_pivot command contract.
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 枢轴写入必须明确目标是资产还是场景组件；写后验证 pivot before/after，并确认 geometry/collision preserved。
- note: 传入 `preset` / `pivot_preset` / `custom_point` 等高层字段时，UAI 先做参数归一化，再调用合适后端。
- note: 未传高层字段时，保持兼容旧行为，仍作为 `BeginEditPivotTool` 的 raw wrapper，可继续传 `tool_properties`、`post_action` 和 `accept`。
- note: 触发条件：目标 Actor 解析到唯一 `UDynamicMeshComponent`，并传入 `preset` 或 `custom_point`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 枢轴写入必须明确目标是资产还是场景组件；写后验证 pivot before/after，并确认 geometry/collision preserved。
- 传入 `preset` / `pivot_preset` / `custom_point` 等高层字段时，UAI 先做参数归一化，再调用合适后端。
- 未传高层字段时，保持兼容旧行为，仍作为 `BeginEditPivotTool` 的 raw wrapper，可继续传 `tool_properties`、`post_action` 和 `accept`。
- 触发条件：目标 Actor 解析到唯一 `UDynamicMeshComponent`，并传入 `preset` 或 `custom_point`。
- 空间语义：输入点为 component local 或 world；写入后通过平移 mesh 顶点并移动组件 world location 保持可见几何不动。
- 返回重点：`pivot_backend=dynamic_mesh_component`、`target`、`frame.bounds_space=component_local`、`pivot_point_component_local`、`pivot_before`、`pivot_after`、`geometry_preserved`、`world_bounds_origin_delta`、`world_bounds_extent_delta`、`collision_preserved`。
- 触发条件：目标 Actor 解析到 `UDynamicMeshComponent`，且 Actor 带 `UAIEditableVoxelGrid:<grid_id>` tag 和 sidecar；带 sidecar 的体素产物不会走普通 DynamicMesh 顶点平移后端。
- 空间语义：sidecar `anchor` 表示 grid-local 中哪个点落在 Actor 原点。`GridToWorld` 继续表示未偏移体素网格到世界的稳定变换；mesh 顶点和 `UBoxComponent` 碰撞都按 `grid_point - anchor` 生成。
- 写入方式：`preset` 按当前生成 mesh 的 component-local AABB 求点；`custom_point.space=component_local/local/world` 会转换为新 anchor，`custom_point.space=grid/grid_local/voxel_grid` 直接作为新 anchor。写入后自动重建 mesh 和 exact-cover box collision，并保存 sidecar。
- 后续编辑：`modeling_voxel_grid_add_bounds/remove_bounds` 的 `bounds.space=world` 始终通过稳定 `GridToWorld` 转回 grid local，因此 pivot 改变后继续 add/remove/apply 不会因 Actor 原点移动而错位。需要稳定脚本坐标时推荐传 `grid` 或 `world`；`component_local/local/actor` 表示当前 Actor/component local，会加上 `anchor` 转回 grid local。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
