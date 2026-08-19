---
command: asset_reference_graph
category: core_level
title: `asset_reference_graph`
summary: 查询任意资产的 AssetRegistry 引用关系
aliases: []
tags: [core_level]
status: active
---

# `asset_reference_graph`

## LLM Compact

- status: active.
- purpose: 查询任意资产的 AssetRegistry 引用关系
- key_inputs: `asset_path`, `direction/recursive/max_depth/include_*`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 用途：对任意资产建立 AssetRegistry 级引用关系图。凡是要替换角色、重建 AnimBP/Montage、清理旧资源、判断某个资产能否删除，都应先用此指令确认“它引用了谁”和“谁引用了它”，不要只靠单个蓝图导出或二进制字符串扫描。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 用途：对任意资产建立 AssetRegistry 级引用关系图。凡是要替换角色、重建 AnimBP/Montage、清理旧资源、判断某个资产能否删除，都应先用此指令确认“它引用了谁”和“谁引用了它”，不要只靠单个蓝图导出或二进制字符串扫描。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `direction/recursive/max_depth/include_*`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
