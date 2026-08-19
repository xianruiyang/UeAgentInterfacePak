---
command: pcg_world_actor_apply_json
category: pcg
title: 指令列表
summary: 创建或更新 PCGWorldActor 设置
aliases: []
tags: [pcg]
status: active
---

# `pcg_world_actor_apply_json`

## LLM Compact

- status: active.
- purpose: 创建或更新 PCGWorldActor 设置
- key_inputs: `enable_world_partition_generation_sources`, `partition_grid_size`, `treat_editor_viewport_as_generation_source`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `enable_world_partition_generation_sources`：布尔/开关字段；默认值以本命令契约为准。
- `partition_grid_size`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `treat_editor_viewport_as_generation_source`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
