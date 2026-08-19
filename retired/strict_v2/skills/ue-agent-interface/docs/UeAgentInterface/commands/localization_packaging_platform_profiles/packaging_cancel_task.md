---
command: packaging_cancel_task
category: localization_packaging_platform_profiles
title: Packaging
summary: 取消 planned/running 任务
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_cancel_task`

## LLM Compact

- status: active.
- purpose: 取消 planned/running 任务
- key_inputs: `kill_process_tree`, `task_id`
- key_returns: `task_id`, `status`, `phase`, `cancelled`, `kill_process_tree`, `processes[]`
- behavior: 只取消已注册的内存任务；unknown task 不成功，cancel 响应与后续 status 使用同一任务状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- task id 格式严格为 `<prefix>_YYYYMMDDTHHMMSSZ_<8 hex>`；prefix 仅允许 `packaging`、`localization_gather`、`localization_compile`，时间戳必须有效。
- `planned/running/cancelling` 转为并持久化 `cancelled`；已 `cancelled` 再次取消为幂等成功；其他终态返回 `task_not_running`。

## Parameters

- `kill_process_tree`：默认 `true`；存在运行进程时控制是否终止进程树。
- `task_id`：必填；必须是已注册任务的严格格式 id。

## Returns

- `cancelled`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `processes[]`：processes 列表摘要；大列表应写入 output/artifact 或 debug。
- `status` / `phase`：取消后持久化的任务状态，后续 status 查询应保持一致。

## Validation

缺少 id 返回 `missing_task_id`，格式错误返回 `invalid_task_id`，unknown task 返回 `task_not_found`。成功取消后调用 `packaging_task_status`，确认 `status=cancelled`。
