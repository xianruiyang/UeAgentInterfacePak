---
command: asset_fixup_redirectors
category: core_level
title: Core / Session
summary: 删除资产移动后已无引用的 `ObjectRedirector`
aliases: []
tags: [core_level]
status: active
---

# `asset_fixup_redirectors`

## LLM Compact

- status: active.
- purpose: 删除资产移动后已无引用的 `ObjectRedirector`
- key_inputs: `asset_path`, `asset_paths`, `folder_path`, `folder_paths`, `recursive`, `dry_run`, `allow_destructive`, `fail_on_blocked`
- key_returns: `redirector_count`, `deletable_redirector_count`, `blocked_redirector_count`, `deleted_redirector_count`, `remaining_package_count`, `redirectors[]`, `blocked[]`, `remaining_packages[]`
- behavior: 默认 `dry_run=true`；存在可删除 Redirector 时，真实删除必须同时显式传 `dry_run=false` 和 `allow_destructive=true`。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `dry_run`：默认 `true`，只报告候选、阻断项和当前包存在性，不删除 Redirector。
- `allow_destructive`：默认 `false`。当 `dry_run=false` 且存在可删除 Redirector 时必须显式为 `true`；否则返回 `allow_destructive_required`，`deleted_redirector_count=0`，并在 `blocked[]` 中保留阻断原因。
- `folder_path`：Outliner folder 或资产 folder；具体含义以命令所在领域为准。
- `folder_paths`：多个 folder 路径。
- `recursive`：是否包含子 folder/子对象。
- `asset_paths`：多个 Redirector 资产路径。
- `fail_on_blocked`：默认 `true`；任一 Redirector 仍有引用时返回 `redirector_still_referenced`，不继续删除。

## Returns

- `redirector_count` / `deletable_redirector_count` / `blocked_redirector_count`。
- `deleted_redirector_count`：dry-run 或安全确认被阻断时为 `0`。
- `remaining_package_count` / `remaining_packages[]`：删除后包存在性读回；不能只依据 `deleted_redirector_count` 判断完成。
- `redirectors[]` / `blocked[]` / `skipped[]`：候选、阻断原因和非 Redirector/未找到输入。

## Validation

先用默认 dry-run 审阅 `redirectors[]`、`blocked[]` 和 `deletable_redirector_count`。真实执行后必须确认 `remaining_package_count=0`；失败时保留 `blocked[]` 和 `remaining_packages[]` 作为 readback 证据。
