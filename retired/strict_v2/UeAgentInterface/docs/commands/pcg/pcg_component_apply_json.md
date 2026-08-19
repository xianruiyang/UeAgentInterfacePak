---
command: pcg_component_apply_json
category: pcg
title: 指令列表
summary: 创建或更新 Actor 上的 PCGComponent
aliases: []
tags: [pcg]
status: active
---

# `pcg_component_apply_json`

## LLM Compact

- status: active.
- purpose: 创建或更新 Actor 上的 PCGComponent
- key_inputs: `actor`, `component`, `generation_trigger`, `graph`, `partitioned`, `properties[]`, `seed`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `actor`：Actor 标识；可按命令支持的 label/id/path 形式定位。
- `component`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `generation_trigger`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `graph`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `partitioned`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `properties[]`：properties 列表。
- `seed`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
