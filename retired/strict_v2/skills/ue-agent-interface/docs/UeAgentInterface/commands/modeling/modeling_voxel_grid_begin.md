---
command: modeling_voxel_grid_begin
category: modeling
title: 开始 Voxel Grid 编辑会话
summary: 创建或载入带 revision 的内存 Voxel Grid 会话，并对编辑与 sidecar 覆盖执行显式安全门禁。
aliases: []
tags: [modeling, voxel, session]
status: active
---

# `modeling_voxel_grid_begin`

## LLM Compact

- **用途**：开始一个可增量修改、最后由 `modeling_voxel_grid_apply` 写入资产与 sidecar 的会话。
- **关键输入**：`mode`、`session_id`、`grid_id`、`actor_id`、`grid`、`allow_destructive`、`overwrite_existing`。
- **关键返回**：`session_id`、`grid_id`、`actor_id`、`revision`、`occupied_cell_count`、`sidecar_path`。
- **安全边界**：编辑既有网格必须显式授权；创建模式覆盖既有 sidecar 必须同时提供覆盖意图和破坏性授权。

## Authoring Notes

- `mode: create` 创建空内存会话；不会在 begin 阶段保存 sidecar。
- `mode: edit` 或 `modify` 从目标 Actor 关联的 sidecar 载入既有网格，属于破坏性编辑入口。
- 同一个 `session_id` 不能重复使用，同一个 `grid_id` 同时只能有一个活动会话。
- 返回的 `revision` 是后续 add/remove/apply 的并发控制基线。每次会话 mutation 后都必须使用最新 revision。
- sidecar 使用 `.hjson`。创建模式若目标 sidecar 已存在，只有 `overwrite_existing: true` 与 `allow_destructive: true` 同时存在才允许开始覆盖会话。

## Parameters

- `mode`：可选，`create`、`edit` 或 `modify`，默认 `create`。
- `session_id`：可选字符串；省略时生成。显式或生成的 ID 都不得与活动会话重复。
- `grid_id`：创建模式可选；省略时生成。编辑模式从目标 Actor/sidecar 解析并校验。
- `actor_id`：编辑或修改模式必填；创建模式可省略。
- `grid`：创建模式的可选对象：
  - `cell_size`：体素尺寸。
  - `origin`：网格世界原点。
  - `rotation`：网格相对世界的旋转。
- `cell_size`、`origin`、`rotation`：`grid` 子字段的顶层兼容写法；不要与 `grid` 中的同名字段给出冲突值。
- `label`：创建 Actor 的可选标签。
- `folder_path`：创建 Actor 的可选 World Outliner 文件夹。
- `overwrite_existing`：创建模式覆盖既有 sidecar 的明确意图，默认 `false`。
- `allow_destructive`：破坏性授权，默认 `false`。编辑/修改模式必填为 `true`；创建模式覆盖既有 sidecar 时也必填为 `true`。

## Guard Matrix

| 场景 | 必需门禁 | 失败语义 |
|---|---|---|
| 重复 `session_id` | 必须换用未占用 ID | `voxel_grid_session_id_in_use` |
| 同一 `grid_id` 已有活动会话 | 必须先结束现有会话 | `voxel_grid_active_session_exists` |
| `edit` / `modify` | `allow_destructive: true` | `voxel_grid_edit_requires_allow_destructive` |
| `create` 且 sidecar 已存在 | `overwrite_existing: true` | `voxel_grid_sidecar_exists` |
| 覆盖既有 sidecar | 同时要求 `allow_destructive: true` | `voxel_grid_sidecar_overwrite_requires_allow_destructive` |

## Returns

- `session_id`、`grid_id`
- `actor_id`、`label`
- `cell_size`、`grid_origin`、`grid_rotation`
- `revision`、`occupied_cell_count`、`dirty`
- `sidecar_path`
- `anchor`：会话解析后的网格锚点读回；不是 begin 输入参数。

## Minimal Example

```json
{
  "mode": "create",
  "grid": {
    "cell_size": 25.0,
    "origin": [0.0, 0.0, 0.0],
    "rotation": [0.0, 0.0, 0.0]
  },
  "label": "Voxel_Blockout"
}
```

## Validation

记录返回的 `session_id` 与 `revision`，并在下一条 mutation 命令中原样传入。编辑模式还应核对 `grid_id`、Actor 与 sidecar 路径是否一致。
