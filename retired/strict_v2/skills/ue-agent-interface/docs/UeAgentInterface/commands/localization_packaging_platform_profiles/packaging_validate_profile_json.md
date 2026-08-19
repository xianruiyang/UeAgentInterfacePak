---
command: packaging_validate_profile_json
category: localization_packaging_platform_profiles
title: Packaging
summary: 校验平台、配置、map、UAT 和 archive 目录
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_validate_profile_json`

## LLM Compact

- status: active.
- purpose: 校验平台、配置、map、UAT 和 archive 目录
- key_inputs: `json_file`, `json`
- key_returns: `valid`, `error_count`, `estimated_actions[]`, `issues[]`
- behavior: 只读校验；不注册任务、不启动 UAT、不创建 archive 或任务文件。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 校验 `platform/configuration/maps/cultures/archive_directory` 和 RunUAT 可用性。platform、map、culture、archive token 必须阻断 shell 元字符注入。
- `maps[]` 必须是存在的 UE long package name；archive 必须位于项目 `Saved/UeAgentInterface/Packages` 根或其后代目录。

## Parameters

- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `valid`：校验是否通过。
- `estimated_actions[]`：estimated_actions 列表摘要；大列表应写入 output/artifact 或 debug。
- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `error_count`：error 级 issue 数量。

## Validation

检查 `valid/error_count/issues/estimated_actions`。校验不通过时命令失败并返回 `packaging_validate_failed`；常见 issue code 包括 `platform_token_unsafe`、`configuration_invalid`、`uat_not_found`、`map_token_unsafe`、`map_not_found`、`culture_token_unsafe`、`archive_dir_unsafe` 和 `archive_dir_token_unsafe`。
