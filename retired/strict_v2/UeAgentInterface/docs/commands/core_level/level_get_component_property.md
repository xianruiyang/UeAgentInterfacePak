---
command: level_get_component_property
category: core_level
title: Level Content authoring 优先级
summary: 读取组件属性
aliases: []
tags: [core_level]
status: active
---

# `level_get_component_property`

## LLM Compact

- status: active.
- purpose: 读取组件属性
- key_inputs: `component`, `component_id`, `id`, `property_name`
- key_returns: `actor_label`, `component_name`, `property_name`, `property_class`, `value_text`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `component_id`：稳定 id，用于精确定位或后续操作。
- `id`：稳定 id，用于精确定位或后续操作。
- `property_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- `actor_label` / `actor_name`：组件所属 Actor。
- `component_name` / `component_path`：实际读取的组件。
- `property_name` / `property_class`：已解析属性及其 UE 反射类型。
- `value_text`：属性通过 UE `ExportTextItem` 导出的当前实际值；这是本命令的主要读回结果，`llm_compact` 也必须保留。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
