---
command: physics_component_plan_patch
category: physics_baseline
title: 指令总览
summary: 将物理目标转换成 `uai.level_content.v1` patch
aliases: []
tags: [physics_baseline]
status: active
---

# `physics_component_plan_patch`

## LLM Compact

- status: active.
- purpose: 将物理目标转换成 `uai.level_content.v1` patch
- key_inputs: `actor_id`, `component`, `desired`, `emit_level_content_patch`
- key_returns: `level_content_patch`, `properties`, `requires_mobility_change`, `warnings[]`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor_id`：Actor id，优先用于精确定位同名 Actor。
- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `desired`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `emit_level_content_patch`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `level_content_patch`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `properties`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `requires_mobility_change`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `warnings[]`：warnings 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
