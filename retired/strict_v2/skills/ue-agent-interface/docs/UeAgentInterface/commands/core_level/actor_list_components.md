---
command: actor_list_components
category: core_level
title: Level Content authoring 优先级
summary: 列出 Actor 组件
aliases: []
tags: [core_level]
status: active
---

# `actor_list_components`

## LLM Compact

- status: active.
- purpose: 列出 Actor 组件
- key_inputs: `id`, `include_non_scene`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `id`：稳定 id，用于精确定位或后续操作。
- `include_non_scene`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
