---
command: packaging_run_build
category: localization_packaging_platform_profiles
title: Packaging
summary: 计划或执行 UAT 打包任务
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_run_build`

## LLM Compact

- status: active.
- purpose: 计划或执行 UAT 打包任务
- key_inputs: `json_file`, `allow_uat`, `execute`, `json`, `timeout_seconds`
- key_returns: `persistent`, `status`, `task_id`, `log_file`, `report_file`, `commandlet_plan`
- behavior: `execute` 默认 `false`。计划模式无持久副作用；只有所有安全 guard 通过后才注册任务并启动 UAT。
- validation: 执行模式用 `task_id` 调用 `packaging_task_status`；计划模式只检查 plan，不能等待或取消。

## Authoring Notes

- profile 与 timeout 在任何任务注册前校验；`execute=true` 时还必须先通过显式 UAT permission 和 PIE guard。
- platform、map、culture、archive token 阻断 shell 元字符；map 必须是存在的 UE long package name；archive 必须位于项目 `Saved/UeAgentInterface/Packages` 根或其后代目录。
- `execute=false` 返回 `status=planned`、`persistent=false`，不返回 `task_id`，不创建 task/report/log/archive 文件。

## Parameters

- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `allow_uat`：默认 `false`。仅 `execute=true` 时使用；必须显式传 `true` 才允许启动 UAT。
- `execute`：默认 `false`。`false` 为纯 plan；`true` 请求注册并执行任务。
- `json`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `timeout_seconds`：默认 `1800`；必须是有限正数且不超过 `86400`。

## Returns

- `log_file`：文件路径字段；长 JSON/结果优先走文件。
- `report_file`：文件路径字段；长 JSON/结果优先走文件。
- `persistent`：是否已经注册并持久化任务；所有 guard 失败和 plan 模式均为 `false`。
- `status`：计划模式为 `planned`；执行模式返回已注册任务状态。
- `task_id`：仅执行模式成功注册任务后返回，用于 status/cancel。
- `commandlet_plan`：执行模式的 UAT 计划；计划模式直接返回同等计划字段。

## Validation

profile 或 timeout 不合法时返回 `packaging_validate_failed` 及 `issues/error_count/estimated_actions`；未授权返回 `requires_uat_permission`；PIE 活跃时返回 `pie_not_allowed`。这些失败均发生在任务注册前并返回 `persistent=false`。
