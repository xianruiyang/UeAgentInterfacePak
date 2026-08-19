---
command: niagara_system_set_module_input
category: niagara_stage_graph
title: **Deprecated for authoring**：设置 System stage module input
summary: 旧细粒度文本写入入口；结构化 authoring 使用 `niagara_apply_folder`
aliases: []
tags: [niagara_stage_graph]
status: deprecated
---

# `niagara_system_set_module_input`

## LLM Compact

- status: deprecated.
- purpose: 仅用于兼容、迁移、诊断或修复旧调用；新 authoring 使用 `niagara_apply_folder`。
- key_inputs: `asset_path`, `input_name`, `module_node_guid`, `value_text`
- key_returns: `applied_value_text`, `property_import_status`, `requested_value_text`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 本命令保留 Niagara 原生 pin 文本格式，不属于统一 UObject 结构化属性入口。
- 新建或修改 Niagara System 时，导出并编辑 folder HJSON，再调用 `niagara_apply_folder`。
- 只有旧调用迁移、诊断、修复或 schema boundary 场景可以继续使用本命令。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `input_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `module_node_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `value_text`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `applied_value_text`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `property_import_status`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `requested_value_text`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
