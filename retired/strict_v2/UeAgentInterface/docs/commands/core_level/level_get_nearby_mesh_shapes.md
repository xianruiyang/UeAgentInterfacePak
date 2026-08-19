---
command: level_get_nearby_mesh_shapes
category: core_level
title: Nearby Mesh Shapes
summary: 查询世界范围内 Actor/Component/Instance 的简单碰撞 shape，缺少简单碰撞时按配置返回 visual fallback。
aliases: []
tags: [scene, spatial, collision, whitebox]
status: active
---

# `level_get_nearby_mesh_shapes`

## LLM Compact

- status: active.
- purpose: 查询世界范围内 Actor/Component/Instance 的简单碰撞 shape，缺少简单碰撞时按配置返回 visual fallback。
- key_inputs: `query`, `filters.folder_path_prefix`, `types`, `type`, `include_visual_fallback`, `detail_level`, `max_shapes_per_actor`, `limit` ...
- key_returns: `actors[]`, `components[].to_world`, `components[].shapes[]`, `truncated`, `counts`
- note: 查询体积在 world space，单位 cm。
- note: 默认 Shape 输出在 owner-local space，单位 cm，表达为 AABB。
- note: 每个 component 或 ISM/HISM instance 是一个 owner，提供 `to_world` 供调用方把 `center/extent` 转到世界空间。
- note: 默认 `detail_level="summary"`、`output_style="compact"`，Shape 仅包含 `src/center/extent`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 查询体积在 world space，单位 cm。
- 默认 Shape 输出在 owner-local space，单位 cm，表达为 AABB。
- 每个 component 或 ISM/HISM instance 是一个 owner，提供 `to_world` 供调用方把 `center/extent` 转到世界空间。
- 默认 `detail_level="summary"`、`output_style="compact"`，Shape 仅包含 `src/center/extent`。
- 默认 summary 不输出 shape `id`、`n`、`warn`、corners、convex vertices、debug transform chain 或未与查询范围重叠的 Shape。
- 默认 summary 只有截断时才输出 `omitted_shapes`，不会在每个 shape 内输出额外计数字段。
- StaticMesh / ISM / HISM 会优先读取 StaticMesh BodySetup 中的 box / sphere / capsule / convex 简单碰撞，并按实际 component 或 instance transform 判断查询重叠。
- BodySetup 中 per-shape `CollisionEnabled` 不包含 query 的简单碰撞不会作为 `collision_* / block` 返回；如果没有任何 query-enabled 简单碰撞且允许 fallback，则返回 `visual_aabb/visual`。
- DynamicMesh、SkeletalMesh、SplineMesh、GeometryCache 当前默认使用 visual fallback；严格阻挡判断仍应结合 `level_sweep_capsule`、`level_sweep_capsule_path`、`level_trace_world_ray` 或 `level_check_overlaps`。
- owner-local AABB 是 LLM 空间感知摘要，不等价于精确物理求交。涉及角色通行、楼梯净空、门洞和跨层连接时，必须继续做 capsule sweep 或等价通行验证。

## Parameters

- `query`：推荐显式传 `{ "type": "aabb", "min": [x,y,z], "max": [x,y,z] }`；也支持 sphere/box 查询结构。
- `filters.folder_path_prefix`：只看指定 Outliner folder 前缀。
- `types` / `type`：可选过滤 actor/component/shape 类型；默认所有类型。
- `include_visual_fallback`：默认可用于没有简单碰撞的网格体。
- `detail_level`：默认 `summary`；可选 `summary`、`standard`、`debug`。`compact` 是 `output_style`，不是 detail level。
- `output_style`：默认 `compact`。
- `max_shapes_per_actor` / `limit`：限制返回规模。
- `center`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `filters`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `folder_path_prefix`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `max`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `min`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `radius`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `actors[]`：每项包含 actor 基本信息、transform 和命中的 components。
- `components[].to_world`：owner-local shape 转 world 的依据。
- `components[].shapes[]`：查询范围内的简单碰撞或 fallback AABB。
- `truncated` / `counts`：结果是否被 limit 截断及数量摘要。

## Minimal Example

```json
{
  "command": "level_get_nearby_mesh_shapes",
  "params": {
    "query": { "type": "aabb", "min": [-500, -500, -50], "max": [1500, 1500, 500] },
    "filters": { "folder_path_prefix": "UAI/WB_WhiteBox01" },
    "include_visual_fallback": true,
    "detail_level": "summary",
    "output_style": "compact"
  }
}
```

## Validation

白盒区域搭建前必须先用本命令探测搭建范围外扩区域；涉及门洞、楼梯、斜坡、桥和接口时，继续用 `level_sweep_capsule_path` 或等价验证确认通行。
