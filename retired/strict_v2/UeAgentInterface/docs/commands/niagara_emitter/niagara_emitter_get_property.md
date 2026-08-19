---
command: niagara_emitter_get_property
category: niagara_emitter
title: Emitter 属性
summary: 读取 Emitter 版本属性
aliases: []
tags: [niagara_emitter]
status: active
---

# `niagara_emitter_get_property`

## LLM Compact

- status: active.
- purpose: 读取 Emitter 版本属性
- key_inputs: `asset_path`, `emitter_asset_path`, `emitter_version`, `property_name`
- key_returns: `bRequiresPersistentIDs`
- note: 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 新增节点/模块/expression 前先查询 catalog/seed；写入后必须编译或读回关键 pin/input 状态。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `emitter_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `emitter_version`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `property_name`：名称字段；同名对象存在时应结合路径或 id 消歧。

## Returns

- `bRequiresPersistentIDs`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
