---
command: niagara_system_list_module_inputs
category: niagara_stage_graph
title: 读取 System stage module 的真实 input
summary: 读取 System stage module 的真实 input
aliases: []
tags: [niagara_stage_graph]
status: active
---

# `niagara_system_list_module_inputs`

## LLM Compact

- status: active.
- purpose: 读取 Niagara System 自身或指定嵌入式 Emitter Handle stage module 的真实 input
- key_inputs: `asset_path` / `system_asset_path`, `module_node_guid`，可选 `emitter_handle_id` / `emitter_name`
- key_returns: `inputs`, `module_node_guid`；嵌入式 Emitter 模式额外返回已解析 Handle 身份
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 未传 Emitter selector 时，仅在 System Spawn/Update Graph 中按 `module_node_guid` 查找。
- 传入 `emitter_handle_id` 或 `emitter_name` 时，在对应 Handle 的版本化 Emitter Graph 中查找；两者同时提供时必须指向同一 Handle。
- 修改 System 内 Emitter HJSON 后，应使用同一 Handle selector 和读回得到的模块 GUID 验证活跃输入。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `system_asset_path`：与 `asset_path` 等价的显式 System 资产路径。
- `emitter_handle_id`：可选，System 内嵌 Emitter Handle GUID。
- `emitter_name`：可选，System 内嵌 Emitter Handle 名称；建议优先使用 GUID，并可同时传名称用于身份一致性校验。
- `module_node_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `inputs`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `module_node_guid`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `emitter_handle_id` / `emitter_name`：仅嵌入式 Emitter 模式返回，表示实际解析到的 owner。
- Position 输入保留 `input_type_descriptor.family=position` 和 `requires_space_contract=true` 的空间语义；其可写 payload 使用 `value_type=vector3`、`value_schema=components`，与 folder Apply 的 `value_kind: vector3` 统一。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
