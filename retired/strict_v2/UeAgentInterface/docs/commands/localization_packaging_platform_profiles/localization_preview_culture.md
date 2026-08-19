---
command: localization_preview_culture
category: localization_packaging_platform_profiles
title: Localization
summary: 当前编辑器会话切换 culture 并可立即恢复
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `localization_preview_culture`

## LLM Compact

- status: active.
- purpose: 当前编辑器会话切换 culture 并可立即恢复
- key_inputs: `culture`, `restore_after`, `scope`
- key_returns: `current_culture`, `previous_culture`, `restored`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `culture`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `restore_after`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `scope`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `current_culture`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `previous_culture`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `restored`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
