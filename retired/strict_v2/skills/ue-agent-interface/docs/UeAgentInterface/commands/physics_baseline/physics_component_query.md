---
command: physics_component_query
category: physics_baseline
title: 指令总览
summary: 查询 Actor 上 PrimitiveComponent 的物理/碰撞/质量/材质/运行时状态
aliases: []
tags: [physics_baseline]
status: active
---

# `physics_component_query`

## LLM Compact

- status: active.
- purpose: 查询 Actor 上 PrimitiveComponent 的物理/碰撞/质量/材质/运行时状态
- key_inputs: `actor_id`, `component`, `include_collision_responses`, `include_material`, `include_runtime_state`
- key_returns: `collision_profile_name`, `enable_gravity`, `level_content_patch_hint`, `mass_kg`, `physical_material`, `simulate_physics`, `use_ccd`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor_id`：Actor id，优先用于精确定位同名 Actor。
- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_collision_responses`：布尔/开关字段；默认值以本命令契约为准。
- `include_material`：布尔/开关字段；默认值以本命令契约为准。
- `include_runtime_state`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `collision_profile_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `enable_gravity`：布尔/开关字段；默认值以本命令契约为准。
- `level_content_patch_hint`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `mass_kg`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `physical_material`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `simulate_physics`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `use_ccd`：布尔/开关字段；默认值以本命令契约为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
