---
command: pcg_asset_info
category: pcg
title: 指令列表
summary: 读取 PCG Graph / GraphInstance / DataAsset 概览
aliases: []
tags: [pcg]
status: active
---

# `pcg_asset_info`

## LLM Compact

- status: active.
- purpose: 读取 PCG Graph / GraphInstance / DataAsset 概览
- key_inputs: `asset_path`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
