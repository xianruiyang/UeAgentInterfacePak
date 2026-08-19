---
command: editor_viewport_screenshot
category: editor_viewport
title: Editor Viewport Screenshot
summary: 临时组合 camera/focus/visual_options/preview_state 后截图，默认恢复视口状态。
aliases: [screenshot_viewport]
tags: [viewport, screenshot, focus, whitebox]
status: active
---

# `editor_viewport_screenshot`

## LLM Compact

- status: active.
- purpose: 临时组合 camera/focus/visual_options/preview_state 后截图，默认恢复视口状态。
- key_inputs: `target`, `output_file`, `format`, `max_size`, `restore_after_capture`, `allow_window_mutation`, `restore_window_after_capture`, `camera`, `focus`, `visual_options` ...
- key_returns: `file_path`, `width`, `height`, `capture_backend`, `pixel_signal`, `camera_before`, `camera_after_apply`, `restore_result` ...
- note: 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- note: Level viewport 未显式传 `target.viewport` 时会自动优先选择透视 viewport；需要固定人工当前视口时传 `viewport=active`，需要固定编号时传 `viewport=index_N` 或 `viewport_id=level:N`。
- note: 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- note: 可临时组合 camera/focus/visual_options/preview_state 后截图，默认应恢复；`pixel_signal` 只证明画面非空，不替代几何读回。
- note: `allow_window_mutation` 默认 `false`；承载 viewport 的 Slate 窗口最小化或隐藏时，只有显式传 `true` 才会临时 Restore/Show/BringToFront，`restore_window_after_capture=true` 默认在截图后恢复原最小化状态。
- note: StaticMesh Editor 在可渲染但初始 viewport size 为 0 的 unattended smoke 中，会尝试对 `FSceneViewport` 临时设置固定尺寸来完成 backbuffer 截图；截图完成或失败后会清除该临时尺寸。`-NullRHI` 下仍会安全失败为 `invalid_viewport_size` 或 `read_pixels_failed`。
- note: `tick_editor_world=true` 的多帧推进会同时推进 `GFrameCounter`，确保 TickTaskManager 将每次 `UWorld::Tick` 视为独立帧，而不是只执行第一帧。
- note: Level 场景中的 NiagaraComponent 需要精确时间对比时，使用 `preview_state.actor_id/component_id/absolute_time_seconds` 走 Niagara DesiredAge 定帧；不要依靠截图请求墙钟耗时或把非 UPROPERTY 运行时字段写进组件 `properties[]`。
- validation: 读回 target/camera/visual_options/preview_state；截图检查 `file_path` 与 `pixel_signal.nonblank`，再结合目标状态验证。

## Authoring Notes

- 统一覆盖 Level viewport 与支持的资产预览窗口；target 的 `scope/asset_type/asset_path/viewport_role` 用于选择 adapter。
- Level viewport 未显式传 `target.viewport` 时会自动优先选择透视 viewport；需要固定人工当前视口时传 `viewport=active`，需要固定编号时传 `viewport=index_N` 或 `viewport_id=level:N`。
- 不同 adapter 的 camera/focus 使用各自 preview world，不得与 Level world 或资产局部空间混用。
- 可临时组合 camera/focus/visual_options/preview_state 后截图，默认应恢复；`pixel_signal` 只证明画面非空，不替代几何读回。
- `allow_window_mutation` 默认 `false`；承载 viewport 的 Slate 窗口最小化或隐藏时，只有显式传 `true` 才会临时 Restore/Show/BringToFront，`restore_window_after_capture=true` 默认在截图后恢复原最小化状态。
- StaticMesh Editor 在可渲染但初始 viewport size 为 0 的 unattended smoke 中，会尝试对 `FSceneViewport` 临时设置固定尺寸来完成 backbuffer 截图；截图完成或失败后会清除该临时尺寸。`-NullRHI` 下仍会安全失败为 `invalid_viewport_size` 或 `read_pixels_failed`。
- `tick_editor_world=true` 时，`editor_world_tick_frames` 与 `editor_world_tick_delta_seconds` 定义截图前的合成帧推进；实现同时推进 `GFrameCounter`，避免 TickTaskManager 把连续 world tick 当成同一帧。
- Persona / ControlRig / Blueprint SCS / Niagara System / Material / IK Editor 截图同样走通用 editor viewport backbuffer；可渲染但初始 viewport size 为 0 时会尝试临时 fixed viewport size。Blueprint SCS adapter 还会在解析 Components 视口时激活 SCS viewport tab 并触发布局 tick，避免 unattended 资产编辑器里出现 0x0 viewport。
- 自动化 smoke 在 `-NullRHI` 下只覆盖 Level adapter。StaticMesh、Persona-family、ControlRig、Blueprint SCS、Niagara System、Material 与 IK 等独立 asset editor 窗口不会在 NullRHI smoke 中打开，因为 UE 5.6 headless standalone asset editor layout persistence 会触发 `GetRestoredDimensions` 崩溃；这些 asset editor adapter 由非 NullRHI smoke 覆盖。
- IK Retargeter asset editor 自动打开会卡在 UE 5.6 编辑器初始化链路；该风险已在 unattended 命令行和 Agent 启动的最小化普通 Editor 会话中复现。因此 `open_editor_if_needed=true` 且编辑器未打开时会快速返回 `ik_retargeter_editor_open_unsupported_unattended` 或 `ik_retargeter_editor_open_requires_existing_editor`。同一 IK adapter 仍可控制已打开的 IK Retargeter 预览。
- Material adapter 只覆盖 `SMaterialEditor3DPreviewViewport`；材质图节点预览、材质函数图 canvas、材质实例参数面板和 UMG/Slate 2D 预览不属于 3D viewport camera/focus 能力。
- 旧 Level Viewport 相机和 Actor/Selection 聚焦入口、StaticMesh / Blueprint / AnimBlueprint / ControlRig 预览相机入口已被统一 `editor_viewport_get_state`、`editor_viewport_set_camera`、`editor_viewport_focus` 覆盖，并迁入 `deprecatedCommand`。旧入口仍保留兼容 wrapper，但新 authoring 应直接使用统一命令。
- Level viewport 的 `visual_options.view_mode` 使用统一完整模式表，支持 `quad_overdraw`、`shader_complexity_with_quad_overdraw` 等 optimization 模式，以及 `visualization_family` + `visualization_mode` 形式的 Buffer/Nanite/Lumen 等 Visualization 模式；`restore_after_capture=true` 会恢复原 view mode 和具体 Visualization 子模式。
- Level viewport 的 `preview_state` 可选择场景 NiagaraComponent：`actor_id` 是 Actor 名称/标签，`component_id` 是组件名称/路径，`component_name` 为兼容别名；`absolute_time_seconds`、`tick_delta_seconds`、`reset`、`pause_after_advance` 与 Niagara 资产预览使用同一时间语义。`restore_after_capture=true` 会同时恢复该组件的运行时预览状态。
- Level Niagara 定帧只在真实 `actual_age_seconds` 达到请求时间后截图；初始化或 seek 未生效时返回 `level_preview_seek_incomplete`，不会把请求值回显当作成功。

## Parameters

- `target`：可嵌套或平铺；缺省是 level viewport auto 选择，优先透视 viewport。资产预览传 `scope=asset_editor`、`asset_type`、`asset_path`、`open_editor_if_needed`。
- `output_file`：截图输出路径。
- `format`：常用 `png`。
- `max_size`：限制尺寸。
- `restore_after_capture`：默认 `true`。
- `allow_window_mutation`：默认 `false`；显式传 `true` 时允许在 viewport 窗口最小化/隐藏时临时恢复窗口以获得有效 backbuffer。
- 当请求同时包含 `focus/camera/visual_options/preview_state` 时，窗口准备发生在这些临时预处理之前；因此最小化窗口下的聚焦与截图共享同一有效 viewport，并在结束后统一恢复。
- `restore_window_after_capture`：默认 `true`；若截图前窗口是最小化状态，截图后尽量恢复最小化。
- `camera`：可选相机状态。
- `focus`：可选聚焦对象或自定义范围/点；Level viewport 使用 `actor`、`actors`、`selection`、`custom_bounds`、`custom_point`。`actor` 模式的规范标识字段是 `actor_id`，并兼容 `id/actor/actor_name/actor_label`；`custom_bounds` 传 `min/max`，不是 `center/extent`。
- `visual_options`：视图模式、overlay/show flags。
- Level viewport 可在 `visual_options.view_mode` 传稳定模式 key，例如 `lit`、`quad_overdraw`、`shader_complexity_with_quad_overdraw`；也可传 `visualization_family` 与 `visualization_mode`。资产预览窗口只接受对应 adapter 在 capabilities 中声明的模式。
- `preview_state`：adapter 专属预览状态；Level Niagara 定帧使用 `actor_id`、`component_id`、`absolute_time_seconds`，可选 `tick_delta_seconds/reset/pause_after_advance`。
- `tick_editor_world`：是否在截图前推进当前 Editor World。
- `editor_world_tick_frames`：合成推进帧数，范围 `0..240`。
- `editor_world_tick_delta_seconds`：每帧步长，范围 `1/240..1/5` 秒。

## Returns

- `file_path` / `width` / `height`。
- `capture_backend`。
- `pixel_signal`。
- `camera_before` / `camera_after_apply`。
- `restore_result`。
- `visual_options_applied` / `preview_state_applied`。
- `capture.editor_world_ticks_performed` / `capture.global_frame_counter_advances_performed`：实际 world tick 与全局帧计数推进次数。

## Minimal Example

```json
{
  "command": "editor_viewport_screenshot",
  "params": {
    "output_file": "runtimeLogs/area_a01_interface.png",
    "format": "png",
    "max_size": 1024,
    "restore_after_capture": true,
    "focus": {
      "mode": "custom_bounds",
      "min": [-300, -200, -60],
      "max": [300, 200, 300]
    },
    "visual_options": {
      "view_mode": "lit",
      "overlays": { "grid": true, "bounds": false }
    }
  }
}
```

## Validation

截图返回 `pixel_signal.nonblank=true` 只表示非空图；接口方向、标签位置、楼梯连接和遮挡仍需结合空间感知、结构化读回和 sweep 判断。
