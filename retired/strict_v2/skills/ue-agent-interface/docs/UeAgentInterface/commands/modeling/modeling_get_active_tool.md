---
command: modeling_get_active_tool
category: modeling
title: **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作
summary: **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作
aliases: []
tags: [modeling]
status: active
---

# `modeling_get_active_tool`

## LLM Compact

- status: active.
- purpose: **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作
- key_inputs: `asset_path`, `selection`, `properties`, `target_actor`, `tool_name`
- key_returns: `errors`, `success`, `warnings`
- note: 作用：返回当前活动工具与属性集摘要。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 作用：返回当前活动工具与属性集摘要。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `selection`：目标选择器；支持的字段由命令定义。
- `properties`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_actor`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `tool_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- `errors`：错误摘要。
- `success`：命令业务是否成功；仍需按返回字段读回验收。
- `warnings`：警告摘要。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
