---
command: retarget_batch_export_json
category: ikrig_ikretargeter
title: IK Retargeter
summary: 生成批量重定向单文件 HJSON
aliases: []
tags: [ikrig_ikretargeter]
status: active
---

# `retarget_batch_export_json`

## LLM Compact

- status: active.
- purpose: 生成批量重定向单文件 HJSON
- key_inputs: `output_file`, `asset_paths[]`, `output_folder`, `prefix`, `suffix`, `search`, `replace`, `retargeter` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 大对象或长列表优先传 `output_file`，compact 返回只保留摘要和路径。
- 命令名保留历史 `json`；authoring 文件格式为 HJSON。`output_file` 传 `.json` 会规范化写到同名 `.hjson`，`json_file` 传 `.json` 时按同名 `.hjson` 读取。

## Parameters

- `output_file`：输出 artifact 路径；authoring 文件使用 HJSON，`.json` 后缀会规范化为 `.hjson`。大结果应写文件，不要内联到 compact data。
- `asset_paths[]`：asset_paths 列表。
- `output_folder`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `prefix`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `suffix`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `search`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `replace`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `retargeter`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `source_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target_mesh`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
