---
command: physics_constraint_export_json
category: physics_baseline
title: 指令总览
summary: 导出场景中的 PhysicsConstraintComponent
aliases: []
tags: [physics_baseline]
status: active
---

# `physics_constraint_export_json`

## LLM Compact

- status: active.
- purpose: 导出场景中的 PhysicsConstraintComponent
- key_inputs: `actor_id`, `output_file`, `component`
- key_returns: `constrained`, `constraint`, `target`
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。

## Parameters

- `actor_id`：Actor id，优先用于精确定位同名 Actor。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `constrained`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `constraint`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
