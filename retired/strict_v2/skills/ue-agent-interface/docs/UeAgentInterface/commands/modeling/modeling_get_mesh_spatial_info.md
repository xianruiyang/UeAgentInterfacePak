---
command: modeling_get_mesh_spatial_info
category: modeling
title: 读取网格体 AABB 与 pivot 在 AABB 内的相对位置
summary: 读取网格体 AABB 与 pivot 在 AABB 内的相对位置
aliases: []
tags: [modeling]
status: active
---

# `modeling_get_mesh_spatial_info`

## LLM Compact

- status: active.
- purpose: 读取网格体 AABB 与 pivot 在 AABB 内的相对位置
- key_inputs: `actor_id`, `actor_label`, `actor_path`, `asset_path`, `bounds_space`, `component_name`
- key_returns: `aabb.max`, `aabb.min`, `frame.bounds_source`, `frame.bounds_space`, `frame.unit`, `pivot_in_aabb.ratio`, `target.target_type`
- note: 默认只返回 AABB min/max 和 pivot 在 AABB 中的 ratio；world bounds/corners/center/extent 等扩展默认不返回。
- note: 作用：读取静态网格体资产、骨骼网格体资产，或场景中静态网格体组件、骨骼网格体组件、DynamicMesh 组件的视觉网格 AABB，并返回 pivot 在 AABB 内的相对位置。
- note: pivot 取目标局部原点 `(0,0,0)`，不返回绝对 pivot 位置。
- note: 默认不返回 world bounds、center、extent、corners 或 viewport frame 信息；后续如需扩展必须用显式参数开启，且扩展字段不能与默认字段重复。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 默认只返回 AABB min/max 和 pivot 在 AABB 中的 ratio；world bounds/corners/center/extent 等扩展默认不返回。
- 作用：读取静态网格体资产、骨骼网格体资产，或场景中静态网格体组件、骨骼网格体组件、DynamicMesh 组件的视觉网格 AABB，并返回 pivot 在 AABB 内的相对位置。
- pivot 取目标局部原点 `(0,0,0)`，不返回绝对 pivot 位置。
- 默认不返回 world bounds、center、extent、corners 或 viewport frame 信息；后续如需扩展必须用显式参数开启，且扩展字段不能与默认字段重复。
- StaticMesh 专用 `static_mesh_get_bounds` / `static_mesh_get_local_corners` 可继续作为资产级快捷读回入口；需要同时覆盖 StaticMesh / SkeletalMesh 资产、场景 Actor/mesh Component、DynamicMesh 或 pivot 相对 AABB 位置的新流程，应优先使用本命令。

## Parameters

- `actor_id`：Actor id，优先用于精确定位同名 Actor。
- `actor_label`：Actor editor label；同名时应改用 id/path。
- `actor_path`：Actor object path；用于精确定位场景实例。
- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `bounds_space`：AABB 输出空间；资产目标通常为 asset local，场景组件通常为 component local。
- `component_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- `aabb.max`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `aabb.min`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame.bounds_source`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame.bounds_space`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `frame.unit`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `pivot_in_aabb.ratio`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target.target_type`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
