---
command: pcg_screenshot
category: pcg
title: 指令列表
summary: 复用安全 viewport 截图并可先 frame actor
aliases: []
tags: [pcg]
status: active
---

# `pcg_screenshot`

## LLM Compact

- status: active.
- purpose: 复用安全 viewport 截图并可先 frame actor
- key_inputs: `actor`, `format`, `max_size`, `output_file`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: 成功时顶层返回 `file_path`、`format`、`width`、`height`，并保留嵌套 `screenshot` 诊断对象。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `max_size`：截图或导出尺寸上限。
- `output_file`：输出 artifact 路径；大结果应写文件，不要内联到 compact data。

## Returns

- 顶层 `file_path`、`format`、`width`、`height` 用于 compact/artifact 校验；嵌套 `screenshot` 保留完整截图诊断。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
