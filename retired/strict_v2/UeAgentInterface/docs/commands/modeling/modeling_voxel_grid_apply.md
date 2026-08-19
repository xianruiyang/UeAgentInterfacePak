---
command: modeling_voxel_grid_apply
category: modeling
title: 应用 Voxel Grid 会话
summary: 经 revision、破坏性授权和 sidecar 覆盖门禁后，将会话写入 Dynamic Mesh Actor 与 HJSON sidecar。
aliases: []
tags: [modeling, voxel, session, destructive, sidecar]
status: active
---

# `modeling_voxel_grid_apply`

## LLM Compact

- **用途**：把活动 Voxel Grid 会话构造成目标 Dynamic Mesh，并保存对应 `.hjson` sidecar。
- **关键输入**：`session_id`、`expected_revision`、`allow_destructive: true`、必要时 `overwrite_existing: true`。
- **关键返回**：`revision`、`session_closed`、`mutation_scope: asset_and_sidecar`、mesh/collision/metadata 读回。
- **安全边界**：apply 总是需要破坏性授权；覆盖既有 sidecar 还必须单独声明覆盖意图。

## Authoring Notes

- `expected_revision` 必填且必须等于会话当前 revision，防止陈旧调用覆盖后续 mutation。
- `allow_destructive: true` 对所有 apply 都是必需条件，因为命令会修改目标 Actor mesh 和持久化 sidecar。
- sidecar 已存在时，还必须提供 `overwrite_existing: true`。首次写入新 sidecar 不需要该字段。
- 默认 apply 后关闭会话；使用 `keep_session: true` 可保留会话，但后续仍必须使用返回的最新 revision。
- apply 是 begin/add/remove 流程中唯一承诺 `mutation_scope: asset_and_sidecar` 的命令。

## Parameters

- `session_id`：必填；必须引用活动会话。
- `expected_revision`：必填整数；必须等于当前会话 revision。
- `allow_destructive`：必填，必须为 `true`。
- `overwrite_existing`：当目标 sidecar 已存在时必填为 `true`；否则默认 `false`。
- `keep_session`：可选布尔值；为 `true` 时 apply 后保留会话。
- `material_path` 或 `material`：可选材质输入。
- `collision`：可选 collision 配置对象，包括模式、profile、enabled、replace_existing 与形状限制参数。

## Guard Matrix

| 场景 | 必需门禁 | 失败语义 |
|---|---|---|
| 未提供 revision | `expected_revision` | `expected_revision_required` |
| revision 陈旧 | 使用当前 revision 重试 | `voxel_grid_revision_mismatch` |
| 任意 apply | `allow_destructive: true` | `voxel_grid_apply_requires_allow_destructive` |
| sidecar 已存在 | `overwrite_existing: true` | `voxel_grid_sidecar_overwrite_requires_overwrite_existing` |

## Returns

- `session_id`、`grid_id`、`actor_id`、`label`
- `revision`、`occupied_cell_count`
- `session_closed`
- `sidecar_path`
- `mutation_scope: asset_and_sidecar`
- `asset_modified: true`
- `sidecar_modified: true`
- mesh、collision 和 metadata 读回。

## Minimal Example

```json
{
  "session_id": "voxel-session-01",
  "expected_revision": 2,
  "allow_destructive": true,
  "overwrite_existing": true,
  "keep_session": false
}
```

## Validation

1. 确认 `mutation_scope`、`asset_modified` 与 `sidecar_modified` 表明资产和 sidecar 均已修改。
2. 读回目标 Actor 的 mesh/collision/metadata，并核对 `sidecar_path` 指向 `.hjson`。
3. 根据 `session_closed` 决定是否还能继续使用该 `session_id`。
