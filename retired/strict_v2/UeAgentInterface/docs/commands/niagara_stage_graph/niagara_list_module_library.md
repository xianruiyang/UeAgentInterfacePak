---
command: niagara_list_module_library
category: niagara_stage_graph
title: niagara_list_module_library
summary: **兼容/底层只读**：查询当前 UE 会话可用 Niagara script 库；新 HJSON authoring 优先使用 `node_catalog_search`
aliases: []
tags: [niagara_stage_graph]
status: active
---

# `niagara_list_module_library`

## LLM Compact

- status: active.
- purpose: **兼容/底层只读**：查询当前 UE 会话可用 Niagara script 库；新 HJSON authoring 优先使用 `node_catalog_search`
- key_inputs: `category`, `include_non_module_scripts`, `limit`, `name_contains`, `root_path`, `search`
- key_returns: `items[].asset_path`, `items[].is_module_script`, `items[].supported_usages`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `category`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_non_module_scripts`：布尔/开关字段；默认值以本命令契约为准。
- `limit`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `name_contains`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `root_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `search`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `items[].asset_path`：路径字段；通常为 UE 资产路径、对象路径或输出文件路径，具体语义按命令上下文。
- `items[].is_module_script`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `items[].supported_usages`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
