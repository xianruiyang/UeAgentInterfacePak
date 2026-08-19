---
command: level_get_actor_transform
category: core_level
title: Level Content authoring 优先级
summary: 读取 Actor 实例变换
aliases: []
tags: [core_level]
status: active
---

# `level_get_actor_transform`

## LLM Compact

- status: active.
- purpose: 读取 Actor 实例变换
- key_inputs: `id`
- key_returns: `location`, `rotation`, `scale`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `id`：稳定 id，用于精确定位或后续操作。

## Returns

- `location`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `rotation`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `scale`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
