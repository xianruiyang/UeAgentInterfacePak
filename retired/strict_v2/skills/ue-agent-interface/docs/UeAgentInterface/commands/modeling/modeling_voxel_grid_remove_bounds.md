---
command: modeling_voxel_grid_remove_bounds
category: modeling
title: 从 Voxel Grid 会话移除 Bounds
summary: 经破坏性授权后在指定 revision 的活动会话内移除体素，只修改会话内存状态。
aliases: []
tags: [modeling, voxel, session, bounds, destructive]
status: active
---

# `modeling_voxel_grid_remove_bounds`

## LLM Compact

- **用途**：从活动 Voxel Grid 会话移除 bounds 覆盖的体素。
- **关键输入**：`session_id`、`expected_revision`、`bounds`、`allow_destructive: true`。
- **关键返回**：`revision`、`changed_cell_count`、`occupied_cell_count`、`mutation_scope: session`。
- **修改范围**：只修改内存会话；不删除 Actor、不修改 mesh/资产 package，也不改写 sidecar。

## Authoring Notes

- `expected_revision` 必填且必须等于当前 revision。
- remove 是破坏性 session mutation，必须显式提供 `allow_destructive: true`。
- 成功后 revision 递增；下一条 mutation 或 apply 必须使用返回的新 revision。
- 返回 `mutation_scope: session` 是为了避免把“移除体素”误判为已经删除持久化资产内容。

## Parameters

- `session_id`：必填；必须引用活动会话。
- `expected_revision`：必填整数；必须等于当前会话 revision。
- `allow_destructive`：必填，必须为 `true`。
- `bounds`：必填对象，使用以下一种完整形式：
  - `center` + `extent`
  - `min` + `max`
- `bounds_center` + `bounds_extent`：可选顶层别名。
- `bounds_min` + `bounds_max`：可选顶层别名。
- `space`：可选 bounds 空间标识；按会话网格的空间转换规则解析。

## Returns

- `operation: remove_bounds`
- `session_id`、`grid_id`
- `revision`：mutation 后的新 revision。
- `changed_cell_count`、`occupied_cell_count`
- 规范化 `bounds`
- `mutation_scope: session`
- `asset_modified: false`
- `sidecar_modified: false`

## Errors

- `expected_revision_required`：未提供 revision 前置条件。
- `voxel_grid_revision_mismatch`：会话 revision 已变化。
- `voxel_grid_remove_requires_allow_destructive`：未提供破坏性授权。
- bounds 不完整、会话不存在或空间参数无效时命令明确失败。

## Minimal Example

```json
{
  "session_id": "voxel-session-01",
  "expected_revision": 1,
  "allow_destructive": true,
  "bounds": {
    "min": [-50.0, -50.0, 0.0],
    "max": [50.0, 50.0, 200.0]
  }
}
```

## Validation

确认 `mutation_scope` 为 `session`，两个持久化修改标志均为 `false`；将返回的 `revision` 用于下一条 mutation 或 apply。
