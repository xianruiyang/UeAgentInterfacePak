---
command: pcg_data_export_json
category: pcg
title: 指令列表
summary: 导出组件生成数据摘要
aliases: []
tags: [pcg]
status: active
---

# `pcg_data_export_json`

## LLM Compact

- status: active.
- purpose: 导出组件生成数据摘要
- key_inputs: `actor`, `output_file`, `component`, `max_points_per_data`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。
- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `max_points_per_data`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
