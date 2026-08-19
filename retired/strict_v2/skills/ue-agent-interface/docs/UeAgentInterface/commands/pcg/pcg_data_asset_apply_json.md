---
command: pcg_data_asset_apply_json
category: pcg
title: 指令列表
summary: 创建或更新 `UPCGDataAsset` 元数据
aliases: []
tags: [pcg]
status: active
---

# `pcg_data_asset_apply_json`

## LLM Compact

- status: active.
- purpose: 创建或更新 `UPCGDataAsset` 元数据
- key_inputs: `asset_path`, `name`, `category`, `create`, `description`, `object_path_source`, `save`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `name`：对象名称；创建时应保持稳定，避免同名歧义。
- `category`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `create`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `description`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `object_path_source`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
