---
command: pcg_level_to_asset_export
category: pcg
title: 指令列表
summary: 调用 UE PCG Level To Asset 导出
aliases: []
tags: [pcg]
status: active
---

# `pcg_level_to_asset_export`

## LLM Compact

- status: active.
- purpose: 调用 UE PCG Level To Asset 导出
- key_inputs: `asset_path`, `allow_overwrite`, `save`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- note: `allow_overwrite` 默认 false；目标资产已存在时返回 `allow_overwrite_required`，只有显式设为 true 才允许更新。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `allow_overwrite`：默认 false；设为 true 才允许更新已存在的目标资产。
- `save`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 返回 `asset_path`、`package`、`saved` 和 `allow_overwrite`；写后用 `pcg_asset_info` 读回目标资产。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
