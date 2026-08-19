# 指令详解：Editor Viewport / Unified Preview

本分册记录统一编辑器视口预览指令。它的目标是把场景视口和各类资产预览窗口的 camera、focus、显示选项、preview state 和截图统一到同一套 `editor_viewport_*` 入口。

## 紧凑返回契约

- EditorViewport 指令默认按 `llm_compact` 返回 target 摘要、adapter/status、camera 关键字段、capabilities 摘要、focus/visual_options/preview_state 应用结果、warnings/errors 摘要和截图/artifact 路径。
- `editor_viewport_screenshot` 默认返回 `file_path`、尺寸、capture backend、pixel signal 摘要、restore 结果和必要的 camera before/after 摘要；不默认内联图片、完整像素统计或完整 viewport 状态。
- `editor_viewport_set_visual_options` 和 `editor_viewport_set_preview_state` 默认返回已应用/忽略字段摘要；完整 show flag、overlay、adapter 专属 preview state 和兼容诊断只在 debug/raw 视图中展开。
- `editor_viewport_list` 默认返回可扫描候选列表；对 unsupported/special/excluded window 只返回分类、推荐命令族和关键原因，不展开完整编辑器对象状态。
- sequence frame、Niagara/Animation/Material/IK 等 adapter 的截图和序列帧输出必须继承统一 `visual_options` 与 `preview_state` 语义；高成本 frame 明细、相机推导过程和 adapter 内部状态默认写入 artifact 或 debug。

当前实现状态：

- Level Editor viewport adapter 已接入并通过 smoke。
- StaticMesh Editor adapter 已接入并通过 smoke，支持资产预览相机、focus、显示选项和截图。
- Persona adapter 已接入并通过 smoke，支持 SkeletalMesh、Skeleton、AnimationAsset / AnimSequence、AnimBlueprint 预览相机、bounds/bone/socket focus、骨骼/Socket/法线等显示选项、reference pose preview state 和截图。
- ControlRig adapter 已接入并通过 smoke，支持 ControlRig Blueprint 的预览相机、preview component bounds、control / null / space 元素 focus、骨骼/轴/Socket 显示选项和截图；ControlRig RigVM 状态编辑仍未纳入统一层。
- Blueprint SCS adapter 已接入并通过 smoke，支持 Actor Blueprint 的 Components 预览相机、actor/component/selection focus、grid/floor/bounds/realtime 显示选项和截图。
- Niagara System adapter 已接入并通过 smoke，支持 Niagara System 预览相机、preview component bounds focus、grid/bounds/origin axis/particle counts 显示选项、`pause_at_frame` preview state token、截图和 restore。
- Material adapter 已接入并通过 smoke，支持 Material / Material Instance / Material Function 的 3D PreviewViewport 相机、preview component bounds focus、grid/bounds/realtime 显示选项、preview primitive / background / post process preview state、截图和 restore；材质图节点预览、材质表达式预览和 2D UI 材质预览不在本 adapter 范围内。
- IK adapter 已接入并通过 smoke，支持 IK Rig / IK Retargeter 的预览相机、bone / goal focus、Persona 风格显示选项、只读 preview state 和截图；IK Retargeter 在 unattended 命令行下禁止自动打开编辑器，避免 UE 5.6 资产编辑器打开流程卡死。
- PhysicsAsset adapter 已接入并通过 smoke，支持 body / constraint focus、collision / bodies / constraints / center of mass overlay 和截图。
- Groom adapter 已接入并通过 smoke，支持 Groom preview camera、groom bounds focus、visualization options、LOD preview state 和截图；GroomBinding 直接 target 当前返回明确 unsupported。
- Niagara Baker / SimCache preview role 已接入并通过 smoke，使用 `target.viewport_role=baker|sim_cache` 区分角色，支持角色化 preview_state 和截图 backend。
- LevelSequence adapter 已接入并通过 smoke，支持 LevelSequence local time preview_state 和指定 frame 截图；默认 `camera_source=level_viewport`，不把 sequence camera cut 强行解释为 viewport camera。
- Texture / RenderTarget / Media / Paper2D / SubUV / SparseVolumeTexture 当前只作为 2D/special preview boundary 暴露，不纳入 3D camera/focus 主路径。
- UMG Designer、Graph、PCG Graph、BehaviorTree、DataTable、Curve 等非 3D editor window 当前只作为 excluded window boundary 暴露，不纳入 3D camera/focus 主路径。
- `editor_viewport_list` 会把已支持的 StaticMesh、Persona-family、ControlRig、Blueprint SCS、Niagara System、Material-family 与 IK-family asset editor 标为可用项；其它暂未支持的 asset editor 仍只作为 unsupported candidate 暴露，不会伪造可用能力。

空间语义：

- Level adapter 的 camera 写入与读回空间为 `editor_world`，单位 cm，旋转为 UE `FRotator` 的 `pitch/yaw/roll`。
- StaticMesh adapter 的 camera 写入与读回空间为 `asset_preview_world`，focus bounds 默认返回 `asset_local`。
- Persona adapter 的 camera 写入与读回空间为 `persona_preview_world`，focus bounds 也按该预览场景世界坐标返回。
- ControlRig adapter 当前复用 ControlRig Editor 的 Persona PreviewViewport；camera 和 focus bounds 空间为 `persona_preview_world`，不等同于 Level world 或 ControlRig control local space。control / null / space 元素 focus 会先从当前 debugged ControlRig hierarchy（缺失时退回 Blueprint hierarchy）读取 `control_rig_global` transform，再经 preview mesh component transform 转为 `persona_preview_world`。
- Blueprint SCS adapter 的 camera 写入与读回空间为 `blueprint_preview_world`，focus bounds 返回 Blueprint 组件预览 world 坐标，不等同于 Level world。
- Niagara System adapter 的 camera 写入与读回空间为 `niagara_preview_world`，focus bounds 返回 Niagara System 预览组件所在 preview world 坐标，不等同于 Level world。
- Material adapter 的 camera 写入与读回空间为 `material_preview_world`，focus bounds 返回 Material Editor 3D 预览组件所在 preview world 坐标，不等同于 Level world 或材质图 canvas 坐标。
- IK adapter 的 camera 写入与读回空间为 `ik_preview_world`，focus bounds 返回 IK Rig / IK Retargeter 预览组件所在 preview world 坐标，不等同于 Level world；IK Retargeter 的 `source_or_target` / `viewport_role` 只选择 source 或 target 预览组件，不改变资产 retarget pose。
- LevelSequence adapter 的 sequence time 写入在 Sequencer local timeline 中完成；默认相机和截图表面是 Level viewport 的 `editor_world`，二者不能与 MovieScene 资产局部字段混用。
- Texture / RenderTarget / Media / Paper2D / SubUV / SparseVolumeTexture 属于 2D 或 special preview model，不存在本层可写的 3D viewport camera/focus 空间。
- UMG Designer、Blueprint / Material / Niagara Graph、PCG Graph、BehaviorTree、DataTable 和 Curve editor 属于 2D editor UI / graph canvas / table / curve 空间，不存在本层可写的 3D viewport camera/focus 空间。
- 其它资产预览 adapter 后续应使用 `preview_world` 或对应 adapter 明确的预览空间，不得和 Level world 混用。
- 截图验收是三维 viewport 投影到二维像素；返回的 `pixel_signal` 只证明画面非空和像素多样性，不替代目标 bounds / pivot / socket 等读回。

## 命令表

| 指令 | 作用 | 关键参数 | 关键返回 |
|---|---|---|---|
| `editor_viewport_list` | 列出当前可发现的编辑器视口和资产预览候选 | 可选 `include_open_editors` | `schema`、`viewports[]`、`viewport_count`、每项 `target/camera/capabilities/status` |
| `editor_viewport_get_state` | 读取指定视口状态 | 可选 `target`，或直接传 `scope/asset_path/viewport` | `schema`、`target`、`camera`、`visual_options`、`preview_state`、`capabilities` |
| `editor_viewport_set_camera` | 设置指定视口相机并读回 | `camera.location` / `camera.rotation` / `camera.fov`，或 `camera.orbit` | 写后 `camera`、`visual_options`、`capabilities` |
| `editor_viewport_focus` | 聚焦目标并读回视口状态 | `focus.mode`，以及对应目标参数 | `focus_result`、写后 `camera` |
| `editor_viewport_set_visual_options` | 设置视图模式和 overlay/show flags | `visual_options` | 写后 `visual_options`、`visual_options_applied` |
| `editor_viewport_set_preview_state` | 设置 adapter 专属预览状态 | `preview_state` | 写后 `preview_state`、`preview_state_applied` |
| `editor_viewport_screenshot` | 临时组合 camera/focus/options/preview_state 后截图，默认恢复 | `output_file`、`format`、`max_size`、`restore_after_capture`、可选 `camera/focus/visual_options/preview_state` | `file_path`、`width/height`、`capture_backend`、`pixel_signal`、`camera_before`、`camera_after_apply`、`restore_result` |

## Target

所有命令都接受 `target` 对象；也可把 target 字段平铺在 `params` 顶层。

常用字段：

- `scope`：默认根据参数推断；未传 `scope` 且存在 `asset_path` 或 `asset_type` 时推断为 `asset_editor`，否则为 `level`。
- `asset_path`：资产预览窗口用于定位资产；StaticMesh adapter 支持 `/Engine/...`、`/Game/...` object path，缺少对象名时会按包短名补全。
- `asset_type`：可选，用于 adapter 消歧；StaticMesh adapter 接受 `static_mesh` / `staticmesh` / `ustaticmesh`；Persona adapter 接受 `skeletal_mesh` / `skeletalmesh` / `uskeletalmesh`、`skeleton` / `uskeleton`、`animation_asset` / `animation` / `anim_sequence` / `anim_montage` / `anim_composite` 及其常见无下划线形式、`anim_blueprint` / `animation_blueprint`；ControlRig adapter 接受 `control_rig` / `controlrig` / `ucontrolrigblueprint`；Blueprint SCS adapter 接受 `blueprint` / `actor_blueprint` / `blueprint_scs`；Niagara System adapter 接受 `niagara` / `niagara_system` / `niagarasystem` / `uniagarasystem`；Material adapter 接受 `material` / `material_interface` / `material_instance` / `material_function` 及常见 UClass 名称形式；IK adapter 接受 `ik_rig` / `ikrig` / `ik_rig_definition` / `uikrigdefinition`、`ik_retargeter` / `ikretargeter` / `retargeter` / `uikretargeter`；LevelSequence adapter 接受 `level_sequence` / `levelsequence` / `ulevelsequence`。
- `viewport_role`：默认 `primary`；IK Retargeter adapter 可用 `source` 或 `target` 选择源/目标预览组件；LevelSequence adapter 可用 `sequence`；Niagara adapter 可用 `baker` / `sim_cache`。
- `viewport`：默认 `active`。
- `viewport_id`：读回字段，调用方通常不需要手写。
- `open_editor_if_needed`：Level adapter 不使用；StaticMesh / Persona / ControlRig / Blueprint SCS / Niagara System / Material / IK Rig adapter 为 `true` 时会打开对应资产编辑器，为 `false` 时只解析已打开的编辑器。IK Retargeter 不支持由统一 viewport 指令自动打开；若编辑器尚未打开，unattended 环境返回 `ik_retargeter_editor_open_unsupported_unattended`，普通 Editor 会话返回 `ik_retargeter_editor_open_requires_existing_editor`。需要先由用户或其它安全入口打开 IK Retargeter，再用统一命令接管已打开的预览视口。

Special preview boundary aliases：

- Texture：`texture`、`texture2d`、`texture_cube`、`texture_2d_array`、`texture_cube_array`、`volume_texture`、`virtual_texture`、`runtime_virtual_texture`、`light_profile` 及常见 UClass 名称形式。
- RenderTarget：`render_target`、`texture_render_target_2d`、`canvas_render_target_2d`、`texture_render_target_cube`、`texture_render_target_2d_array`、`texture_render_target_volume`。
- Media：`media_texture`、`media_player`、`media_source`、`file_media_source`、`stream_media_source`、`img_media_source`、`platform_media_source`、`media_playlist`。
- Paper2D：`paper2d`、`paper_sprite`、`paper_flipbook`、`paper_tileset`、`paper_tilemap`。
- SparseVolumeTexture：`sparse_volume_texture`、`streamable_sparse_volume_texture`、`animated_sparse_volume_texture`。
- SubUV：`subuv_animation`。

这些类型被识别后只返回明确 special boundary，不启用本层 camera/focus/screenshot。

Excluded editor window aliases：

- UMG：`widget_blueprint`、`widgetblueprint`、`user_widget`。
- Graph role：`viewport_role=graph|node_graph|blueprint_graph|material_graph|niagara_graph`。
- PCG：`pcg_graph`，或 `viewport_role=pcg_graph`。
- BehaviorTree：`behavior_tree`、`blackboard_data`，或 `viewport_role=behavior_tree_graph`。
- DataTable：`data_table`。
- Curve：`curve_float`、`curve_vector`、`curve_linear_color`。
- 通用 editor UI role：`viewport_role=canvas|editor_ui|details|palette`。

这些类型或 role 被识别后返回 excluded window boundary；应继续使用对应 graph/UMG/domain 指令或未来统一 window screenshot 指令，不启用本层 camera/focus/screenshot。

`target` 返回字段带 `schema="uai.editor_viewport.target.v1"`。

## `editor_viewport_list`

用途：发现当前可控制的视口。Level viewport、已支持的 StaticMesh、Persona-family、ControlRig、Blueprint SCS、Niagara System、Material-family、IK-family 和 LevelSequence asset editor 会返回完整 state；其它打开的资产编辑器在 adapter 接入前只返回 unsupported candidate。

参数：

- `include_open_editors`：可选，默认 `true`。为 `true` 时把当前打开的资产编辑器也列入候选。

返回字段：

- `schema="uai.editor_viewport.list.v1"`。
- `viewports[]`：Level viewport 项包含 `target`、`camera`、`visual_options`、`preview_state`、`capabilities`；暂未支持的资产编辑器项包含 `status="unsupported_asset_editor_viewport"`。
- 已识别的 2D/special 资产编辑器项包含 `status="special_preview_unsupported"`、`unsupported_reason` 和 `special_preview`；`capabilities.camera/focus/screenshot=false`，不会伪造 3D viewport 能力。
- 已识别的 graph/canvas/editor UI 资产编辑器项包含 `status="excluded_editor_window"`、`unsupported_reason` 和 `excluded_window`；`capabilities.camera/focus/screenshot=false`。
- `viewport_count`。

示例：

```json
{
  "command": "editor_viewport_list",
  "params": {
    "include_open_editors": true
  }
}
```

## `editor_viewport_get_state`

用途：读取目标视口状态，不修改视口。

Level adapter 当前返回：

- `camera.space="editor_world"`。
- `camera.projection`：`perspective` 或 `orthographic`。
- `visual_options.view_mode`：当前稳定 key，例如 `lit` / `unlit` / `wireframe`。
- `visual_options.overlays`：`grid`、`bounds`、`pivot`、`selection`、`mode_widgets`、`collision`。
- `visual_options.realtime`、`visual_options.game_view`。
- `capabilities.camera=true`、`visual_options=true`、`screenshot=true`。
- `capabilities.focus`：当前 Level adapter 支持 `selection`、`actor`、`actors`、`custom_bounds`、`custom_point`。

StaticMesh adapter 当前返回：

- `target.scope="asset_editor"`、`target.asset_type="static_mesh"`、`target.asset_path`。
- `camera.space="asset_preview_world"`。
- `visual_options.view_mode` 和 `visual_options.view_mode_value`。
- `visual_options.overlays`：`grid`、`bounds`、`pivot`、`normals`、`tangents`、`binormals`、`vertices`、`simple_collision`、`complex_collision`、`collision`。
- `visual_options.realtime`：当前只读回，不作为 StaticMesh adapter 的写入字段。
- `preview_state.asset_path`、`lod_index`、`lod_level`、`selected_socket_count`、`has_selected_collision_primitives`。
- `capabilities.focus`：当前 StaticMesh adapter 支持 `asset_bounds`、`bounds`、`selection`、`pivot`、`socket`、`custom_bounds`、`custom_point`。
- `capabilities.screenshot_backends`：`static_mesh_editor_backbuffer`。

Persona adapter 当前返回：

- `target.scope="asset_editor"`、`target.asset_type` 为 canonical 值：`skeletal_mesh`、`skeleton`、`animation_asset` 或 `anim_blueprint`。
- `target.asset_path`。
- `camera.space="persona_preview_world"`。
- `visual_options.view_mode` 和 `visual_options.view_mode_value`。
- `visual_options.overlays`：`grid`、`bounds`、`bones`、`bone_draw_mode`、`local_axes`、`local_axes_mode`、`sockets`、`mesh_sockets`、`skeleton_sockets`、`normals`、`tangents`、`binormals`。
- `visual_options.realtime`。
- `preview_state.asset_path`、`skeleton_path`、`preview_mesh_path`、`animation_asset_path`、`anim_blueprint_path`、`context`、`show_reference_pose`、`selected_bone_index`、`selected_bone_name`、`selected_socket_name`。
- `capabilities.focus`：当前 Persona adapter 支持 `preview_component_bounds`、`asset_bounds`、`bounds`、`selection`、`bone`、`socket`、`custom_bounds`、`custom_point`。
- `capabilities.screenshot_backends`：`persona_editor_backbuffer`。

ControlRig adapter 当前返回：

- `target.scope="asset_editor"`、`target.asset_type="control_rig"`、`target.asset_path`。
- `adapter="control_rig"`。
- `camera.space="persona_preview_world"`。
- `visual_options` 字段与 Persona preview viewport 对齐：`grid`、`bounds`、`bones`、`bone_draw_mode`、`local_axes`、`local_axes_mode`、`sockets` 等。
- `preview_state.context="ControlRigBlueprint"`、`preview_mesh_path`。
- `capabilities.focus` 当前覆盖 `preview_component_bounds`、`asset_bounds`、`bounds`、`selection`、`bone`、`socket`、`control`、`null`、`space`、`custom_bounds`、`custom_point`。
- `capabilities.screenshot_backends`：`persona_editor_backbuffer`。

Blueprint SCS adapter 当前返回：

- `target.scope="asset_editor"`、`target.asset_type="blueprint"`、`target.asset_path`。
- `adapter="blueprint_scs"`。
- `camera.space="blueprint_preview_world"`。
- `visual_options.view_mode` 和 `visual_options.view_mode_value`。
- `visual_options.overlays`：`grid`、`floor`、`bounds`。
- `visual_options.realtime`。
- `preview_state.context="blueprint_scs"`、`blueprint_path`、`generated_class_path`、`preview_actor_class`、`component_count`、`components[]`。
- `capabilities.focus` 当前覆盖 `actor`、`actor_bounds`、`bounds`、`component`、`selection`、`custom_bounds`、`custom_point`。
- `capabilities.screenshot_backends`：`blueprint_scs_backbuffer`。

Niagara System adapter 当前返回：

- `target.scope="asset_editor"`、`target.asset_type="niagara_system"`、`target.asset_path`。
- `adapter="niagara_system"`。
- `camera.space="niagara_preview_world"`。
- `visual_options.view_mode` 和 `visual_options.view_mode_value`。
- `visual_options.overlays`：`grid`、`bounds`、`origin_axis`、`particle_counts`、`background`、`instruction_counts`。
- `visual_options.realtime`。
- `preview_state.context="niagara_system"`、`asset_path`、`object_path`、`system_ready_to_run`、`system_has_outstanding_compilation_requests`、`has_preview_component`、`component_*`、`age_update_mode`、`tick_delta_seconds`、`system_age`、`current_frame_estimate`、`preview_state_token`、`particle_stats`。
- `capabilities.focus` 当前覆盖 `preview_component_bounds`、`asset_bounds`、`bounds`、`selection`、`custom_bounds`、`custom_point`。
- `capabilities.preview_state_keys` 当前覆盖 `target_frame`、`frame`、`pause_at_frame`、`tick_delta_seconds`、`advance_mode`、`pause`、`reset`、`restore_interactive_preview`。
- `capabilities.screenshot_backends`：`niagara_editor_backbuffer`。

Material adapter 当前返回：

- `target.scope="asset_editor"`、`target.asset_type` 为 canonical 值：`material`、`material_instance` 或 `material_function`。
- `target.asset_path`。
- `adapter="material"`。
- `camera.space="material_preview_world"`。
- `visual_options.view_mode` 和 `visual_options.view_mode_value`。
- `visual_options.overlays`：`grid`、`bounds`。
- `visual_options.realtime`。
- `preview_state.context="material_editor"`、`asset_path`、`asset_type`、`preview_primitive`、`background`、`post_process_material_preview`、`post_processing`、`has_preview_component`、`preview_component_*`、`preview_mesh_asset_path` 和 `preview_component_bounds`。
- `capabilities.focus` 当前覆盖 `preview_component_bounds`、`asset_bounds`、`bounds`、`selection`、`pivot`、`custom_bounds`、`custom_point`。
- `capabilities.preview_state_keys` 当前覆盖 `preview_primitive`、`background`、`post_process_material_preview`。
- `capabilities.screenshot_backends`：`material_editor_backbuffer`。

IK adapter 当前返回：

- `target.scope="asset_editor"`、`target.asset_type` 为 canonical 值：`ik_rig` 或 `ik_retargeter`。
- `target.asset_path`。
- `adapter="ik"`。
- `camera.space="ik_preview_world"`。
- `visual_options.view_mode` 和 `visual_options.view_mode_value`。
- `visual_options.overlays`：`grid`、`bounds`、`bones`、`bone_draw_mode`、`local_axes`、`local_axes_mode`、`sockets`、`mesh_sockets`、`skeleton_sockets`、`normals`、`tangents`、`binormals`。
- `visual_options.realtime`。
- IK Rig `preview_state.context="ik_rig"`，并报告 `asset_path`、`asset_type`、`viewport_role="primary"`、`preview_mesh_asset_path`、`component`、`goals_count` 和 `goals[]`。
- IK Retargeter `preview_state.context="ik_retargeter"`，并报告 `source_or_target` / `active_role`、`current_role`、`output_mode`、`source`、`target`、`active_component`、`role_goals_count` 和 `role_goals[]`。
- `capabilities.focus` 当前覆盖 `preview_component_bounds`、`asset_bounds`、`bounds`、`selection`、`bone`、`goal`、`custom_bounds`、`custom_point`。
- `capabilities.preview_state_keys` 当前覆盖只读字段：`source_or_target`、`current_role`、`output_mode`、`current_pose`、`goals`。
- `capabilities.screenshot_backends`：`ik_editor_backbuffer`。

2D / special preview boundary 当前返回：

- 对 Texture / RenderTarget / Media / Paper2D / SubUV / SparseVolumeTexture asset type 调用 `editor_viewport_get_state`、`editor_viewport_set_camera`、`editor_viewport_focus`、`editor_viewport_set_visual_options`、`editor_viewport_set_preview_state` 或 `editor_viewport_screenshot` 会返回 `ok=false` 和明确错误码。
- Texture：`special_texture_preview_not_3d_editor_viewport`。
- RenderTarget：`special_render_target_preview_not_3d_editor_viewport`。
- Media：`special_media_preview_not_3d_editor_viewport`。
- Paper2D：`special_paper2d_preview_not_3d_editor_viewport`。
- SparseVolumeTexture：`special_sparse_volume_texture_preview_not_3d_editor_viewport`。
- SubUV：`special_subuv_preview_not_3d_editor_viewport`。
- `editor_viewport_list` 中已打开的对应资产会返回 `special_preview.kind`、`preview_model`、`recommended_command_family` 和 `planned_capabilities`，用于说明未来应进入独立 special preview/window 指令，而不是本层 3D camera/focus。

Excluded editor window boundary 当前返回：

- 对 UMG Designer、Graph、PCG Graph、BehaviorTree、DataTable、Curve 或通用 editor UI role 调用 `editor_viewport_get_state`、`editor_viewport_set_camera`、`editor_viewport_focus`、`editor_viewport_set_visual_options`、`editor_viewport_set_preview_state` 或 `editor_viewport_screenshot` 会返回 `ok=false` 和明确错误码。
- UMG Designer：`excluded_umg_designer_not_3d_editor_viewport`。
- Graph：`excluded_graph_window_not_3d_editor_viewport`。
- PCG Graph：`excluded_pcg_graph_not_3d_editor_viewport`。
- BehaviorTree / Blackboard：`excluded_behavior_tree_not_3d_editor_viewport`。
- DataTable：`excluded_data_table_not_3d_editor_viewport`。
- Curve：`excluded_curve_editor_not_3d_editor_viewport`。
- Generic editor UI：`excluded_editor_window_not_3d_editor_viewport`。
- `editor_viewport_list` 中已打开的对应资产会返回 `excluded_window.kind`、`preview_model`、`recommended_command_family` 和 `planned_capabilities`。

示例：

```json
{
  "command": "editor_viewport_get_state",
  "params": {
    "target": {
      "scope": "level"
    }
  }
}
```

## `editor_viewport_set_camera`

用途：设置相机后立即读回状态。默认只改变当前 Editor viewport，不保存关卡或资产。

直接相机参数：

- `camera.location`：`x/y/z`。Level adapter 使用 `editor_world` cm；StaticMesh adapter 使用 `asset_preview_world` cm；Persona / ControlRig adapter 使用 `persona_preview_world` cm；Blueprint SCS adapter 使用 `blueprint_preview_world` cm；Niagara System adapter 使用 `niagara_preview_world` cm；Material adapter 使用 `material_preview_world` cm；IK adapter 使用 `ik_preview_world` cm。
- `camera.rotation`：`pitch/yaw/roll`。
- `camera.fov`：可选，范围会 clamp 到 `5..170`。
- `camera.projection`：当前 Level adapter 读入但不切换透视/正交类型。

Orbit 参数：

- `camera.orbit.target`：目标世界点。
- `camera.orbit.yaw` / `pitch` / `roll`。
- `camera.orbit.distance`：相机到 target 的距离，cm。
- `camera.orbit.fov`。

示例：

```json
{
  "command": "editor_viewport_set_camera",
  "params": {
    "camera": {
      "orbit": {
        "target": { "x": 0, "y": 0, "z": 100 },
        "yaw": 45,
        "pitch": -25,
        "distance": 650,
        "fov": 42
      }
    }
  }
}
```

## `editor_viewport_focus`

用途：把视口聚焦到指定对象、区域或点，并返回写后状态。

Level adapter 当前支持：

- `focus.mode="selection"`：聚焦当前选择集，可选 `padding`、`instant`。
- `focus.mode="actor"`：聚焦单 Actor，支持 `id` / `actor` / `actor_name` / `actor_label`，可选 `padding`、`collision_aware`、`look_at`。
- `focus.mode="actors"`：聚焦多个 Actor，传 `actor_ids[]`，可选 `padding`。
- `focus.mode="custom_bounds"`：传 `bounds.min/max` 或顶层 `min/max`。
- `focus.mode="custom_point"`：传 `point`，可选 `radius`。

注意：

- `actor` / `actors` 当前复用既有 Level framing 逻辑，在 `-NullRHI` 或没有有效 viewport size 时可能返回 `invalid_viewport_size`。
- `custom_point` / `custom_bounds` 可用于 headless smoke 覆盖基础 focus 调用，但仍不等同于真实截图取景验收。

StaticMesh adapter 当前支持：

- `focus.mode="asset_bounds"` 或 `bounds`：聚焦网格资产 AABB。
- `focus.mode="selection"`：聚焦已选 socket / collision primitive；无选择时退回 `asset_bounds`。
- `focus.mode="pivot"`：聚焦资产 local 原点，返回 `bounds_space="asset_local"`。
- `focus.mode="socket"`：传 `socket` 或 `socket_name`，聚焦对应 StaticMesh socket。
- `focus.mode="custom_bounds"`：传 asset local `bounds.min/max` 或顶层 `min/max`。
- `focus.mode="custom_point"`：传 asset local `point`，可选 `radius`。

StaticMesh focus 返回的 `focus_result.bounds` 始终按 `asset_local` 表达；相机读写仍按 `asset_preview_world` 表达。

Persona adapter 当前支持：

- `focus.mode="preview_component_bounds"`、`asset_bounds` 或 `bounds`：聚焦当前 Persona 预览组件 bounds。
- `focus.mode="selection"`：聚焦已选 socket 或 bone；无选择时退回 `preview_component_bounds`。
- `focus.mode="bone"`：传 `bone` 或 `bone_name`，聚焦对应骨骼。
- `focus.mode="socket"`：传 `socket` 或 `socket_name`，聚焦对应 SkeletalMesh / Skeleton socket。
- `focus.mode="custom_bounds"`：传 `persona_preview_world` 下的 `bounds.min/max` 或顶层 `min/max`。
- `focus.mode="custom_point"`：传 `persona_preview_world` 下的 `point`，可选 `radius`。

Persona focus 返回的 `focus_result.bounds` 始终按 `persona_preview_world` 表达。

ControlRig adapter 支持与 Persona preview component 相同的 bounds / bone / socket / custom focus 入口，并额外支持 ControlRig hierarchy 元素：

- `focus.mode="control"`：传 `control`、`control_name`、`element`、`element_name` 或 `name`，聚焦对应 `FRigControlElement`。
- `focus.mode="null"`：传 `null`、`null_name`、`space`、`space_name`、`element`、`element_name` 或 `name`，聚焦对应 `FRigNullElement`。
- `focus.mode="space"`：UE 5.6 中 `ERigElementType::Space` 是 `Null` 的隐藏别名；该模式按 Null 元素解析，但返回 `element_type="space"`，同时返回 `rig_element_type="null"`。

ControlRig 元素 focus 返回的 `focus_result.bounds` 按 `persona_preview_world` 表达，并附带 `element_name`、`element_type`、`hierarchy_source`、`rig_global_space="control_rig_global"`、`rig_global_location` 和 `preview_world_location`。ControlRig graph 节点选择、骨骼控制器编辑或 RigVM 调试状态仍不应伪装成 viewport focus 能力。

Blueprint SCS adapter 当前支持：

- `focus.mode="actor"`、`actor_bounds` 或 `bounds`：聚焦当前 Blueprint preview actor。
- `focus.mode="component"`：传 `component` 或 `component_name`，聚焦对应预览组件 bounds。
- `focus.mode="selection"`：调用 Blueprint Components 视口自身的 selection focus；无可执行 selection focus 时返回 preview actor bounds 作为 fallback。
- `focus.mode="custom_bounds"`：传 `blueprint_preview_world` 下的 `bounds.min/max` 或顶层 `min/max`。
- `focus.mode="custom_point"`：传 `blueprint_preview_world` 下的 `point`，可选 `radius`。

Blueprint SCS focus 返回的 `focus_result.bounds` 始终按 `blueprint_preview_world` 表达。`component` focus 只面向 Actor Blueprint 预览 actor 中存在的 `USceneComponent` / `UPrimitiveComponent`，不会把 Blueprint graph 节点选择伪装为 3D focus。

Niagara System adapter 当前支持：

- `focus.mode="preview_component_bounds"`、`asset_bounds` 或 `bounds`：聚焦当前 Niagara preview component bounds。
- `focus.mode="selection"`：当前等价退回 preview component bounds，不伪造 Niagara Stack 或 graph 选择。
- `focus.mode="custom_bounds"`：传 `niagara_preview_world` 下的 `bounds.min/max` 或顶层 `min/max`。
- `focus.mode="custom_point"`：传 `niagara_preview_world` 下的 `point`，可选 `radius`。

Niagara focus 返回的 `focus_result.bounds` 始终按 `niagara_preview_world` 表达。

Material adapter 当前支持：

- `focus.mode="preview_component_bounds"`、`asset_bounds`、`bounds` 或 `selection`：聚焦当前 Material 3D 预览组件 bounds。
- `focus.mode="pivot"`：聚焦 Material 预览场景原点。
- `focus.mode="custom_bounds"`：传 `material_preview_world` 下的 `bounds.min/max` 或顶层 `min/max`。
- `focus.mode="custom_point"`：传 `material_preview_world` 下的 `point`，可选 `radius`。

Material focus 返回的 `focus_result.bounds` 始终按 `material_preview_world` 表达。该 focus 只面向 Material Editor 3D PreviewViewport，不会把材质图节点、表达式预览或材质实例参数面板选择伪装成 3D focus。

IK adapter 当前支持：

- `focus.mode="preview_component_bounds"`、`asset_bounds`、`bounds` 或 `selection`：聚焦当前 IK preview component bounds。
- `focus.mode="bone"`：传 `bone` 或 `bone_name`，聚焦当前角色组件中的骨骼。
- `focus.mode="goal"`：传 `goal`、`goal_name` 或 `name`，聚焦 IK Rig 或 Retargeter 当前角色 IK Rig 中的 goal。
- `focus.mode="custom_bounds"`：传 `ik_preview_world` 下的 `bounds.min/max` 或顶层 `min/max`。
- `focus.mode="custom_point"`：传 `ik_preview_world` 下的 `point`，可选 `radius`。
- IK Retargeter 可在 `target.viewport_role` 或 `focus.source_or_target` / `focus.role` / `focus.preview_role` 中传 `source` 或 `target`，决定聚焦源或目标预览组件；该选择不写入资产。

IK focus 返回的 `focus_result.bounds` 始终按 `ik_preview_world` 表达。`goal` focus 返回 `goal_name`、`bone_name`、`current_location`、`initial_location` 和 `source_or_target`，用于说明 goal 点来自哪个预览角色。

示例：

```json
{
  "command": "editor_viewport_focus",
  "params": {
    "focus": {
      "mode": "custom_bounds",
      "bounds": {
        "min": { "x": -100, "y": -100, "z": 0 },
        "max": { "x": 100, "y": 100, "z": 200 }
      }
    }
  }
}
```

## `editor_viewport_set_visual_options`

用途：设置视口显示模式和 overlay/show flags。

Level adapter 当前支持：

- `visual_options.view_mode`：`lit`、`unlit`、`wireframe`、`csg_wireframe`、`lit_wireframe`、`detail_lighting`、`lighting_only`、`reflections`、`player_collision`、`visibility_collision`。
- `visual_options.overlays.grid`。
- `visual_options.overlays.bounds`。
- `visual_options.overlays.pivot`。
- `visual_options.overlays.selection`。
- `visual_options.overlays.mode_widgets`。
- `visual_options.overlays.collision`。
- 上述 overlay 也可平铺到 `visual_options` 顶层。
- `visual_options.realtime`。
- `visual_options.game_view`。

StaticMesh adapter 当前支持：

- `visual_options.view_mode`：复用通用 view mode key，例如 `lit`、`unlit`、`wireframe`、`detail_lighting`、`lighting_only`、`reflections`。
- `visual_options.overlays.grid`。
- `visual_options.overlays.bounds`。
- `visual_options.overlays.pivot`。
- `visual_options.overlays.normals`。
- `visual_options.overlays.tangents`。
- `visual_options.overlays.binormals`。
- `visual_options.overlays.vertices`。
- `visual_options.overlays.collision`：同时设置 simple / complex collision overlay。
- `visual_options.overlays.simple_collision`。
- `visual_options.overlays.complex_collision`。
- 上述 overlay 也可平铺到 `visual_options` 顶层。

Persona adapter 当前支持：

- `visual_options.view_mode`：复用通用 view mode key，例如 `lit`、`unlit`、`wireframe`、`detail_lighting`、`lighting_only`、`reflections`。
- `visual_options.overlays.grid`。
- `visual_options.overlays.bounds`。
- `visual_options.overlays.bones`：`true` 时使用 `bone_draw_mode="all"`，`false` 时使用 `none`。
- `visual_options.overlays.bone_draw_mode`：`none`、`selected`、`selected_and_parents`、`selected_and_children`、`selected_and_parents_and_children`、`all`。
- `visual_options.overlays.local_axes`：`true` 时使用 `local_axes_mode="all"`，`false` 时使用 `none`。
- `visual_options.overlays.local_axes_mode`：`none`、`selected`、`all`。
- `visual_options.overlays.sockets`。
- `visual_options.overlays.mesh_sockets`。
- `visual_options.overlays.skeleton_sockets`。
- `visual_options.overlays.normals`。
- `visual_options.overlays.tangents`。
- `visual_options.overlays.binormals`。
- 上述 overlay 也可平铺到 `visual_options` 顶层。
- `visual_options.realtime`。

Blueprint SCS adapter 当前支持：

- `visual_options.view_mode`：复用通用 view mode key，例如 `lit`、`unlit`、`wireframe`、`detail_lighting`、`lighting_only`、`reflections`。
- `visual_options.overlays.grid`。
- `visual_options.overlays.floor`。
- `visual_options.overlays.bounds`。
- 上述 overlay 也可平铺到 `visual_options` 顶层。
- `visual_options.realtime`。

Niagara System adapter 当前支持：

- `visual_options.view_mode`：复用通用 view mode key，例如 `lit`、`unlit`、`wireframe`、`detail_lighting`、`lighting_only`、`reflections`。
- `visual_options.overlays.grid`。
- `visual_options.overlays.bounds`。
- `visual_options.overlays.origin_axis`。
- `visual_options.overlays.particle_counts`。
- `visual_options.overlays.background`。
- `visual_options.overlays.instruction_counts`。
- 上述 overlay 也可平铺到 `visual_options` 顶层。
- `visual_options.realtime`。

Material adapter 当前支持：

- `visual_options.view_mode`：复用通用 view mode key，例如 `lit`、`unlit`、`wireframe`、`detail_lighting`、`lighting_only`、`reflections`。
- `visual_options.overlays.grid`。
- `visual_options.overlays.bounds`。
- 上述 overlay 也可平铺到 `visual_options` 顶层。
- `visual_options.realtime`。

IK adapter 当前支持：

- `visual_options.view_mode`：复用通用 view mode key，例如 `lit`、`unlit`、`wireframe`、`detail_lighting`、`lighting_only`、`reflections`。
- `visual_options.overlays.grid`。
- `visual_options.overlays.bounds`。
- `visual_options.overlays.bones`：`true` 时使用 `bone_draw_mode="all"`，`false` 时使用 `none`。
- `visual_options.overlays.bone_draw_mode`：`none`、`selected`、`selected_and_parents`、`selected_and_children`、`selected_and_parents_and_children`、`all`。
- `visual_options.overlays.local_axes`：`true` 时使用 `local_axes_mode="all"`，`false` 时使用 `none`。
- `visual_options.overlays.local_axes_mode`：`none`、`selected`、`all`。
- `visual_options.overlays.sockets`。
- `visual_options.overlays.mesh_sockets`。
- `visual_options.overlays.skeleton_sockets`。
- `visual_options.overlays.normals`。
- `visual_options.overlays.tangents`。
- `visual_options.overlays.binormals`。
- 上述 overlay 也可平铺到 `visual_options` 顶层。
- `visual_options.realtime`。

不支持的字段默认失败并返回 `unsupported_visual_options`；显式传 `ignore_unsupported=true` 时会在 `unsupported_options[]` 中返回未应用项。

示例：

```json
{
  "command": "editor_viewport_set_visual_options",
  "params": {
    "visual_options": {
      "view_mode": "lit",
      "overlays": {
        "grid": false,
        "bounds": true,
        "pivot": true
      }
    }
  }
}
```

## `editor_viewport_set_preview_state`

用途：设置 adapter 专属预览状态。它与 camera/show flags 分离，避免把 Niagara 定帧、动画时间、材质预览体等状态混进 `visual_options`。

当前 Level adapter 没有专属预览状态：

- `preview_state={}` 会成功返回 `preview_state_applied.applied=false`、`reason="empty_preview_state"`。
- 非空 `preview_state` 返回 `editor_viewport_preview_state_not_supported`。

当前 StaticMesh adapter 也没有专属可写 preview state：

- `preview_state={}` 会成功返回 `preview_state_applied.applied=false`、`reason="empty_preview_state"`。
- 非空 `preview_state` 返回 `editor_viewport_preview_state_not_supported`。
- 只读 `preview_state` 会报告 asset path、LOD 和选择摘要。

当前 Persona adapter 支持：

- `preview_state={}` 会成功返回 `preview_state_applied.applied=false`、`reason="empty_preview_state"`。
- `preview_state.show_reference_pose`：切换当前预览场景是否显示 reference pose。
- `preview_state.reset_bone_transforms`：可选，只在同时传 `show_reference_pose` 时使用。
- 只读 `preview_state` 会报告 asset、skeleton、preview mesh、animation / anim blueprint 路径、context、reference pose 和选择摘要。

ControlRig adapter 当前只把 ControlRig Blueprint 的预览上下文纳入统一层读回与截图链路：

- 只读 `preview_state.context="ControlRigBlueprint"`。
- 只读 `preview_state.preview_mesh_path`。
- ControlRig 专属运行、求解、控制器选择或 RigVM 调试状态不在当前 `editor_viewport_set_preview_state` 范围内。

Blueprint SCS adapter 当前只读预览状态：

- `preview_state={}` 会成功返回 `preview_state_applied.applied=false`、`reason="empty_preview_state"`。
- 非空 `preview_state` 返回 `editor_viewport_preview_state_not_supported`。
- 只读 `preview_state.context="blueprint_scs"`，并报告 Blueprint path、GeneratedClass、preview actor class、component_count 与 component summary。

Niagara System adapter 当前支持：

- `preview_state={}` 会成功返回 `preview_state_applied.applied=false`、`reason="empty_preview_state"`。
- `preview_state.pause_at_frame`、`frame` 或 `target_frame`：重置 Niagara 预览，从 0 帧按固定 tick 连续推进到目标帧，默认暂停在该帧，并写入 `preview_state_token`。
- `preview_state.tick_delta_seconds` 或 `preview_tick_delta_seconds`：固定 tick 间隔，默认 `1/60`，clamp 到 `1/240..1/5`。
- `preview_state.advance_mode`：`tick_component` 或 `advance_simulation`。
- `preview_state.pause` / `paused` / `pause_after_advance`：控制推进后是否暂停。
- `preview_state.reset` / `reset_preview`：重置预览。
- `preview_state.restore_interactive_preview`：清除 UAI preview token，恢复实时交互预览。

Niagara `pause_at_frame` token 的语义是 `continuous_from_zero`，用于证明截图、读回和后续采样来自同一次统一层预览状态。旧 `niagara_screenshot` 的显式 Niagara System 单帧预览截图子路径已作为兼容 wrapper 指向 `editor_viewport_screenshot + preview_state`；多帧 sheet、连续序列帧和 `expected_preview_state_token` 高级路径仍保留专用入口，但序列帧路径已经消费同一套 `visual_options` / `preview_state` 嵌套对象，并在返回中报告 `unified_sequence_frame_options`、`visual_options_applied/ignored`、`preview_state_applied/ignored`。

Material adapter 当前支持：

- `preview_state={}` 会成功返回 `preview_state_applied.applied=false`、`reason="empty_preview_state"`。
- `preview_state.preview_primitive` 或 `primitive`：`sphere`、`cube`、`cylinder`、`plane`。实现使用瞬态预览组件切换，不修改材质资产。
- `preview_state.background`：切换 Material 3D PreviewViewport 背景。
- `preview_state.post_process_material_preview` 或 `post_process`：切换 PostProcessMaterial/PostProcessing show flag，用于材质后处理预览链路。
- 只读 `preview_state` 会报告 Material Editor context、资产类型、当前 preview primitive、background、post process、preview component summary 和 `material_preview_world` 下的 preview component bounds。

IK adapter 当前为只读 preview state：

- `preview_state={}` 会成功返回 `preview_state_applied.applied=false`、`reason="empty_preview_state"`。
- 传入只读字段 `source_or_target`、`current_role`、`output_mode`、`current_pose`、`goals` 会成功返回 `preview_state_applied.applied=false`、`reason="read_only_preview_state"`。
- 其它非空字段默认返回 `editor_viewport_preview_state_not_supported`；显式传 `ignore_unsupported=true` 时会回传 `unsupported_options[]`，但不会修改 IK Rig / IK Retargeter 资产或姿势状态。
- IK Rig 只读 `preview_state` 会报告 `context="ik_rig"`、preview mesh、当前组件 summary 和 goals。
- IK Retargeter 只读 `preview_state` 会报告 `context="ik_retargeter"`、当前 `source_or_target` / `active_role`、`output_mode`、source / target 子状态、当前角色组件和 role goals。

后续资产 adapter 应只把本窗口真实支持的专属状态放入 `preview_state`，例如动画 pause/time。不要把 2D graph canvas、UMG canvas 或参数面板状态混入 3D preview state。

示例：

```json
{
  "command": "editor_viewport_set_preview_state",
  "params": {
    "preview_state": {}
  }
}
```

## `editor_viewport_screenshot`

用途：在一次调用里临时设置 `preview_state`、`visual_options`、`focus`、`camera`，捕获截图，然后默认恢复进入命令前的视口状态。应用顺序为：

```text
snapshot -> preview_state -> visual_options -> focus -> camera -> screenshot -> restore
```

关键参数：

- `output_file`：可选；相对路径按项目根目录解析。扩展名必须与 `format` 一致。
- `format`：`png` / `jpg` / `webp`，默认 `png`。
- `quality`：`jpg/webp` 质量，默认 `90`。
- `max_size`：最长边缩放上限，默认 `1600`。
- `warmup_frames`：截图前刷新帧数，默认 `2`。
- `tick_editor_world` / `editor_world_tick_frames` / `editor_world_tick_delta_seconds`：透传给 Level viewport 截图刷新链路。
- `restore_after_capture`：默认 `true`。为 `false` 时保留临时视口状态，并在 `restore_result.dismissed=true` 中体现。
- `visual_options`：可选，临时显示设置。
- `focus`：可选，临时聚焦。
- `camera`：可选，临时相机；如果同时传 `focus` 和 `camera`，最终相机由 `camera` 决定。
- `preview_state`：可选，Level / StaticMesh / Blueprint SCS adapter 只接受空对象；Persona adapter 支持 `show_reference_pose`；Niagara System adapter 支持 `pause_at_frame`、`reset`、`pause` 与 `restore_interactive_preview`；Material adapter 支持 `preview_primitive`、`background` 和 `post_process_material_preview`；IK adapter 当前只读，空对象或只读字段可作为无修改读回。

返回字段：

- `schema="uai.editor_viewport.screenshot.v1"`。
- `file_path`、`format`、`width`、`height`、`bytes`。
- `capture_backend`：Level adapter 当前为 `level_viewport_backbuffer`；StaticMesh adapter 当前为 `static_mesh_editor_backbuffer`；Persona / ControlRig adapter 当前为 `persona_editor_backbuffer`；Blueprint SCS adapter 当前为 `blueprint_scs_backbuffer`；Niagara System adapter 当前为 `niagara_editor_backbuffer`；Material adapter 当前为 `material_editor_backbuffer`；IK adapter 当前为 `ik_editor_backbuffer`。
- `pixel_signal`：`width`、`height`、`sampled_pixel_count`、`bright_pixel_count`、`unique_color_count_capped`、`nonblank`。
- `capture`：底层截图细节；StaticMesh / 通用 backbuffer 截图会包含 `initial_viewport_size`、`fallback_viewport_size_applied`、`draws_performed` 等调试字段。
- `target`。
- `camera_before`：snapshot 时的相机。
- `camera_after_apply`：临时状态应用后的相机。
- `visual_options_applied`：有临时 visual options 时返回。
- `focus_result`：有临时 focus 时返回。
- `restore_after_capture`。
- `restore_result`：包含 `requested`、`snapshot_valid`、`restored`、`dismissed`、`success`，失败时附带 `snapshot_error` 或 `restore_error`。

示例：

```json
{
  "command": "editor_viewport_screenshot",
  "params": {
    "output_file": "runtimeLogs/editor_viewport_level_smoke.png",
    "format": "png",
    "max_size": 128,
    "restore_after_capture": true,
    "visual_options": {
      "view_mode": "unlit",
      "overlays": {
        "grid": false,
        "bounds": true,
        "pivot": true
      }
    },
    "camera": {
      "orbit": {
        "target": { "x": 0, "y": 0, "z": 100 },
        "yaw": 45,
        "pitch": -25,
        "distance": 650,
        "fov": 42
      }
    }
  }
}
```

StaticMesh 截图示例：

```json
{
  "command": "editor_viewport_screenshot",
  "params": {
    "target": {
      "scope": "asset_editor",
      "asset_type": "static_mesh",
      "asset_path": "/Engine/BasicShapes/Cube.Cube",
      "open_editor_if_needed": true
    },
    "output_file": "runtimeLogs/editor_viewport_static_mesh_smoke.png",
    "format": "png",
    "max_size": 256,
    "restore_after_capture": true,
    "visual_options": {
      "view_mode": "lit",
      "overlays": {
        "grid": false,
        "bounds": true,
        "pivot": true,
        "normals": true,
        "tangents": true,
        "binormals": true,
        "collision": false
      }
    },
    "focus": {
      "mode": "pivot",
      "radius": 80
    },
    "camera": {
      "orbit": {
        "target": { "x": 0, "y": 0, "z": 0 },
        "yaw": 35,
        "pitch": -25,
        "distance": 420,
        "fov": 38
      }
    }
  }
}
```

Persona / SkeletalMesh 截图示例：

```json
{
  "command": "editor_viewport_screenshot",
  "params": {
    "target": {
      "scope": "asset_editor",
      "asset_type": "skeletal_mesh",
      "asset_path": "/Game/Characters/Mannequins/Meshes/SKM_Manny_Simple.SKM_Manny_Simple",
      "open_editor_if_needed": true
    },
    "output_file": "runtimeLogs/editor_viewport_persona_skeletal_mesh_smoke.png",
    "format": "png",
    "max_size": 256,
    "restore_after_capture": true,
    "preview_state": {
      "show_reference_pose": true
    },
    "visual_options": {
      "view_mode": "lit",
      "overlays": {
        "grid": false,
        "bounds": true,
        "bones": true,
        "bone_draw_mode": "all",
        "sockets": true,
        "normals": false,
        "tangents": false,
        "binormals": false
      }
    },
    "focus": {
      "mode": "preview_component_bounds"
    },
    "camera": {
      "orbit": {
        "target": { "x": 0, "y": 0, "z": 90 },
        "yaw": 40,
        "pitch": -12,
        "distance": 420,
        "fov": 38
      }
    }
  }
}
```

ControlRig 截图示例：

```json
{
  "command": "editor_viewport_screenshot",
  "params": {
    "target": {
      "scope": "asset_editor",
      "asset_type": "control_rig",
      "asset_path": "/Game/Characters/Mannequins/Rigs/CR_Mannequin_Body.CR_Mannequin_Body",
      "open_editor_if_needed": true
    },
    "output_file": "runtimeLogs/editor_viewport_control_rig_smoke.png",
    "format": "png",
    "max_size": 256,
    "restore_after_capture": true,
    "visual_options": {
      "view_mode": "lit",
      "overlays": {
        "grid": false,
        "bounds": true,
        "bones": true,
        "local_axes": true
      }
    },
    "focus": {
      "mode": "preview_component_bounds"
    },
    "camera": {
      "orbit": {
        "target": { "x": 0, "y": 0, "z": 90 },
        "yaw": 35,
        "pitch": -12,
        "distance": 460,
        "fov": 42
      }
    }
  }
}
```

Blueprint SCS 截图示例：

```json
{
  "command": "editor_viewport_screenshot",
  "params": {
    "target": {
      "scope": "asset_editor",
      "asset_type": "blueprint",
      "asset_path": "/Game/Blueprints/BP_FloatingRotatingCube.BP_FloatingRotatingCube",
      "open_editor_if_needed": true
    },
    "output_file": "runtimeLogs/editor_viewport_blueprint_scs_smoke.png",
    "format": "png",
    "max_size": 256,
    "restore_after_capture": true,
    "visual_options": {
      "view_mode": "lit",
      "overlays": {
        "grid": false,
        "floor": false,
        "bounds": true
      }
    },
    "focus": {
      "mode": "component",
      "component_name": "StaticMesh"
    },
    "camera": {
      "orbit": {
        "target": { "x": 0, "y": 0, "z": 80 },
        "yaw": 35,
        "pitch": -20,
        "distance": 420,
        "fov": 41
      }
    }
  }
}
```

Niagara System 截图示例：

```json
{
  "command": "editor_viewport_screenshot",
  "params": {
    "target": {
      "scope": "asset_editor",
      "asset_type": "niagara_system",
      "asset_path": "/Game/Niagara/OfficialTemplateStudy/Systems/NS_DirectionalBurst.NS_DirectionalBurst",
      "open_editor_if_needed": true
    },
    "output_file": "runtimeLogs/editor_viewport_niagara_system_smoke.png",
    "format": "png",
    "max_size": 256,
    "restore_after_capture": true,
    "preview_state": {
      "pause_at_frame": 4,
      "tick_delta_seconds": 0.033333333,
      "advance_mode": "tick_component",
      "pause": true
    },
    "visual_options": {
      "view_mode": "lit",
      "overlays": {
        "grid": false,
        "bounds": true,
        "origin_axis": true,
        "particle_counts": true
      }
    },
    "focus": {
      "mode": "preview_component_bounds"
    },
    "camera": {
      "orbit": {
        "target": { "x": 0, "y": 0, "z": 40 },
        "yaw": 35,
        "pitch": -14,
        "distance": 380,
        "fov": 40
      }
    }
  }
}
```

Material 3D Preview 截图示例：

```json
{
  "command": "editor_viewport_screenshot",
  "params": {
    "target": {
      "scope": "asset_editor",
      "asset_type": "material",
      "asset_path": "/Engine/BasicShapes/BasicShapeMaterial.BasicShapeMaterial",
      "open_editor_if_needed": true
    },
    "output_file": "runtimeLogs/editor_viewport_material_smoke.png",
    "format": "png",
    "max_size": 256,
    "restore_after_capture": true,
    "preview_state": {
      "preview_primitive": "sphere",
      "background": false,
      "post_process_material_preview": false
    },
    "visual_options": {
      "view_mode": "lit",
      "overlays": {
        "grid": false,
        "bounds": true
      }
    },
    "focus": {
      "mode": "preview_component_bounds"
    },
    "camera": {
      "orbit": {
        "target": { "x": 0, "y": 0, "z": 0 },
        "yaw": 40,
        "pitch": -20,
        "distance": 300,
        "fov": 40
      }
    }
  }
}
```

IK Rig 截图示例：

```json
{
  "command": "editor_viewport_screenshot",
  "params": {
    "target": {
      "scope": "asset_editor",
      "asset_type": "ik_rig",
      "asset_path": "/Game/IK/IKR_Mannequin.IKR_Mannequin",
      "open_editor_if_needed": true
    },
    "output_file": "runtimeLogs/editor_viewport_ik_rig_smoke.png",
    "format": "png",
    "max_size": 256,
    "restore_after_capture": true,
    "visual_options": {
      "view_mode": "lit",
      "overlays": {
        "grid": false,
        "bounds": true,
        "bones": true,
        "bone_draw_mode": "all",
        "local_axes": true
      }
    },
    "focus": {
      "mode": "goal",
      "goal_name": "RightHand"
    },
    "camera": {
      "orbit": {
        "target": { "x": 0, "y": 0, "z": 90 },
        "yaw": 35,
        "pitch": -12,
        "distance": 460,
        "fov": 42
      }
    }
  }
}
```

边界：

- `-NullRHI` 或没有有效 Level viewport size 时，Level adapter 截图会返回 `invalid_viewport_size`；命令仍应返回 `restore_result`，并尽量恢复已应用的临时状态。
- StaticMesh Editor 在可渲染但初始 viewport size 为 0 的 unattended smoke 中，会尝试对 `FSceneViewport` 临时设置固定尺寸来完成 backbuffer 截图；截图完成或失败后会清除该临时尺寸。`-NullRHI` 下仍会安全失败为 `invalid_viewport_size` 或 `read_pixels_failed`。
- Persona / ControlRig / Blueprint SCS / Niagara System / Material / IK Editor 截图同样走通用 editor viewport backbuffer；可渲染但初始 viewport size 为 0 时会尝试临时 fixed viewport size。Blueprint SCS adapter 还会在解析 Components 视口时激活 SCS viewport tab 并触发布局 tick，避免 unattended 资产编辑器里出现 0x0 viewport。
- 自动化 smoke 在 `-NullRHI` 下只覆盖 Level adapter。StaticMesh、Persona-family、ControlRig、Blueprint SCS、Niagara System、Material 与 IK 等独立 asset editor 窗口不会在 NullRHI smoke 中打开，因为 UE 5.6 headless standalone asset editor layout persistence 会触发 `GetRestoredDimensions` 崩溃；这些 asset editor adapter 由非 NullRHI smoke 覆盖。
- IK Retargeter asset editor 自动打开会卡在 UE 5.6 编辑器初始化链路；该风险已在 unattended 命令行和 Agent 启动的最小化普通 Editor 会话中复现。因此 `open_editor_if_needed=true` 且编辑器未打开时会快速返回 `ik_retargeter_editor_open_unsupported_unattended` 或 `ik_retargeter_editor_open_requires_existing_editor`。同一 IK adapter 仍可控制已打开的 IK Retargeter 预览。
- Material adapter 只覆盖 `SMaterialEditor3DPreviewViewport`；材质图节点预览、材质函数图 canvas、材质实例参数面板和 UMG/Slate 2D 预览不属于 3D viewport camera/focus 能力。
- `pixel_signal.nonblank=true` 只表示截图不是空黑或单色占位。要验证 pivot 轴、bounds 或某个 socket 是否在正确位置，应配合对应 adapter 的状态读回和任务级视觉判定。
- 旧 Level Viewport 相机和 Actor/Selection 聚焦入口、StaticMesh / Blueprint / AnimBlueprint / ControlRig 预览相机入口已被统一 `editor_viewport_get_state`、`editor_viewport_set_camera`、`editor_viewport_focus` 覆盖，并迁入 `deprecatedCommand`。旧入口仍保留兼容 wrapper，但新 authoring 应直接使用统一命令。
- 旧 `screenshot_viewport` 的基础 Lit 截图子路径已作为兼容 wrapper 指向 `editor_viewport_screenshot`；高级 Visualization Mode / buffer 截图能力尚未完全迁入统一层，仍按旧命令文档边界使用。
- 旧 `niagara_screenshot` 的显式 Niagara System 单帧预览截图子路径已作为兼容 wrapper 指向 `editor_viewport_screenshot + preview_state`；多帧 sheet、连续序列帧和高级 preview token 验证仍保留专用入口，但已经消费统一 `visual_options` / `preview_state` 嵌套对象。若后续统一预览指令完全覆盖这些高级能力，再把被覆盖的旧入口迁入废弃区。
