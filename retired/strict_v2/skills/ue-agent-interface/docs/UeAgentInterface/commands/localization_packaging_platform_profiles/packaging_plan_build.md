---
command: packaging_plan_build
category: localization_packaging_platform_profiles
title: Packaging
summary: 生成 UAT BuildCookRun 命令计划
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_plan_build`

## LLM Compact

- status: active.
- purpose: 生成 UAT BuildCookRun 命令计划
- key_inputs: `json_file`, `archive`, `configuration`, `cook`, `json`, `package`, `platform`, `stage`
- key_returns: `artifacts_expected[]`, `command_line`, `uat_args[]`
- behavior: 纯计划命令；校验 profile 并生成 UAT 参数，不注册任务、不启动进程、不创建 archive 或任务文件。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 对 platform、configuration、maps、cultures、RunUAT 和 archive 使用与 `packaging_validate_profile_json` 相同的安全校验。
- archive 必须位于项目 `Saved/UeAgentInterface/Packages` 根或其后代目录；返回的 `command_line` 仅供审阅，不表示已执行。

## Parameters

- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `archive`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `configuration`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `cook`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `package`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `platform`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `stage`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `artifacts_expected[]`：artifacts_expected 列表摘要；大列表应写入 output/artifact 或 debug。
- `command_line`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `uat_args[]`：uat_args 列表摘要；大列表应写入 output/artifact 或 debug。
- `valid`：profile 是否通过安全校验。
- `issues[]`：校验问题；命令仍返回计划，调用方必须先检查 `valid` 再决定是否执行。

## Validation

检查 `valid/issues/uat_args/command_line/artifacts_expected`；不得把 plan 响应视为任务已注册或构建已开始。
