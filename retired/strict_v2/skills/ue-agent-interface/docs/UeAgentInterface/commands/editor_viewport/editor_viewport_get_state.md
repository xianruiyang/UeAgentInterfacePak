---
command: editor_viewport_get_state
category: editor_viewport
title: 命令表
summary: 读取指定视口状态
aliases: []
tags: [editor_viewport]
status: active
---

# `editor_viewport_get_state`

## LLM Compact

- status: active.
- purpose: 读取指定视口状态
- key_inputs: `target`, `asset_path`, `scope`, `viewport`
- key_returns: `camera`, `schema`, `capabilities`, `preview_state`, `target`, `visual_options`
- note: 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- note: 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- note: 用途：读取目标视口状态，不修改视口。
- note: IK Rig `preview_state.context="ik_rig"`，并报告 `asset_path`、`asset_type`、`viewport_role="primary"`、`preview_mesh_asset_path`、`component`、`goals_count` 和 `goals[]`。
- validation: 读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。

## Authoring Notes

- 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- 用途：读取目标视口状态，不修改视口。
- IK Rig `preview_state.context="ik_rig"`，并报告 `asset_path`、`asset_type`、`viewport_role="primary"`、`preview_mesh_asset_path`、`component`、`goals_count` 和 `goals[]`。
- IK Retargeter `preview_state.context="ik_retargeter"`，并报告 `source_or_target` / `active_role`、`current_role`、`output_mode`、`source`、`target`、`active_component`、`role_goals_count` 和 `role_goals[]`。
- 对 Texture / RenderTarget / Media / Paper2D / SubUV / SparseVolumeTexture asset type 调用 `editor_viewport_get_state`、`editor_viewport_set_camera`、`editor_viewport_focus`、`editor_viewport_set_visual_options`、`editor_viewport_set_preview_state` 或 `editor_viewport_screenshot` 会返回 `ok=false` 和明确错误码。
- Texture：`special_texture_preview_not_3d_editor_viewport`。
- RenderTarget：`special_render_target_preview_not_3d_editor_viewport`。
- Media：`special_media_preview_not_3d_editor_viewport`。
- Paper2D：`special_paper2d_preview_not_3d_editor_viewport`。

## Parameters

- `target`：统一目标对象；用于指定 level viewport、asset editor、资产或组件。
- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `scope`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `viewport`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `camera`：写后或读回的相机状态。
- `schema`：返回 payload schema。
- `capabilities`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `preview_state`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `target`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `visual_options`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。
