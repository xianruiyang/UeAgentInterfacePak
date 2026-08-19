---
command: level_content_delete_scope
category: level_content
title: Delete Level Content Scope
summary: 按 Outliner folder 清理当前关卡 Actor，交互语义对齐 asset_delete。
aliases: []
tags: [level_content, delete, cleanup, whitebox]
status: active
---

# `level_content_delete_scope`

## LLM Compact

- status: active.
- purpose: 按 Outliner folder 清理当前关卡 Actor，交互语义对齐 asset_delete。
- key_inputs: `folder_path`, `folder_root`, `folder_paths`, `folder_roots`, `recursive`, `include_child_folders`, `dry_run`, `allow_destructive`, `fail_on_blocked`, `managed_tag`, `managed_ids`, `allow_unmanaged_delete` ...
- key_returns: `folder_expansions[]`, `actors[]`, `deletable_count`, `blocked_count`, `blocked[]`, `deleted_actors[]`, `deleted_count`, `remaining_actor_count` ...
- behavior: 破坏性命令；先 dry-run/plan，确认候选、阻断项和保护规则后再执行。
- note: 只清理当前关卡 Outliner folder 内 Actor，不删除 Content Browser 资产；默认 `dry_run=true`，确认候选后才传 `dry_run=false`。
- note: 托管删除应结合 `folder_root`/`managed_tag`/`managed_ids`/`protected_tags`，避免误删用户手工内容。
- note: `allow_unmanaged_delete` 默认 `false`。真实删除必须同时显式传 `dry_run=false` 和 `allow_destructive=true`；允许未托管 Actor 还需额外显式 `allow_unmanaged_delete=true`。
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- validation: 写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。

## Authoring Notes

- 只清理当前关卡 Outliner folder 内 Actor，不删除 Content Browser 资产；默认 `dry_run=true`，确认候选后才传 `dry_run=false`。
- 托管删除应结合 `folder_root`/`managed_tag`/`managed_ids`/`protected_tags`，避免误删用户手工内容。
- 默认请求不会删除 Actor 或 folder。`allow_destructive` 是执行确认，`allow_unmanaged_delete` 是所有权范围放宽；二者语义不同，不能互相替代。
- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。

## Parameters

- `folder_path` / `folder_root` / `folder_paths` / `folder_roots`：必填其一。
- `recursive` / `include_child_folders`：默认 `true`。
- `dry_run`：默认 `true`。
- `allow_destructive`：默认 `false`；真实删除时必须显式为 `true`，否则返回 `allow_destructive_required`，`deleted_count=0`。
- `fail_on_blocked`：默认 `true`。
- `managed_tag` / `managed_ids`：托管保护。
- `protected_tags[]`：命中则阻断。
- `allow_unmanaged_delete`：默认 `false`；未命中 managed tag/id 的 Actor 会进入 `blocked[]`。仅在明确允许删除用户未托管 Actor 时显式设为 `true`。
- `delete_empty_folders` / `delete_folders`：默认 `true`。
- `save_level`：默认 `false`，保存复用 `save_current_level` 风险保护。
- `protected_tags`：删除/替换保护 tag；命中后应阻断删除。

## Returns

- `folder_expansions[]`。
- `actors[]`：候选摘要。
- `deletable_count` / `blocked_count` / `blocked[]`。
- `deleted_actors[]` / `deleted_count`。
- `remaining_actor_count`。
- `folder_deletions[]`。
- `allow_destructive` / `allow_unmanaged_delete`：实际采用的安全策略读回。
- `schema`：返回 payload schema。

## Minimal Example

```json
{
  "command": "level_content_delete_scope",
  "params": {
    "folder_path": "UAI/WB_WhiteBox01/DamBoxGarden",
    "recursive": true,
    "dry_run": true,
    "fail_on_blocked": true
  }
}
```

## Validation

先 dry-run，确认没有 protected/blocked 后再执行；执行后用 query 或 nearby shapes 确认 folder 下没有残留白盒 Actor。
真实执行还必须检查 `destroy_actors_ok=true`、`remaining_actor_count=0`，以及 `folder_deletions[].folder_exists_after`；任一删除后存在性验证失败都会使命令失败。
