---
command: viewport_list_view_modes
category: core_level
title: `viewport_list_view_modes`
summary: 列出 `screenshot_viewport` 可用的视口模式和可视化子模式
aliases: []
tags: [core_level]
status: active
---

# `viewport_list_view_modes`

## LLM Compact

- status: active.
- purpose: 列出 `screenshot_viewport` 可用的视口模式和可视化子模式
- key_inputs: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 列出当前引擎和项目环境中 `screenshot_viewport` 可接受的稳定 key。该命令不修改视口状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 列出当前引擎和项目环境中 `screenshot_viewport` 可接受的稳定 key。该命令不修改视口状态。

## Parameters

- 未在旧分册命令表中列出；以实现 schema/readback 为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
