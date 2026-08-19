---
command: data_asset_create
category: data_driven_data_asset_data_table
title: DataAsset / PrimaryDataAsset
summary: 按类创建 `UDataAsset / UPrimaryDataAsset` 实例资产
aliases: []
tags: [data_driven_data_asset_data_table]
status: active
---

# `data_asset_create`

## LLM Compact

- status: active.
- purpose: 按类创建 `UDataAsset / UPrimaryDataAsset` 实例资产
- key_inputs: `asset_path`, `class_path`, `backup`, `overwrite_policy`, `save_after_create`
- key_returns: `saved`, `asset_class`, `asset_path`, `backup_asset_path`, `object_path`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `class_path`：UE class path；未传时部分命令会按 `kind` 推导。
- `backup`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `overwrite_policy`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_create`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `saved`：是否保存资源或关卡。
- `asset_class`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `backup_asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `object_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
