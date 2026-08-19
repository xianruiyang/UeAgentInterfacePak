---
command: modeling_subdivide
category: modeling
title: Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool`
summary: Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool`
aliases: []
tags: [modeling]
status: active
---

# `modeling_subdivide`

## LLM Compact

- status: active.
- purpose: Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool`
- key_inputs: `asset_path`, `response_options`, `tool_properties`, `target_actor`
- key_returns: `data`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `response_options`：响应视图控制；debug/raw 只在排查时开启。
- `tool_properties`：Modeling 工具属性覆盖；显式值会覆盖自动推导。
- `target_actor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `data`：业务结果；默认读取 `CommandResult.data`。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
