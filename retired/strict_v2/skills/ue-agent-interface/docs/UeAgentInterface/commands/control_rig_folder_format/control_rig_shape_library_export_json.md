---
command: control_rig_shape_library_export_json
category: control_rig_folder_format
title: Control Rig Shape Library
summary: 导出单文件 JSON
aliases: []
tags: [control_rig_folder_format]
status: active
---

# `control_rig_shape_library_export_json`

## LLM Compact

- status: active.
- purpose: 导出单文件 JSON
- key_inputs: `asset_path`, `output_file`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- note: folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- folder authoring 以导出/最小 authoring/readback 为主；新增节点、组件或模块先用 catalog/seed，再按读回修补。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
