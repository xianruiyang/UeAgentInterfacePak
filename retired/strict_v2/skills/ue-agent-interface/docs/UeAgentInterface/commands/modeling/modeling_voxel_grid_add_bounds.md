---
command: modeling_voxel_grid_add_bounds
category: modeling
title: 向 Voxel Grid 会话添加 Bounds
summary: 在指定 revision 的活动会话内添加体素，只修改会话内存状态。
aliases: []
tags: [modeling, voxel, session, bounds]
status: active
---

# `modeling_voxel_grid_add_bounds`

## LLM Compact

- **用途**：把 bounds 覆盖的体素加入活动 Voxel Grid 会话。
- **关键输入**：`session_id`、`expected_revision`、`bounds`。
- **关键返回**：`revision`、`changed_cell_count`、`occupied_cell_count`、`mutation_scope: session`。
- **修改范围**：只修改内存会话；不修改 Actor mesh、资产 package 或 sidecar。

## Authoring Notes

- `expected_revision` 必填。它必须等于会话当前 revision，不能省略并依赖最后写入覆盖。
- 成功 mutation 后 revision 递增；下一条 add/remove/apply 必须使用本次返回的新 revision。
- bounds 可使用 `{center, extent}` 或 `{min, max}`，也可使用等价顶层别名。
- `space` 必须明确与会话网格转换一致；返回值会给出规范化 bounds 供读回。

## Parameters

- `session_id`：必填；必须引用活动会话。
- `expected_revision`：必填整数；必须等于当前会话 revision。
- `bounds`：必填对象，使用以下一种完整形式：
  - `center` + `extent`
  - `min` + `max`
- `bounds_center` + `bounds_extent`：可选顶层别名。
- `bounds_min` + `bounds_max`：可选顶层别名。
- `space`：可选 bounds 空间标识；按会话网格的空间转换规则解析。

## Returns

- `operation: add_bounds`
- `session_id`、`grid_id`
- `revision`：mutation 后的新 revision。
- `changed_cell_count`、`occupied_cell_count`
- 规范化 `bounds`
- `mutation_scope: session`
- `asset_modified: false`
- `sidecar_modified: false`

## Errors

- `expected_revision_required`：未提供 revision 前置条件。
- `voxel_grid_revision_mismatch`：会话 revision 已变化，必须先读回并重新决策。
- bounds 不完整、会话不存在或空间参数无效时命令明确失败。

## Minimal Example

```json
{
  "session_id": "voxel-session-01",
  "expected_revision": 0,
  "bounds": {
    "center": [0.0, 0.0, 100.0],
    "extent": [200.0, 200.0, 100.0]
  }
}
```

## Validation

确认 `mutation_scope` 为 `session`，两个持久化修改标志均为 `false`；将返回的 `revision` 用于下一条 mutation。
