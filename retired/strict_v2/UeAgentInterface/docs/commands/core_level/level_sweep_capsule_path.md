---
command: level_sweep_capsule_path
category: core_level
title: Capsule Sweep Path
summary: 沿折线路径执行胶囊 sweep，用于验证楼梯、走廊、门洞和跨层连接的角色通行净空。
aliases: []
tags: [scene, collision, validation, whitebox]
status: active
---

# `level_sweep_capsule_path`

## LLM Compact

- status: active.
- purpose: 沿折线路径执行胶囊 sweep，用于验证楼梯、走廊、门洞和跨层连接的角色通行净空。
- key_inputs: `points`, `points_mode`, `radius_cm`, `half_height_cm`, `step_cm`, `max_samples`, `trace_channel`, `snap_to_floor` ...
- key_returns: `pass`, `blocked`, `first_blocking_hit`, `samples`, `truncated`, `path_summary`
- note: 适合做“走廊/楼梯/电梯路径净空”的自动验收：把“中途被挡”变成可定位的 `segment_index` + 命中信息。
- note: 由于 `points_mode=feet` 更易生成（可从 OBB 顶面点派生），但必须明确“脚底→胶囊中心”的转换策略，否则会出现大量擦地误报；因此建议默认开启 `snap_to_floor + floor_clearance_cm`。
- note: 当阻挡段 `start_penetrating=true` 时，会在对应 `segments[]`（以及顶层首个阻挡信息）返回 `start_penetrating_advice`，提示如何降低擦地/初始重叠的误报。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 适合做“走廊/楼梯/电梯路径净空”的自动验收：把“中途被挡”变成可定位的 `segment_index` + 命中信息。
- 由于 `points_mode=feet` 更易生成（可从 OBB 顶面点派生），但必须明确“脚底→胶囊中心”的转换策略，否则会出现大量擦地误报；因此建议默认开启 `snap_to_floor + floor_clearance_cm`。
- 当阻挡段 `start_penetrating=true` 时，会在对应 `segments[]`（以及顶层首个阻挡信息）返回 `start_penetrating_advice`，提示如何降低擦地/初始重叠的误报。

## Parameters

- `points`：路径点数组，支持 `{x,y,z}` 或统一输入层兼容的 `[x,y,z]`。
- `points_mode`：`feet` / `center`，默认 `feet`。
- `radius_cm` / `half_height_cm`：角色胶囊尺寸，必填。
- `step_cm`：采样步长，默认 `50`。
- `max_samples`：最大采样点数，默认 `2048`。
- `trace_channel`：默认使用角色通行相关通道。
- `snap_to_floor`：在 feet 模式下可先向下贴合落脚面。
- `include_all_hits`：调试时返回更多命中信息，默认关闭以控制输出。
- `points[]`：points 列表。

## Returns

- `pass` / `blocked`：是否通过。
- `first_blocking_hit`：首个阻挡命中摘要。
- `samples` / `truncated`：采样数量与截断状态。
- `path_summary`：输入点和 sweep 语义摘要。

## Minimal Example

```json
{
  "command": "level_sweep_capsule_path",
  "params": {
    "points": [[0, 0, 0], [300, 0, 0], [600, 0, 200]],
    "points_mode": "feet",
    "radius_cm": 35,
    "half_height_cm": 90,
    "step_cm": 40
  }
}
```

## Validation

主路径连接、楼梯/斜坡/桥、区域直接接口完成后必须 sweep；失败时不得继续生成后续区域，先回到该连接或接口任务修复。
