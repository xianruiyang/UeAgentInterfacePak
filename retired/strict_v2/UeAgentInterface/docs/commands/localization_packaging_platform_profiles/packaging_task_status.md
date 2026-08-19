---
command: packaging_task_status
category: localization_packaging_platform_profiles
title: Packaging
summary: 查询 UAI 任务记录或当前进程状态
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_task_status`

## LLM Compact

- status: active.
- purpose: 查询 UAI 任务记录或当前进程状态
- key_inputs: `task_id`
- key_returns: `task_id`, `status`, `phase`, `running`, `exit_code`, `last_log_lines[]`
- behavior: 只接受严格 task id，并从内存任务或 UAI-owned `report.hjson` 读回一致状态。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- task id 格式严格为 `<prefix>_YYYYMMDDTHHMMSSZ_<8 hex>`；prefix 仅允许 `packaging`、`localization_gather`、`localization_compile`，时间戳必须是有效 UTC 日历时间。
- 读取持久 report 时会核对 report 内 `task_id` 与请求完全一致。

## Parameters

- `task_id`：必填；必须符合上述严格格式，不能传目录名、路径或任意字符串。

## Returns

- `exit_code`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `last_log_lines[]`：last_log_lines 列表摘要；大列表应写入 output/artifact 或 debug。
- `phase`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `running`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

缺少 id 返回 `missing_task_id`，格式错误返回 `invalid_task_id`，不存在返回 `task_not_found`，report 内 id 不一致返回 `task_report_invalid`。成功时以返回的 `status/phase/running/exit_code` 为准。
