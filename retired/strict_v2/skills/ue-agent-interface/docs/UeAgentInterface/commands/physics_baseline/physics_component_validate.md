---
command: physics_component_validate
category: physics_baseline
title: 指令总览
summary: 对 PrimitiveComponent 当前物理状态做只读断言
aliases: []
tags: [physics_baseline]
status: active
---

# `physics_component_validate`

## LLM Compact

- status: active.
- purpose: 对 PrimitiveComponent 当前物理状态做只读断言
- key_inputs: `actor_id`, `component`, `expected`
- key_returns: `checks[]`, `mismatches[]`, `ok`, `query`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `actor_id`：Actor id，优先用于精确定位同名 Actor。
- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `expected`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `checks[]`：checks 列表摘要；大列表应写入 output/artifact 或 debug。
- `mismatches[]`：mismatches 列表摘要；大列表应写入 output/artifact 或 debug。
- `ok`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `query`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
