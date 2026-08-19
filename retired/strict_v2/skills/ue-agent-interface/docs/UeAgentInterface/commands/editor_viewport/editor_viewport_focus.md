---
command: editor_viewport_focus
category: editor_viewport
title: 命令表
summary: 聚焦目标并读回视口状态
aliases: []
tags: [editor_viewport]
status: active
---

# `editor_viewport_focus`

## LLM Compact

- status: active.
- purpose: 聚焦目标并读回视口状态
- key_inputs: `focus.mode`
- key_returns: `camera`, `focus_result`
- note: 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- note: 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- note: 用途：把视口聚焦到指定对象、区域或点，并返回写后状态。
- note: StaticMesh focus 返回的 `focus_result.bounds` 始终按 `asset_local` 表达；相机读写仍按 `asset_preview_world` 表达。
- validation: 读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。

## Authoring Notes

- 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- 用途：把视口聚焦到指定对象、区域或点，并返回写后状态。
- StaticMesh focus 返回的 `focus_result.bounds` 始终按 `asset_local` 表达；相机读写仍按 `asset_preview_world` 表达。
- Persona focus 返回的 `focus_result.bounds` 始终按 `persona_preview_world` 表达。
- Niagara focus 返回的 `focus_result.bounds` 始终按 `niagara_preview_world` 表达。
- IK Retargeter 可在 `target.viewport_role` 或 `focus.source_or_target` / `focus.role` / `focus.preview_role` 中传 `source` 或 `target`，决定聚焦源或目标预览组件；该选择不写入资产。

## Parameters

- `focus.mode`：聚焦目标；可为 selection、bounds、component、bone、socket 或 preview component 等 adapter 支持形式。
- Level viewport 的 `focus.mode=actor` 使用 `focus.actor_id` 作为规范标识字段，并兼容 `id/actor/actor_name/actor_label`。

## Returns

- `camera`：写后或读回的相机状态。
- `focus_result`：聚焦结果和命中的 focus bounds。

## Validation

读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。
