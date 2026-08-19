---
command: level_get_actor_property
category: core_level
title: Level Content authoring 优先级
summary: 读取 Actor 属性
aliases: []
tags: [core_level]
status: active
---

# `level_get_actor_property`

## LLM Compact

- status: active.
- purpose: 读取 Actor 属性
- key_inputs: `id`, `property_name`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `id`：稳定 id，用于精确定位或后续操作。
- `property_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
