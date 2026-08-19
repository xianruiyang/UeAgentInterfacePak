---
command: asset_delete
category: core_level
title: `asset_delete`
summary: 删除未被任何外部对象引用的资产
aliases: []
tags: [core_level]
status: active
---

# `asset_delete`

## LLM Compact

- status: active.
- purpose: 删除未被任何外部对象引用的资产
- key_inputs: `asset_path`, `dry_run`, `folder_path`, `folder_paths`, `recursive`, `allow_dirty`, `allow_non_game`, `asset_paths` ...
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 破坏性命令；先 dry-run/plan，确认候选、阻断项和保护规则后再执行。
- note: 同一条 `asset_delete` 请求里的资产集合会先完整归一化，显式 `asset_paths` 和 `folder_path/folder_paths` 展开的资产属于同一批次。
- note: AssetRegistry referencer 如果来自同批次资产，会计入 `internal_referencer_count` 并在对应 `referencers[]` 上标记 `internal_reference=true`，不会阻断删除。
- note: 路径字符串命中如果来自同批次资产，会计入 `internal_path_string_hit_count` 并在对应 `path_string_hits[]` 上标记 `internal_hit=true`，不会阻断删除。
- note: 只有同批次外部资产产生的 referencer 或路径字符串命中才计入 `external_*` 并按默认策略阻断。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 同一条 `asset_delete` 请求里的资产集合会先完整归一化，显式 `asset_paths` 和 `folder_path/folder_paths` 展开的资产属于同一批次。
- AssetRegistry referencer 如果来自同批次资产，会计入 `internal_referencer_count` 并在对应 `referencers[]` 上标记 `internal_reference=true`，不会阻断删除。
- 路径字符串命中如果来自同批次资产，会计入 `internal_path_string_hit_count` 并在对应 `path_string_hits[]` 上标记 `internal_hit=true`，不会阻断删除。
- 只有同批次外部资产产生的 referencer 或路径字符串命中才计入 `external_*` 并按默认策略阻断。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `dry_run`：只计划/报告不写入；删除类命令通常默认 true，执行删除需显式 false。
- `folder_path`：Outliner folder 或资产 folder；具体含义以命令所在领域为准。
- `folder_paths`：多个 folder 路径。
- `recursive`：是否包含子 folder/子对象。
- `allow_dirty`：布尔/开关字段；默认值以本命令契约为准。
- `allow_non_game`：布尔/开关字段；默认值以本命令契约为准。
- `asset_paths`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `delete_empty_folders`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `include_path_string_hits`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
