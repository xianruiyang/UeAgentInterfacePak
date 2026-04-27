# UeAgentInterface 指令速查

本文件是快速路由表，不替代插件文档。完整参数、返回字段和边界以项目内文档为准：

- `Plugins/UeAgentInterface/docs/UeAgentInterface_Usage.md`
- `Plugins/UeAgentInterface/docs/commands/README.md`
- `Plugins/UeAgentInterface/docs/commands/*.md`
- `UeAgentInterfaceCMD/docs/USAGE.md`

## 调用原则

- 自动化调用使用 `UeAgentInterfaceCMD/dist/uai-cli.exe`。
- 两步以上任务优先 `batch` 或 `run`。
- 写入任务使用 JSON 文件输入，读取 report JSON 输出。
- 能被单文件 JSON 或文件夹式结构化 JSON 覆盖的资产 authoring，不使用零散写入命令作为主流程。
- 文档中归档到 `commands/deprecatedCommand/` 的命令仍保留兼容，但只用于 bootstrap、诊断、迁移、schema 边界和局部修补。

## 主流程命令

### 通用批处理与编辑器生命周期

- `exec_batch`
- `begin_transaction`
- `end_transaction`
- `undo`
- `redo`
- `editor_get_open_assets`
- `open_asset_editor`
- `save_asset`
- `save_current_level`
- `editor_list_dirty_resources`
- `editor_resolve_dirty_resources`
- `editor_close`
- `editor_prepare_exit`

### 关卡、Actor、视口、碰撞、NavMesh

- `get_world_state`
- `list_actors`
- `spawn_actor`
- `destroy_actor`
- `level_duplicate_actor`
- `level_get_actor_transform`
- `level_set_actor_transform`
- `level_set_actor_location`
- `level_set_actor_rotation`
- `level_set_actor_scale`
- `level_get_selection`
- `level_set_selection`
- `level_set_actor_folder`
- `level_add_actor_tag`
- `level_destroy_folder_actors`
- `level_cleanup_empty_folders`
- `actor_list_components`
- `level_get_actor_property`
- `level_get_component_property`
- `actor_set_property`
- `component_set_property`
- `viewport_get_camera`
- `viewport_set_camera`
- `viewport_set_realtime`
- `viewport_set_game_view`
- `viewport_focus_actor`
- `viewport_frame_selection`
- `viewport_frame_actors`
- `viewport_frame_folder`
- `viewport_deproject_screen_to_world`
- `viewport_trace_screen_point`
- `viewport_pick_actor_at_screen`
- `viewport_select_actor_at_screen`
- `screenshot_viewport`
- `screenshot_viewport_buffer`
- `navmesh_build`
- `navmesh_project_point`
- `navmesh_find_path`
- `navmesh_spawn_bounds_volume`
- `level_trace_world_ray`
- `level_sweep_capsule`
- `level_sweep_capsule_path`
- `level_check_overlaps`
- `level_snap_to_surface`
- `level_validate_connectivity`
- `level_spawn_wall_with_opening`
- `level_mark_probe`
- `level_generate_probes`
- `level_get_nearby_actor_obbs`
- `level_align_actor_vertex_to_vertex`
- `level_align_actor_by_bounds`
- `level_align_face_to_face`

### 资产级 JSON

- `asset_duplicate`
- `asset_import_texture`
- `asset_import_fbx_skeletal_mesh`
- `asset_import_fbx_animation`
- `asset_export_property_json`
- `asset_apply_property_json`

### Blueprint / UMG / AnimBlueprint 文件夹式 JSON

- `blueprint_create`
- `blueprint_compile`
- `blueprint_get_compile_log`
- `blueprint_get_info`
- `blueprint_export_folder`
- `blueprint_apply_folder`
- `blueprint_list_graphs`
- `blueprint_inspect_components`
- `blueprint_inspect_nodes`
- `blueprint_graph_get_view`
- `blueprint_graph_set_view`
- `blueprint_viewport_get_camera`
- `blueprint_viewport_set_camera`
- `blueprint_screenshot`
- `umg_create_widget_blueprint`
- `umg_compile`
- `umg_get_compile_log`
- `umg_get_info`
- `umg_export_folder`
- `umg_apply_folder`
- `anim_blueprint_create`
- `anim_blueprint_create_layer_interface`
- `anim_blueprint_compile`
- `anim_blueprint_get_compile_log`
- `anim_blueprint_export_folder`
- `anim_blueprint_apply_folder`
- `anim_blueprint_get_info`
- `anim_blueprint_list_graphs`
- `anim_blueprint_list_state_machines`
- `anim_blueprint_list_anim_layers`
- `anim_blueprint_list_layer_interfaces`
- `anim_blueprint_screenshot`
- `anim_blueprint_set_preview_mesh`

### StaticMesh / EnhancedInput

- `static_mesh_get_bounds`
- `static_mesh_get_local_corners`
- `static_mesh_open_editor`
- `static_mesh_get_info`
- `static_mesh_set_preview_view`
- `static_mesh_set_material_slot`
- `static_mesh_set_collision_boxes`
- `static_mesh_set_collision_spheres`
- `static_mesh_set_collision_capsules`
- `static_mesh_add_socket`
- `static_mesh_update_socket`
- `static_mesh_remove_socket`
- `enhanced_input_create_action`
- `enhanced_input_get_action_info`
- `enhanced_input_export_action_json`
- `enhanced_input_apply_action_json`
- `enhanced_input_create_mapping_context`
- `enhanced_input_get_mapping_context_info`
- `enhanced_input_export_mapping_context_json`
- `enhanced_input_apply_mapping_context_json`

### Material / Material Instance / Material Function

- `material_create`
- `material_instance_create`
- `material_open_editor`
- `material_get_info`
- `material_compile`
- `material_get_compile_log`
- `material_export_folder`
- `material_apply_folder`
- `material_instance_export_folder`
- `material_instance_apply_folder`
- `material_function_export_folder`
- `material_function_apply_folder`
- `material_list_expressions`
- `material_set_parameter`

### Sequence / UMG Animation / Montage

- `sequence_list_level_sequences`
- `sequence_create_level_sequence`
- `sequence_open_level_sequence`
- `sequence_get_level_sequence_info`
- `sequence_export_folder`
- `sequence_apply_folder`
- `sequence_list_umg_animations`
- `sequence_get_umg_animation_info`
- `montage_list_montages`
- `montage_create`
- `montage_open_editor`
- `montage_get_info`
- `montage_export_json`
- `montage_apply_json`
- `montage_list_skeleton_slots`

### Niagara

- `niagara_list_assets`
- `niagara_create_system`
- `niagara_create_emitter`
- `niagara_delete_asset`
- `niagara_duplicate_asset`
- `niagara_open_editor`
- `niagara_screenshot`
- `niagara_get_info`
- `niagara_compile_system`
- `niagara_get_compile_log`
- `niagara_get_stack_issues`
- `niagara_apply_stack_issue_fix`
- `niagara_refresh_system`
- `niagara_system_runtime_probe`
- `niagara_export_folder`
- `niagara_apply_folder`
- `niagara_emitter_export_folder`
- `niagara_emitter_apply_folder`
- `niagara_script_export_folder`
- `niagara_script_apply_folder`
- `niagara_user_parameter_list`
- `niagara_user_parameter_get`
- `niagara_system_list_emitters`
- `niagara_system_get_property`
- `niagara_emitter_get_property`
- `niagara_emitter_list_renderers`
- `niagara_emitter_get_renderer_property`
- `niagara_emitter_list_event_handlers`
- `niagara_emitter_get_event_handler_property`
- `niagara_emitter_parameter_list`
- `niagara_emitter_parameter_get`
- `niagara_emitter_list_stages`
- `niagara_emitter_list_stage_modules`
- `niagara_emitter_list_stage_nodes`
- `niagara_emitter_list_module_inputs`

Niagara 完整 authoring 使用 `niagara_export_folder / niagara_apply_folder`、`niagara_emitter_export_folder / niagara_emitter_apply_folder`、`niagara_script_export_folder / niagara_script_apply_folder`。System / Emitter apply 默认随返回带 Stack issue 信息；严格验收看 `warnings`、`stack_error_count`、compile log、runtime probe 和 `validation/coverage_report.json`。

Niagara module input 写入必须检查“控制项 + 活跃分支 + 目标值”三件事：

- mode / enum / static switch 控制目标参数是否生效，例如 `Sprite Size Mode=Non-Uniform` 才会使用 `Module.Sprite Size=(X=...,Y=...)`。
- 按 mode 校验模式专属属性组：`Uniform -> Uniform Sprite Size`，`Random Uniform -> Uniform Sprite Size Min / Max`，`Non-Uniform -> Sprite Size`，`Random Non-Uniform -> Sprite Size Min / Max`。
- `module_input_hidden_or_inactive_branch` 表示写入可能在非活跃分支，不应直接忽略；先设置控制项，重新导出，再写分支值。
- 枚举要看 `enum_value_display_name` 和 `enum_options[]`，不要只凭 `NewEnumeratorN` 判断。
- Renderer 绑定也要读回；细长 Sprite 至少要确认 `Particles.SpriteSize` binding、速度对齐或等价对齐。

### Animation Assets / Skeleton

- `anim_sequence_get_info`
- `anim_sequence_screenshot`
- `skeleton_get_info`
- `skeleton_list_bones`

纯属性写入优先走 `asset_export_property_json / asset_apply_property_json`；notify、curve、sync marker 等结构命令按 `13_AnimationAssets_Skeleton.md` 判断。

### IK Rig / IK Retargeter

- `ik_rig_create`
- `ik_rig_get_info`
- `ik_rig_set_preview_mesh`
- `ik_rig_set_goal`
- `ik_rig_set_retarget_root`
- `ik_rig_set_retarget_chain`
- `ik_rig_set_solver`
- `ik_rig_apply_auto_retarget_definition`
- `ik_retargeter_create`
- `ik_retargeter_get_info`
- `ik_retargeter_set_ik_rig`
- `ik_retargeter_set_settings`
- `ik_retargeter_set_pose`
- `ik_retargeter_set_preview_mesh`
- `ik_retargeter_auto_map_chains`
- `ik_retargeter_duplicate_and_retarget`

### Modeling

- `modeling_activate_mode`
- `modeling_get_selection`
- `modeling_set_selection`
- `modeling_set_mesh_selection_mode`
- `modeling_get_mesh_selection_info`
- `modeling_clear_mesh_selection`
- `modeling_select_mesh_elements_via_screen`
- `modeling_select_mesh_elements_via_world_ray`
- `modeling_start_tool`
- `modeling_get_active_tool`
- `modeling_get_active_tool_properties`
- `modeling_set_active_tool_property`
- `modeling_invoke_active_tool_action`
- `modeling_accept_tool`
- `modeling_cancel_tool`
- `modeling_save_mesh_asset`
- `modeling_replace_actor_mesh`
- `modeling_snap_to_ground`
- `modeling_convert_actor_to_dynamic_mesh`
- `modeling_duplicate_to_new_static_mesh`
- `modeling_create_box`
- `modeling_create_cylinder`
- `modeling_create_sphere`
- `modeling_create_plane`
- `modeling_create_stairs`
- `modeling_create_ramp`
- `modeling_create_ramp_corner`
- `modeling_extrude_faces`
- `modeling_inset_faces`
- `modeling_bevel_edges`
- `modeling_offset`
- `modeling_push_pull`
- `modeling_mirror`
- `modeling_duplicate_faces`
- `modeling_boolean`
- `modeling_trim`
- `modeling_plane_cut`
- `modeling_mesh_cut`
- `modeling_voxel_boolean`
- `modeling_remesh`
- `modeling_simplify`
- `modeling_subdivide`
- `modeling_weld_edges`
- `modeling_fill_holes`
- `modeling_recompute_normals`
- `modeling_set_pivot`
- `modeling_bake_transform`
- `modeling_align_to_world`
- `modeling_auto_uv`
- `modeling_project_uv`
- `modeling_set_material_slot`
- `modeling_add_material_slot`
- `modeling_remove_material_slot`
- `modeling_generate_simple_collision`
- `modeling_generate_convex_collision`

## 常用文档入口

- JSON / 结构化 JSON 主流程：`commands/README.md` 的“资产编辑优先级”
- Niagara folder schema：`commands/15_Niagara_FolderFormat.md`
- Niagara 红黄感叹号：`commands/07_Niagara_System.md` 的 `niagara_get_stack_issues`
- 废弃命令归档：`commands/deprecatedCommand/README.md`
- CLI 使用：`UeAgentInterfaceCMD/docs/USAGE.md`
