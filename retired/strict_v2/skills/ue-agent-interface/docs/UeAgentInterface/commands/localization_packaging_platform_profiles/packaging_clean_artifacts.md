---
command: packaging_clean_artifacts
category: localization_packaging_platform_profiles
title: Packaging
summary: 清理 `Saved/UeAgentInterface/Packages` 下 UAI 托管打包输出
aliases: []
tags: [localization_packaging_platform_profiles]
status: active
---

# `packaging_clean_artifacts`

## LLM Compact

- status: active.
- purpose: 清理 `Saved/UeAgentInterface/Packages` 下 UAI 托管打包输出
- key_inputs: `archive_dir`, `dry_run`, `allow_delete`, `max_delete_bytes`
- key_returns: `dry_run`, `allow_delete`, `deleted[]`, `freed_bytes`
- behavior: 删除范围仅限 UAI-owned Packages 根；默认 dry-run，实际删除需要独立 permission 并受活跃任务和容量 guard 保护。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- `archive_dir` 仅允许项目 `Saved/UeAgentInterface/Packages` 根或其后代目录，不能用任意 `Saved`、项目外路径或路径穿越扩大范围。
- 非 dry-run 会阻断活跃 packaging 任务，并在删除后检查删除 API 返回值和目录是否仍存在。

## Parameters

- `dry_run`：默认 `true`；只扫描并报告拟删除文件，不删除目录。
- `archive_dir`：必填；必须解析到 UAI-owned Packages 根或其后代目录。
- `allow_delete`：默认 `false`；非 dry-run 必须显式传 `true`。
- `max_delete_bytes`：默认 `1073741824`（1 GiB）；必须是有限正数，扫描总量超过上限即拒绝。

## Returns

- `deleted[]`：dry-run 时是拟删除文件列表；实际执行成功时是已删除目录内的扫描文件列表。
- `freed_bytes`：扫描到的总字节数；实际删除失败时命令整体失败，不得据此宣称已释放空间。

## Validation

路径越界返回 `archive_dir_not_uai_owned`；容量参数无效或超限返回 `max_delete_bytes_invalid` / `max_delete_bytes_exceeded`；缺少删除授权返回 `requires_delete_permission`；活跃任务返回 `packaging_task_active` 及 `active_task_id`；删除 API 失败或目录残留返回 `delete_directory_failed`。
