---
command: control_rig_runtime_probe
category: control_rig_folder_format
title: `control_rig_runtime_probe`
summary: 创建 transient rig 实例并采样
aliases: []
tags: [control_rig_folder_format]
status: active
---

# `control_rig_runtime_probe`

## LLM Compact

- status: active.
- purpose: 创建 transient rig 实例并采样
- key_inputs: `asset_path`, `event_name`, `frames`, `sample_bones[]`, `sample_controls[]`, `sample_variables[]`, `variable_inputs[]`, `variables`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- note: 该命令会编译目标 Control Rig，创建 transient `UControlRig` 实例，并按参数执行支持的事件。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- 该命令会编译目标 Control Rig，创建 transient `UControlRig` 实例，并按参数执行支持的事件。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `event_name`：名称字段；同名对象存在时应结合路径或 id 消歧。
- `frames`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `sample_bones[]`：sample_bones 列表。
- `sample_controls[]`：sample_controls 列表。
- `sample_variables[]`：sample_variables 列表。
- `variable_inputs[]`：variable_inputs 列表。
- `variables`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
