---
command: modeling_create_plane
category: modeling
title: 使用 bounds 创建 DynamicMesh plane，并默认生成 actor box collision
summary: 使用 bounds 创建 DynamicMesh plane，并默认生成 actor box collision
aliases: []
tags: [modeling]
status: active
---

# `modeling_create_plane`

## LLM Compact

- status: active.
- purpose: 使用 bounds 创建 DynamicMesh plane，并默认生成 actor box collision
- key_inputs: `bounds`, `rotation`, `collision`, `label`, `folder_path`, `tool_properties`, `accept`
- key_returns: `collision`, `created_actor`, `derived_primitive`
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: 高层 bounds 路径默认输出 DynamicMeshActor；`bounds + rotation` 决定尺寸、朝向和 actor 放置。
- note: 只有 7 条 `modeling_create_*` wrapper 允许 Primitive 专用的 bounds/collision/label/folder 参数；其他 wrapper 或 `modeling_start_tool` 携带这些参数会失败。
- note: 完整 bounds 使用世界坐标确定 Actor 放置并强制完成创建；显式 `accept: false` 与不完整 bounds 都会失败。
- note: `collision` 不填时走 primitive 默认碰撞；只有明确需求才覆盖。简单碰撞无法贴合时默认应使用 DynamicMesh complex，而不是整体 bounds box。
- validation: 检查 `created_actor`、`derived_primitive`、`collision.mode/source/count`；可玩结构用 `level_sweep_capsule_path` 或等价 sweep 验证。

## Authoring Notes

- 高层 bounds 路径默认输出 DynamicMeshActor；`bounds + rotation` 决定尺寸、朝向和 actor 放置。
- 本命令与另外 6 条 create wrapper 共同构成 Primitive 参数的唯一公开入口：`modeling_create_box/cylinder/plane/ramp/ramp_corner/sphere/stairs`。
- `bounds.center` 与 `rotation` 按 UE 世界空间解释，`bounds.extent` 表示物理半尺寸；本命令不接受 `bounds.space` 切换坐标系。
- 完整 bounds 会进入确定性创建路径并强制 `accept: true`。显式传入 `accept: false` 会返回 `primitive_bounds_require_accept`。
- `collision` 不填时走 primitive 默认碰撞；只有明确需求才覆盖。简单碰撞无法贴合时默认应使用 DynamicMesh complex，而不是整体 bounds box。

## Parameters

- `bounds`：可选对象；确定性创建时必须完整使用 `center + extent` 或 `min + max`。
- `bounds_center` + `bounds_extent`：可选顶层别名。
- `bounds_min` + `bounds_max`：可选顶层别名。
- `rotation` 或 `orientation`：可选 UE Rotator，单位 degree；定义 Actor 世界旋转。
- `label`：可选新建 Actor editor label；只允许与完整 bounds 一起使用。
- `folder_path`：可选 World Outliner folder；只允许与完整 bounds 一起使用。
- `auto_generate_collision`：可选布尔值；只允许与完整 bounds 一起使用。
- `collision`：可选字符串或对象；对象可包含 `mode`、`profile_name`/`profile`、`enabled`、`replace_existing`、`max_boxes`/`max_shapes`、`max_step_height_cm`/`max_step_height`/`step_height`。只允许与完整 bounds 一起使用。
- `tool_properties`：可选数组；每项使用 `property_set`、`property_path`、`value_kind` 和 canonical `value` 描述工具属性。
- `accept`：无完整 bounds 时按普通 wrapper 生命周期处理；存在完整 bounds 时必须省略或为 `true`，实现会强制接受以完成创建。

## Errors

- `primitive_bounds_incomplete`：给出了 bounds 相关字段，但无法组成完整 bounds。
- `primitive_options_require_bounds`：给出了 collision、label、folder 等 Primitive 选项，但没有完整 bounds。
- `primitive_bounds_require_accept`：完整 bounds 与显式 `accept: false` 冲突。
- `primitive_parameters_require_create_wrapper`：同类 Primitive 字段被传给非 create wrapper 或 `modeling_start_tool` 时的拒绝语义。

## Returns

- `collision`：碰撞生成摘要；重点看 mode/source/count/coverage。
- `created_actor`：新建 Actor 摘要。
- `derived_primitive`：由 bounds 推导出的 primitive/tool 参数摘要。
- `accepted: true`：完整 bounds 路径已接受工具并完成创建。
- `requested_tool_identifier`：该 wrapper 对应的公开 registry identifier。

## Validation

检查 `created_actor`、`derived_primitive`、`collision.mode/source/count`；可玩结构用 `level_sweep_capsule_path` 或等价 sweep 验证。
