# 指令详解：Core / Level / Assets / Landscape

## Core / Session

| 指令 | 作用 | 关键参数 | 典型用途 |
|---|---|---|---|
| `get_world_state` | 读取当前编辑器世界状态 | 无 | 批处理前确认当前关卡和世界是否有效 |
| `begin_transaction` | 开启 UE 事务 | `label` | 多步修改前包一层可撤销事务 |
| `end_transaction` | 结束 UE 事务 | `commit` | 成功提交；失败时可不提交 |
| `undo` | 撤销上一步事务 | 无 | 快速回滚错误修改 |
| `redo` | 重做已撤销事务 | 无 | 验证回滚链路 |
| `exec_batch` | 顺序执行多条命令，支持遇错中断 | `commands[]`、`stop_on_error` | 复杂自动化的默认入口 |
| `editor_console_exec` | 执行 UE 底部状态栏 `Cmd` 控制台命令的等价路径 | `command` 或 `commands[]`、`world_context`、`allow_high_risk`、`stop_on_error`、`fail_on_unhandled`、`add_to_history`、`max_output_chars`、`max_output_lines` | 运行 `viewmode`、`stat`、`r.*` CVar 查询/设置、`DumpConsoleCommands` 等 UE 控制台命令 |
| `save_current_level` | 保存当前关卡 | `only_if_dirty` | 批处理结束后落盘 |
| `level_create_blank` | 创建并打开新的空 persistent Level 资产 | `asset_path`/`level_path`、`overwrite_policy`、`save_existing_map` | 为自动化演示或测试创建干净场景，避免污染当前关卡 |
| `level_open` | 打开已有 persistent Level 资产 | `asset_path`/`level_path`、`save_existing_map` | 在专用 demo map 或测试 map 之间切换 |
| `editor_get_open_assets` | 列出当前已打开的资产编辑器 | 无 | 获取编辑器上下文 |
| `open_asset_editor` | 打开指定资产编辑器 | `asset_path` | 打开 Blueprint / Material / Niagara |
| `save_asset` | 保存指定资产 | `asset_path`、`only_if_dirty` | 保存关键资产修改 |
| `asset_duplicate` | 复制资产到指定路径 | `source_asset_path`、`destination_asset_path`、`save_after_duplicate` | 先复制测试资产，再在副本上做安全修改 |
| `asset_move` | 通过 UE AssetTools 移动或重命名资产 | `source_asset_path` 或 `asset_path`、`destination_asset_path` 或 `destination_folder`、可选 `destination_name/dry_run/save_after_move` | 把旧资产归档到 Deprecated 目录，同时让 UE 处理重命名、引用更新和保存 |
| `asset_delete` | 删除未被任何外部对象引用的资产 | `asset_path` / `asset_paths` 或 `folder_path` / `folder_paths`、`recursive`、`dry_run`、`allow_dirty`、`include_path_string_hits`、`allow_non_game`、`delete_empty_folders` | 清理确认无外部引用的普通资产、临时 Niagara 资产或测试资产；同批次内部引用只诊断不阻断，有外部 referencer / 可疑路径字符串 / 打开编辑器 / 脏包时默认阻断；按文件夹删除时默认连空文件夹本体一起删除 |
| `asset_fixup_redirectors` | 删除资产移动后已无引用的 `ObjectRedirector` | `asset_path`、`asset_paths`、`folder_path`、`folder_paths`、`recursive`、`dry_run`、`fail_on_blocked` | 批量移动后清理旧路径 redirector；仍有 referencer 时返回 `redirector_still_referenced`，先改引用再删除 |
| `asset_reference_graph` | 查询任意资产的 AssetRegistry 引用关系 | `asset_path`，可选 `direction/recursive/max_depth/include_*` | 在改 AnimBP、Montage、Level、清理旧资源前建立依赖/反向引用图 |
| `asset_import_texture` | 导入外部贴图为 Texture2D | `source_filename`、`destination_path`，可选 `destination_name/srgb/compression_settings/mip_gen_settings/lod_group` | 把外部 PNG/TGA/JPG/EXR/HDR 等贴图纳入 UE 资产链路 |
| `asset_import_fbx_skeletal_mesh` | 导入 FBX 为 Skeletal Mesh | `source_filename`、`destination_path`，可选 `skeleton_path/import_materials/import_textures/create_physics_asset/import_animations/import_morph_targets/update_skeleton_reference_pose/validate_after_import/expected_*` | 把外部角色模型/骨骼导入到项目，并可验证 Morph/LOD/材质槽 |
| `asset_import_fbx_animation` | 导入 FBX 为 AnimSequence | `source_filename`、`destination_path`，以及 `skeleton_path` 或 `skeletal_mesh_path` | 批量导入第三方动作到现有骨骼 |
| `asset_import_geometry_cache` | 导入 Geometry Cache / Alembic | `source_file`、`destination_path` | 为 ML Deformer / 高质量变形验证导入缓存 |
| `asset_export_property_json` | 导出资产属性为 JSON | `asset_path`；可选 `property_names[]`、`output_file` | 把 AnimSequence / Texture / Mesh 的常用属性拉成可编辑 JSON |
| `asset_apply_property_json` | 从 JSON 回写资产属性 | `asset_path` 或 `json_file`；可选 `properties[]`、`save_after_apply` | 按 JSON 批量回写 AnimSequence / Texture / Mesh 的属性 |
| `curve_export_json` | 导出 Curve 资产为结构化 JSON | `asset_path`；可选 `output_file` | 读取 CurveFloat / CurveVector / CurveLinearColor / CurveTable |
| `curve_apply_json` | 创建或回写 Curve 资产结构化 JSON | `asset_path`；可选 `curve`、`json_file`、`create_if_missing`、`curve_kind`、`save_after_apply` | 用统一 JSON 编辑曲线 key、插值、外推和表格行 |
| `editor_list_dirty_resources` | 列出当前所有待处理的脏资源 | 无 | 退出前先枚举未保存关卡/资产 |
| `editor_resolve_dirty_resources` | 按路径或整批保存/丢弃脏资源 | `save_resource_paths`、`discard_resource_paths`、`save_all_dirty`、`discard_all_dirty`、`close_all_asset_editors`、`only_save_dirty` | 先处理脏资源，再决定是否关闭编辑器 |
| `editor_close` | 关闭编辑器；若仍有未处理脏资源则失败并返回清单 | `request_exit`、`close_all_asset_editors` | 自动化结束时安全退出 |
| `editor_prepare_exit` | 退出前按策略保存/丢弃并请求关闭编辑器 | `save_asset_paths`、`discard_asset_paths`、`discard_all_dirty`、`request_exit` | 自动化结束时避免恢复弹窗 |

`begin_transaction` / `end_transaction` 是多步写入的显式事务边界。显式事务中调用 `spawn_actor` 时，服务端会登记新建 Actor；`end_transaction` 传 `commit=false` 时，除调用 UE 事务取消外，还会清理这些新建 Actor，并返回 `registered_spawned_actor_count` / `rolled_back_spawned_actor_count`，避免验证探针或失败批处理在关卡里残留对象。

### `level_create_blank` / `level_open`

用途：创建或打开一个独立的 persistent Level 资产。需要在干净场景中做自动化演示、截图或 smoke 时，优先创建专用 map，再通过 Level Content JSON 写入场景实例，避免把临时内容混入当前业务关卡。

关键参数：

- `asset_path` / `level_path` / `map_path` / `package_path`：Level long package path，例如 `/Game/UAI_Demos/PunchForwardReturn_20260613/L_PunchForwardReturn_20260613`。
- `overwrite_policy`：仅 `level_create_blank` 使用。`fail` 默认，目标存在时报错；`replace` 覆盖保存新的空 map；`reuse` 打开已有 map，不创建新 map。
- `save_existing_map`：创建或打开前是否先保存当前 dirty map，默认 `true`。批处理脚本应先用 `editor_list_dirty_resources` 明确当前 dirty 范围。

返回字段：

- `created`、`opened`、`saved`：本次是否创建、打开、保存。
- `asset_path`、`filename`、`world_path`：Level package path、磁盘文件路径和当前 world 路径。

### `asset_reference_graph`

用途：对任意资产建立 AssetRegistry 级引用关系图。凡是要替换角色、重建 AnimBP/Montage、清理旧资源、判断某个资产能否删除，都应先用此指令确认“它引用了谁”和“谁引用了它”，不要只靠单个蓝图导出或二进制字符串扫描。

关键参数：

- `asset_path`：必填，资产 package path、object path 或 UE 文本对象引用均可，例如 `/Game/Foo/Bar`、`/Game/Foo/Bar.Bar`、`/Script/Engine.BlueprintGeneratedClass'/Game/Foo/BP.BP_C'`。
- `direction`：可选，`dependencies` / `referencers` / `both`，默认 `both`。
- `recursive`：可选，是否递归展开引用图，默认 `false`。
- `max_depth`：可选，递归深度，默认非递归为 `1`，递归为 `3`，上限 `16`。
- `max_nodes`：可选，最大节点数，默认 `1024`，超过会返回 `truncated=true`。
- `include_hard` / `include_soft`：可选，是否包含 hard / soft package dependency，默认都为 `true`。
- `include_manage`：可选，是否包含 Asset Manager manage dependency，默认 `true`。
- `include_searchable_names`：可选，是否包含 searchable name dependency，默认 `true`。
- `force_scan`：可选，先同步 `SearchAllAssets(true)` 再查，默认 `false`。
- `allow_missing`：可选，资产不存在时仍按 package name 查询引用图，默认 `false`。
- `include_path_string_hits`：可选，额外扫描项目 `Content/**/*.uasset|*.umap` 中的原始 package path 字符串，默认 `false`。这不是 AssetRegistry 正式引用，只用于发现旧软路径、地图残留字符串或可疑 stale reference。
- `max_path_string_hits`：可选，路径字符串扫描最大命中数，默认 `200`。

返回字段：

- `asset_found`、`root_asset_data_count`：目标资产是否在 AssetRegistry 中存在。
- `dependencies[]`：目标资产直接引用的边，`source=目标资产`，`target=被引用资产`。
- `referencers[]`：直接引用目标资产的边，`source=引用者`，`target=目标资产`。
- `nodes[]`：图中节点，包含 `package_name/object_path/asset_class/asset_found/is_redirector/depth/role`。
- `edges[]`：图中边，包含 `source/target/query_direction/category/category_flags/property_flags/relation_kind/properties/hard/soft/game/build/direct_manage/indirect_manage/depth`。
- `dependency_count`、`referencer_count`、`node_count`、`edge_count`、`truncated`：统计和截断状态。
- `path_string_hits[]`：仅 `include_path_string_hits=true` 时返回，表示哪些包文件原始字节里包含目标 package path。

示例：

```json
{
  "command": "asset_reference_graph",
  "params": {
    "asset_path": "/Game/Characters/PaladinRootMotion/ABP_Paladin_Player_RM",
    "direction": "both",
    "recursive": true,
    "max_depth": 3,
    "include_path_string_hits": true
  }
}
```

注意：`asset_reference_graph` 的主结果来自 UE AssetRegistry。若 `path_string_hits` 命中但 AssetRegistry 没有边，通常表示旧软路径字符串、未重新保存的包、redirector 残留或不可解析的自定义序列化字段，需要进一步用对应资产的结构化导出或属性 JSON 验证。

### `asset_delete`

用途：删除确认没有外部引用的资产。该命令只处理 Content Browser 资产，不删除关卡 Actor；关卡实例清理仍使用 `level_content_delete_scope` 或对应 Level Content JSON 工作流。命令不会裸删 `.uasset` 文件，而是先通过 AssetRegistry 反向引用、打开编辑器、dirty package 和可选路径字符串扫描做 preflight，只有 `deletable=true` 的目标才交给 UE Editor 的对象删除路径。

关键参数：

- `asset_path` / `asset_paths`：与 `folder_path` / `folder_paths` 必填其一；支持 package path、object path 或 UE 文本对象引用。
- `folder_path` / `folder_paths`：与 `asset_path` / `asset_paths` 必填其一；展开 Content Browser 文件夹下的资产后进入同一批删除 preflight。
- `recursive`：可选，默认 `false`。为 `true` 时 `folder_path` / `folder_paths` 递归展开子文件夹。
- `dry_run`：可选，默认 `true`。为 `true` 时只做 preflight，不删除。
- `delete_empty_folders` / `delete_folders`：可选，默认 `true`。仅在传入 `folder_path` / `folder_paths` 时生效；资产删除后会删除请求的空文件夹本体。为 `false` 时只删除资产并保留空文件夹。
- `fail_on_blocked`：可选，默认 `true`。任一目标被阻断时整条命令失败并返回 `asset_delete_blocked`。
- `allow_non_game`：可选，默认 `false`。默认只允许删除 `/Game/**`，避免误删 Engine/Plugin 资产。
- `allow_dirty`：可选，默认 `false`。目标包 dirty 时默认阻断；删除临时未保存资产时必须显式传 `true`。
- `close_asset_editors` / `allow_open_editors`：可选，默认都为 `false`。目标资产已打开时默认阻断；可选择先关闭编辑器，或显式允许打开状态删除。
- `include_hard` / `include_soft` / `include_manage` / `include_searchable_names`：可选，默认都为 `true`，控制 AssetRegistry referencer 分类。
- `include_path_string_hits`：可选，默认 `true`。额外扫描项目 `Content/**/*.uasset|*.umap` 中的原始 package path 字符串；外部命中默认阻断。
- `block_on_path_string_hits`：可选，默认 `true`。若只想把字符串扫描作为诊断，可传 `false`。
- `force_scan`：可选，默认 `true`。删除前同步刷新 AssetRegistry。

返回字段：

- `folder_expansions[]`：每个请求文件夹的展开结果，包含 `folder_path`、`recursive`、`asset_count`、`asset_paths[]`。
- `assets[]`：每个解析后目标的 preflight 结果，包含 `deletable`、`blocked_reasons[]`、`referencers[]`、`external_referencer_count`、`internal_referencer_count`、`path_string_hits[]`、`external_path_string_hit_count`、`internal_path_string_hit_count`、`package_dirty`、`open_in_asset_editor`、`package_exists_on_disk`。
- `blocked[]` / `blocked_count`：被阻断的目标及原因。
- `deletable_count`：通过 preflight 的目标数。
- `deleted_assets[]` / `deleted_count`：真实删除后的目标列表；`dry_run=true` 时为 `0`。
- `remaining_packages[]` / `remaining_package_count`、`remaining_asset_registry_count`、`residual_object_count`：删除后仍存在的包、AssetRegistry 记录或同路径有效 UObject；非 dry-run 下任一大于 0 时返回 `asset_delete_incomplete`。
- `folder_deletions[]`：按请求文件夹逐项报告空目录处理结果，包含 `folder_path`、`filesystem_path`、`status`、`would_delete`、`deleted`、`directory_exists_after`、`remaining_file_count`、`remaining_directory_count`、`blocked_reasons[]`。
- `folder_delete_count` / `folder_would_delete_count` / `folder_delete_blocked_count`：真实删除的文件夹数、dry-run 将删除的文件夹数、因非空/根目录/非 `/Game` 等原因被阻断的文件夹数。

示例：

```json
{
  "command": "asset_delete",
  "params": {
    "asset_path": "/Game/Temp/NE_TestEmitter",
    "dry_run": false,
    "allow_dirty": true,
    "include_path_string_hits": true
  }
}
```

删除前的推荐流程：先 `asset_reference_graph` 查询 `direction=referencers`；再用 `asset_delete dry_run=true` 看完整阻断原因；只有确认 `deletable_count` 与目标数一致后，才传 `dry_run=false`。

批量删除语义：

- 同一条 `asset_delete` 请求里的资产集合会先完整归一化，显式 `asset_paths` 和 `folder_path/folder_paths` 展开的资产属于同一批次。
- AssetRegistry referencer 如果来自同批次资产，会计入 `internal_referencer_count` 并在对应 `referencers[]` 上标记 `internal_reference=true`，不会阻断删除。
- 路径字符串命中如果来自同批次资产，会计入 `internal_path_string_hit_count` 并在对应 `path_string_hits[]` 上标记 `internal_hit=true`，不会阻断删除。
- 只有同批次外部资产产生的 referencer 或路径字符串命中才计入 `external_*` 并按默认策略阻断。

递归删除文件夹示例：

```json
{
  "command": "asset_delete",
  "params": {
    "folder_path": "/Game/Temp/Generated",
    "recursive": true,
    "dry_run": true,
    "delete_empty_folders": true
  }
}
```

按文件夹删除时，即使展开后没有任何资产，只要 `delete_empty_folders=true` 且请求文件夹为空，也会删除该文件夹本体并返回 `folder_delete_count=1`；不会再把空文件夹场景当作 `no_assets_resolved`。目录删除只删除空目录，不递归强删含有未知文件或未删除子目录的目录。

### `asset_import_fbx_skeletal_mesh` 角色变形相关参数

- `import_morph_targets`：写入 `UFbxSkeletalMeshImportData::bImportMorphTargets`。
- `update_skeleton_reference_pose`：写入 `UFbxSkeletalMeshImportData::bUpdateSkeletonReferencePose`。
- `import_skin_weight_profiles`：不会在 FBX 主导入里隐式执行；返回 warning，后续应使用 `skeletal_mesh_import_skin_weight_profile` 显式导入。
- `preserve_existing_morph_targets`：当前新导入路径只报告该兼容字段；reimport 场景需走专用 reimport 流程。
- `validate_after_import`：默认开启，导入后回读 SkeletalMesh 的 `lod_count`、`material_slot_count`、`morph_target_count`、`skin_weight_profile_count`。
- `expected_morph_targets[]`、`expected_lod_count`、`expected_material_slots[]`：导入后做硬校验；缺失或数量不符返回 `fbx_skeletal_mesh_import_validation_failed`，并在 `validation_issues[] / validation_report.issues[]` 中返回 `expected_morph_target_missing`、`expected_lod_count_mismatch` 或 `expected_material_slot_missing`。
- Morph Target 导入验收不要只看 `ok=true`。必须检查 `import_morph_targets=true`、`morph_target_count>0`、`morph_targets_imported[]` 包含预期名称，再调用 `skeletal_mesh_get_morph_targets`、`skeletal_mesh_validate_morph_targets` 和 `skeletal_mesh_preview_morph_target` 做读回与 transient component 设置验证。

## Level / Actor / Component

### Level Content authoring 优先级

当前 Level 中持久 Actor / Component 最终态的批量 authoring 默认使用 `23_LevelContent_JSON.md` 的 `level_content_*_json` / `level_actor_*_json` 工作流。2026-05-02 已在打开的 UE 编辑器中实测旧原子流程与 Level Content JSON 流程：普通 Actor 创建/删除/克隆、TargetPoint probe、普通 transform、attach/detach、folder、tag、Actor 属性、普通组件属性读回和托管清理均可由 Level Content 表达，已替代的旧写入命令只保留在 `deprecatedCommand/01_Core_Level_Assets_Landscape.md`。

不要把这个结论扩大到所有 Level 命令：只读诊断、视口/截图、空间 trace/sweep/overlap、几何对齐、`level_spawn_wall_with_opening`、Landscape、morph 展示、Navigation build/query 仍是专用能力。Navigation Bounds Volume 创建和普通场景实例组件属性写入的最终态已被 Level Content JSON 接管；旧入口只作为兼容、bootstrap、探针验证和故障补修能力记录在废弃分册。

| 指令 | 作用 | 关键参数 | 典型用途 |
|---|---|---|---|
| `list_actors` | 列出当前关卡 Actor | `limit` | 读取场景现有对象 |
| `level_spawn_wall_with_opening` | 生成“带开口的墙”（自动拆成多段网格） | `plane`、`wall_size`、`opening_center/opening_size`、`label_prefix` | 门洞/窗洞/通道口：避免手工拆墙造成接口不连通 |
| `actor_list_components` | 列出 Actor 组件 | `id`、`include_non_scene` | 修改组件前定位组件名 |
| `level_list_actor_components` | `actor_list_components` 的同义命令 | 同上 | 统一走 `level_*` 前缀 |
| `level_get_actor_property` | 读取 Actor 属性 | `id`、`property_name` | 调试实例状态 |
| `level_get_component_property` | 读取组件属性 | `id`、`component`（或 `component_id`）、`property_name` | 查询 Mesh / Collision / Material 槽 |
| `level_set_skeletal_mesh_morph_target` | 设置场景 Actor 上 SkeletalMeshComponent 的 Morph Target 权重，可选启动平滑 pulse | `id`、`morph_target`、`weight`，可选 `component/component_id`、`skeletal_mesh`、`clear_existing`、`pulse`、`stop_pulse` | 把导入的 Morph Target 实际接入关卡实例并截图/预览 |
| `level_set_skeletal_animation_pose` | 设置场景 Actor 上 SkeletalMeshComponent 到指定 AnimSequence 帧/时间并刷新骨骼 | `id`、`animation_asset`，可选 `component/component_id`、`time_seconds` 或 `frame_index`+`frame_rate`、`save_after_set` | 把生成或导入的骨骼动画实际接入关卡实例做逐帧截图/预览 |
| `level_get_actor_transform` | 读取 Actor 实例变换 | `id` | 精确读取 `location / rotation / scale` |
| `level_get_selection` | 读取当前选择集 | 无 | 获取当前选中对象 |
| `level_set_selection` | 设置选择集 | `actor_ids`、`mode` | 后续聚焦、批量操作 |
| `navmesh_build` | 构建/刷新 NavMesh | `wait_for_finish`、`timeout_seconds` | 白盒验收前生成可查询导航数据 |
| `navmesh_project_point` | 单点投影到 NavMesh（只投影不查路） | `point`（或 `location`）、`project_query_extent` | 查路前先确认“投影落点是否在期望层面” |
| `navmesh_find_path` | NavMesh 两点查路 | `start`、`end`、`allow_partial`、`project_to_nav` | 批量判定关键节点连通性 |
| `level_validate_connectivity` | 多点连通性验收（walk + 显式边） | `points[]` 或 `probe_actor_ids[]`、可选 `pairs[].edge_type`、`graph_root_index` | 把“断路点/断回环”结构化输出为逐对+图报告 |
| `level_trace_world_ray` | 世界射线 Trace（不依赖 viewport） | `start`、`direction`、`trace_distance`、`trace_channel` | 查地面、查遮挡、查通道是否堵住 |
| `level_snap_to_surface` | 沿射线吸附 Actor 到命中面 | `id`、可选 `start/direction/offset_cm` | 快速贴合地面/墙面，减少悬空与缝隙 |
| `level_sweep_capsule` | 胶囊 Sweep 通行性检测 | `start`、`end`、`radius_cm`、`half_height_cm`、`trace_channel` | 检查门洞/走廊/电梯轨迹净空 |
| `level_sweep_capsule_path` | 折线路径胶囊 Sweep（路径净空） | `points[]`、`radius_cm`、`half_height_cm`、`step_cm` | 检查楼梯/走廊/电梯轨迹中途阻挡与净空不足 |
| `level_check_overlaps` | Overlap 检测（碰撞穿插） | `shape`、`center`、形状参数、`trace_channel` | 发现“摆放穿插/互相卡住/门墙不贴合”等问题 |
| `level_align_actor_vertex_to_vertex` | 按网格顶点把 Actor 对齐到目标顶点 | `source_actor_id`、`target_actor_id`、顶点选择参数 | 白盒模块拼接时做精确顶点对齐 |
| `mesh_get_closest_vertex` | 查询 Actor 网格中最接近世界点的顶点 | `id`、`world_position` | 对齐前定位候选顶点 |
| `mesh_get_vertex_world_position` | 读取 Actor 网格指定顶点的世界坐标 | `id`、`vertex_index` | 顶点对齐、几何诊断和留证 |
| `screenshot_viewport` | 抓取当前 Level Viewport 截图，可临时切换编辑器 View Mode / Visualization Mode | 可选 `format`、`quality`、`max_size`、`output_file`、`warmup_frames`、`render_warmup_frames`、`tick_editor_world`、`editor_world_tick_frames`、`editor_world_tick_delta_seconds`、`view_mode`、`editor_view_mode`、`mode`、`mode_key`、`debug_view_mode`、`visualization_family`、`visualization_mode`、`visualizer`、`visualizer_mode`、`view_mode_family`、`debug_mode`、`restore_view_mode`、`restore_view_mode_after_capture` | 最终画面、优化视图、Lumen/Nanite/Substrate/Groom/VSM 等视口调试模式留证 |
| `screenshot_viewport_buffer` | 抓取深度/法线/底色等调试 buffer | `buffer`、可选 `format`、`quality`、`max_size`、`output_file`、`depth_mode`、`depth_near_cm`、`depth_far_cm`、`depth_auto_pct_low`、`depth_auto_pct_high`、`invert` | 更稳定地检查遮挡、悬空、穿插和深度问题 |
| `viewport_get_camera` | 读取当前 Level Viewport 相机 | 无 | 保存当前取景状态 |
| `viewport_get_warnings` | 读取当前 Level Viewport renderer warning/probe | 可选 `include_suppressed` | 诊断全局裁剪平面、forward shading 主光等渲染告警 |
| `viewport_set_camera` | 设置当前 Level Viewport 相机 | `location`、`rotation`、可选 `fov` | 复现固定视角并截图 |
| `viewport_focus_actor` | 聚焦单个 Actor | `id`、可选 `padding` | 快速定位目标 Actor |
| `viewport_focus_actor_safe` | 防卡墙的稳健 Actor 聚焦 | `id`、可选 `collision_aware/look_at/auto_fallback` | 室内或遮挡复杂场景的取景 |
| `viewport_frame_actor` | 按 Actor bounds 计算并写入视口相机 | `id`、可选 `padding/collision_aware/look_at` | 精确 framing 并返回相机读回 |
| `viewport_frame_actors` | 按多个 Actor 聚合 bounds 取景 | `actor_ids[]`、可选 `padding` | 批量对象截图 |
| `viewport_frame_folder` | 按 Outliner folder 聚合 bounds 取景 | `folder_path`、可选 `include_child_folders/padding/collision_aware` | 白盒区域或托管资源整组留证 |
| `viewport_frame_selection` | 按当前选择集聚合 bounds 取景 | 可选 `padding` | 人工选择后自动留证 |
| `viewport_set_game_view` | 切换 Game View | `game_view`、可选 `restore_editor_widgets` | 截图前隐藏或恢复编辑器辅助显示；退出 Game View 时默认恢复变换控件相关 show flags |
| `viewport_get_editor_interaction_state` | 读取 Level Viewport 编辑器交互状态 | 无 | 诊断坐标轴/变换控件消失、Game View、Selection/ModeWidgets/Pivot show flag |
| `viewport_restore_editor_interaction_state` | 恢复 Level Viewport 编辑器交互状态 | `all_viewports`、`game_view`、`mode_widgets`、`selection`、`pivot`、`widget_mode` | 自动化操作后恢复 Actor 选中时的变换控件/坐标轴 |
| `viewport_list_view_modes` | 列出 `screenshot_viewport` 可用的视口模式和可视化子模式 | 无 | 生成/调试截图请求前发现当前引擎实际可用的 mode key |
| `viewport_set_realtime` | 切换视口实时刷新 | `realtime`；兼容 `enabled` | 需要 Niagara/动画预览或稳定截图时控制实时性 |
| `viewport_deproject_screen_to_world` | 屏幕坐标反投影到世界射线 | `screen_x`、`screen_y` | 视口拾取和屏幕点诊断 |
| `viewport_trace_screen_point` | 从屏幕点发起世界 Trace | `screen_x`、`screen_y`、可选 `trace_channel/trace_distance` | 根据截图坐标定位命中 Actor |

`screenshot_viewport`、`screenshot_viewport_buffer` 以及复用该写图路径的命令在输出 `png/jpg/webp` 时默认写出不透明图片；即使底层 viewport readback 返回透明 alpha，最终文件也会把 alpha 归一为 `255`，避免在深色 UI 或报告里被合成为黑图。

### `screenshot_viewport`

抓取当前 Level Viewport 的 backbuffer 截图。默认不传视图模式时保持当前视口状态，可用于验证用户实际看到的最终画面；传入 `view_mode` 或 `visualization_family` 时，会临时切换到指定编辑器 View Mode / Visualization Mode 后截图，默认截图后恢复原状态。

- `format`：可选，`jpg` 默认；支持 `png`、`jpg`、`webp`。
- `quality`：可选，`jpg/webp` 压缩质量，默认 `85`。
- `max_size`：可选，最长边缩放上限，默认 `1024`。
- `output_file`：可选；相对路径按项目根目录解析。若未显式传 `format`，会优先使用 `output_file` 的 `png/jpg/webp` 扩展名；若同时传了 `format`，扩展名必须一致。
- `warmup_frames`：可选，默认 `2`，范围 `0..8`。截图前额外绘制并 flush 若干帧，让 PlanarReflection、TAA、反射历史和场景捕获类效果先更新，再读取最终 backbuffer。
- `render_warmup_frames`：`warmup_frames` 的兼容别名。
- `tick_editor_world`：可选，默认 `false`。为 `true` 时，截图前会推进 Editor World，让依赖 `ShouldTickIfViewportsOnly`、Niagara 或运行时 RenderTarget writer 的系统在同一批次收敛。
- `editor_world_tick_frames`：可选；`tick_editor_world=true` 时生效，默认取请求的 `warmup_frames/render_warmup_frames`，范围 `0..240`。
- `editor_world_tick_delta_seconds`：可选；默认 `1/60`，范围 `1/240..1/5`。
- `view_mode`：可选。支持普通视图 key，例如 `lit`、`unlit`、`wireframe`、`lit_wireframe`、`detail_lighting`、`lighting_only`、`reflections`、`shader_complexity`、`shader_complexity_and_quads`、`quad_overdraw`、`light_complexity`、`lightmap_density`、`lwc_complexity`、`player_collision`、`visibility_collision`、`lod_coloration`、`path_tracing`。也支持 `<family>:<mode>` 或 `<family>_<mode>`，例如 `lumen:overview`、`nanite_triangles`、`virtual_shadow_map:mask`、`buffer_world_normal`。
- `editor_view_mode` / `mode` / `mode_key` / `debug_view_mode`：`view_mode` 的兼容别名。
- `visualization_family`：可选。显式指定可视化族，支持 `buffer`、`nanite`、`lumen`、`substrate`、`groom`、`virtual_shadow_map`、`virtual_texture`、`actor_coloration`、`gpu_skin_cache`、`ray_tracing_debug`。
- `visualization_mode`：可选。配合 `visualization_family` 使用，例如 `Overview`、`Triangles`、`LumenScene`、`SurfaceCache`、`mask`、`pending`。省略时使用该族默认模式。
- `visualizer` / `view_mode_family`：`visualization_family` 的兼容别名。
- `visualizer_mode` / `debug_mode`：`visualization_mode` 的兼容别名。
- `restore_view_mode`：可选，默认 `true`。为 `true` 时截图后恢复进入命令前的 view mode 和各类 visualization 子模式；为 `false` 时保留切换后的视口模式，返回 `view_mode_left_applied=true`。
- `restore_view_mode_after_capture`：`restore_view_mode` 的兼容别名。

返回字段：

- `capture_mode`：未请求 view mode 时为 `level_viewport_lit`；请求 view mode 时为 `level_viewport_view_mode`。
- `final_lit_composition`：当前截图是否是普通 Lit 最终合成；优化/可视化/调试视图会返回 `false`。
- `warmup_frames_requested`。
- `requested_view_mode`：当请求了 `view_mode` 或 `visualization_family` 时返回，包含解析后的 `key`、`category`、`view_mode_name`、`visualization_family`、`visualization_mode`。
- `view_mode_before_capture` / `view_mode_applied` / `view_mode_after_restore`：当请求了临时 view mode 时返回，用于确认切换和恢复是否生效。
- `viewport`：本次实际使用的 LevelViewportClient 摘要，包含 `selection_reason`、`viewport_client_index`、`viewport_type`、`view_mode_value`、`view_mode_name`、`view_mode_state`、`location`、`rotation`、`fov`、`realtime`、`game_view` 和 `size`。
- `capture`：截图执行细节，包含 `render_path="level_viewport_backbuffer"`、`draws_performed`、`editor_world_ticks_performed`、`temporary_realtime_override` 和同一份 `viewport` 信息。

行为说明：

- 目标 viewport 选择优先级：当前 active viewport -> `GCurrentLevelEditingViewportClient` -> 面积最大的透视 viewport -> 面积最大的任意 viewport -> 第一个有效 viewport。返回的 `viewport.selection_reason` 用于核对是否抓到了人工正在看的视口。
- 未请求 view mode 时，该命令读取当前 Level Viewport backbuffer，适合判断 PlanarReflection、SSR、后期处理和 Single Layer Water 最终观感。
- 请求 view mode 时，该命令走编辑器自身 `FLevelEditorViewportClient` 的模式切换路径，覆盖 View Mode 主菜单和子菜单式可视化：Buffer、Nanite、Lumen、Substrate、Groom、Virtual Shadow Map、Virtual Texture、Actor Coloration、GPU Skin Cache、Ray Tracing Debug 等。实际可用 key 以 `viewport_list_view_modes` 返回为准。
- 对需要 editor-world tick 的视觉系统，使用 `tick_editor_world=true` 并检查 `capture.editor_world_ticks_performed`，不要只提高 `warmup_frames`。
- 如果只需要深度、法线或底色的稳定数值诊断，优先使用 `screenshot_viewport_buffer`；如果需要和编辑器 View Mode 菜单一致的视觉留证，使用本命令的 `view_mode`。

### `viewport_list_view_modes`

列出当前引擎和项目环境中 `screenshot_viewport` 可接受的稳定 key。该命令不修改视口状态。

返回字段：

- `schema="uai.viewport_view_modes.v1"`。
- `mode_count`。
- `modes[]`：每项包含 `key`、`category`、`label`、`view_mode_name`、`view_mode_value`、`final_lit_composition`；可视化模式还包含 `visualization_family` 和 `visualization_mode`。
- `viewport`：当前 LevelViewportClient 摘要和 `view_mode_state`，便于确认当前菜单状态。

常见用法：

```json
{
  "command": "viewport_list_view_modes"
}
```

```json
{
  "command": "screenshot_viewport",
  "params": {
    "view_mode": "lumen:overview",
    "restore_view_mode": true,
    "format": "jpg",
    "max_size": 1024
  }
}
```

### 组件碰撞属性写入

- Level Content JSON 的 `resources[].properties` / `components[].properties` 写入 `BodyInstance.*`、`Collision*` 或 `CanCharacterStepUpOn` 时，都会刷新 `UPrimitiveComponent` 的物理状态，使后续 Trace / Sweep / Overlap 使用新碰撞配置。
- 返回中若出现 `primitive_collision_state_refreshed=true`，表示本次写入已经触发碰撞状态刷新；写入 `BodyInstance.CollisionProfileName` 时若出现 `collision_profile_setter_applied=true`，表示已调用 `SetCollisionProfileName`，不是只做 ImportText。
- 写入后仍应优先用 `level_get_component_property` 读回目标属性，再用 `level_sweep_capsule_path` 或 `level_check_overlaps` 验证实际查询结果；不要只凭 `value_text` 判断碰撞已经进入物理场景。
- 角色胶囊通行、IK 地面 Trace、视觉几何可以使用不同碰撞语义，但必须明确区分。例如胶囊可走简化 ramp 以保证移动顺滑，足部 Trace 可命中台阶面或专用脚底辅助面；辅助面若不该影响角色移动，应确保它不阻挡 Pawn。
- 调试楼梯、斜坡或足底贴地时，至少用一次 `level_sweep_capsule_path` 验证胶囊路径，再用 `level_trace_world_ray` 或对应 Control Rig probe 验证足底 Trace 命中点。只验证其中一层容易误判。

### `level_set_skeletal_mesh_morph_target`

对当前关卡中的 Actor 查找 `USkeletalMeshComponent`，可选先设置 `skeletal_mesh`，再调用组件级 `SetMorphTarget`。适合把 FBX 导入得到的 Morph Target 放到真实场景实例中做展示、截图或回归验证。

- `id`：Actor 名称或 Label。
- `component` / `component_id`：可选，指定 SkeletalMeshComponent；不填时使用 Actor 上第一个 `USkeletalMeshComponent`。
- `skeletal_mesh`：可选，SkeletalMesh object path；填写时会先设置到组件。
- `morph_target` / `morph_target_name` / `name`：Morph Target 名称。
- `weight`：Morph Target 权重，默认 `1.0`。
- `clear_existing`：可选，设置前是否清空组件已有 Morph Target 权重。
- `pulse` / `start_pulse` / `animate`：可选，启动 Editor ticker 持续按平滑曲线写入同一 Morph Target；`pulse` 可为 bool，也可为对象。
- `pulse.min_weight` / `min_weight`：循环最小权重，默认 `0.0`。
- `pulse.max_weight` / `max_weight`：循环最大权重，默认 `1.0`。
- `pulse.cycle_seconds` / `cycle_seconds`：一次 `min -> max -> min` 循环秒数，默认 `4.8`。
- `pulse.duration_seconds` / `duration_seconds`：可选，pulse 自动停止秒数；默认 `-1` 表示持续运行到显式停止或组件失效。
- `pulse.tick_interval_seconds` / `tick_interval_seconds`：ticker 间隔秒数，默认 `0.0` 表示每帧更新。
- `pulse.loop` / `loop`：是否循环，默认 `true`。
- `stop_pulse` / `stop_animation`：停止该 Actor/Component/Morph Target 上已有 ticker；未传 `weight` 时会回到 `min_weight`。

同一 Actor/Component/Morph Target 再次启动 `pulse` 会先移除旧 ticker，再注册新的 ticker，避免重复驱动。返回 `applied_weight`、`component_path`、`skeletal_mesh`、`morph_target`、`pulse_started / pulse_stopped`、`pulse_key` 和 `display_status`。普通单次写入返回 `display_status=scene_component_morph_set`；启动循环返回 `display_status=scene_component_morph_pulse_started`。验收时不要只看命令 `ok=true`；应确认 `applied_weight` 与目标权重一致，并通过视口截图或 buffer 截图确认关卡实例可见。循环展示还应做间隔截图或肉眼视口复核，确认轮廓在连续变化。

### `level_set_skeletal_animation_pose`

对当前关卡中的 Actor 查找 `USkeletalMeshComponent`，调用组件单节点动画接口设置 `AnimSequence` 和时间，然后刷新动画、骨骼 transform、bounds 和渲染动态数据。适合在不进 PIE、不依赖 Sequencer 截图评估的情况下，把某个动画帧实际摆到关卡实例上做截图或读回验证。

- `id`：Actor 名称或 Label。
- `component` / `component_id`：可选，指定 SkeletalMeshComponent；不填时使用 Actor 上第一个 `USkeletalMeshComponent`。
- `animation_asset` / `animation_asset_path` / `anim_sequence`：AnimSequence 或 AnimSequenceBase object path。
- `time_seconds`：目标动画时间，超出范围会 clamp 到 `0..play_length`。
- `frame_index` / `frame`：目标帧；未传 `time_seconds` 时使用。
- `frame_rate` / `fps`：`frame_index` 换算秒数的帧率，默认 `30`。
- `save_after_set` / `save_after_apply`：可选，保存当前关卡；默认 `false`。

返回 `actor_label`、`component_path`、`animation_asset`、`requested_time_seconds`、`time_seconds`、`play_length_seconds`、`animation_mode=AnimationSingleNode`、`saved` 和 `display_status=scene_component_animation_pose_set`。验收时不要只看命令 `ok=true`；应配合 `screenshot_viewport` 或帧序列截图确认关卡里的目标实例确实变成了对应动画姿态。

### `level_spawn_wall_with_opening`

用途：一次性生成“墙面矩形 - 开口矩形”的剩余部分（最多 4 段）。典型用来做门洞/通道口，避免手工拆成多段墙时遗漏接口验收导致的“视觉连着但实际被墙封死”。

关键参数：

- `plane`：墙所在平面（用 `center/normal/up` 定义局部坐标系；厚度轴=normal，宽度轴=right，高度轴=up）
  - `center`：墙中心点（世界坐标，cm）
  - `normal`：墙法线方向（世界向量，单位不要求；会归一化）
  - `up`：可选，默认 `{0,0,1}`（若与 normal 近似共线会自动换一个 up）
- `wall_size`：墙尺寸（cm）
  - `thickness_cm`：厚度
  - `width_cm`：宽度（沿 right）
  - `height_cm`：高度（沿 up）
- `opening_center`：开口中心相对墙中心的偏移（cm，位于墙平面内）
  - `right_cm`：沿 right 偏移
  - `up_cm`：沿 up 偏移
- `opening_size`：开口尺寸（cm）
  - `width_cm`：沿 right
  - `height_cm`：沿 up
- `label_prefix`：生成段的标签前缀（实际会生成 `_Left/_Right/_Top/_Bottom` 后缀）
- `folder_path`：可选，Outliner folder

可选参数：

- `opening_padding_cm`：开口扩边（双向各加 padding），用于给门洞留净空
- `clamp_opening`：开口超出墙边界时是否自动夹紧（默认 `false`，建议在调试阶段保持严格失败）
- `min_segment_size_cm`：小于该尺寸的段会跳过生成（默认 `1.0`）
- `class_path`：可选，生成段使用的 Actor 类（默认 `/Script/Engine.StaticMeshActor`）
- `static_mesh`：可选，生成段使用的 StaticMesh（默认 `/Engine/BasicShapes/Cube.Cube`）
- `epsilon_cm`：可选，边界判定用的容差（默认 `0.01`），通常无需调整

示例：生成一面 Y 向墙（normal=(1,0,0)），底边贴地、带门洞（门洞宽 140、高 220，底到地面）：

```json
{
  "command": "level_spawn_wall_with_opening",
  "params": {
    "plane": { "center": { "x": -3220, "y": 1250, "z": 550 }, "normal": { "x": 1, "y": 0, "z": 0 }, "up": { "x": 0, "y": 0, "z": 1 } },
    "wall_size": { "thickness_cm": 40, "width_cm": 1400, "height_cm": 300 },
    "opening_center": { "right_cm": 0, "up_cm": -30 },
    "opening_size": { "width_cm": 140, "height_cm": 220 },
    "opening_padding_cm": 10,
    "label_prefix": "WB_WallW_Door",
    "folder_path": "UAIValidation/Walls"
  }
}
```

### `viewport_get_warnings`

读取当前编辑器 world 中会在 Level Viewport 顶部以红/橙色文字显示的 renderer warning，并返回本地化后的 `text`。这类文字不是普通 `Saved/Logs`，也不是 `GEngine->AddOnScreenDebugMessage`，因此不能只查日志或 on-screen debug 容器。

- `include_suppressed`：默认 `false`。当 screen messages 被全局关闭或 `GEngine->bSuppressMapWarnings=true` 时，默认只在 `suppressed_warning_count` 中计数；传 `true` 时也会把这些条目放入 `warnings[]`，且 `display_expected=false`。
- 返回 `display_gates`：包含 `screen_messages_enabled`、`map_warnings_suppressed`、`display_gate_open`。
- 返回 `renderer_probe`：包含检测条件，例如 `r.AllowGlobalClipPlane`、`planar_reflection_count`、`active_directional_light_count`、`highest_forward_shading_priority`。
- 当前覆盖：
  - `renderer.no_global_clip_plane`：场景中存在 `PlanarReflection` 且 `r.AllowGlobalClipPlane=0`。
  - `renderer.multiple_directional_lights_forward_shading`：多个可见且影响世界的 DirectionalLight 处于相同最高 `ForwardShadingPriority`。

### `level_align_actor_by_bounds`

- `axis`：`x / y / z`
- `source_anchor` / `target_anchor`：`min / center / max`
- `offset`：在对齐结果上追加偏移量

常见用法：

- `source=min` 对 `target=max`：把一块墙贴到另一块墙外侧
- `center` 对 `center`：沿某轴居中
- `max` 对 `max`：把两个包围盒同一侧对齐

相比 `level_align_actor_vertex_to_vertex`，`level_align_actor_by_bounds` 更适合白盒建筑和模块化关卡拼装。

### `level_align_face_to_face`

`level_align_actor_by_bounds` 的白盒友好封装：用“面语义”表达对齐（门/墙、电梯/地面、板/板贴合），避免每次手写 `axis + anchor`。

- `source_face` / `target_face`：
  - `min/max/center`：沿 `axis` 使用对应锚点
  - 或显式：`+x/-x/+y/-y/+z/-z`（会推导 `axis`）
- `offset_cm`：可选，对齐后再加一个间隙/嵌入偏移（cm）

### `viewport_frame_folder`

- `folder_path`：目标 Outliner folder 路径。
- `include_child_folders`：是否递归包含子 folder，默认 `true`。
- `padding`：额外取景留白倍数，默认 `1.1`。
- `collision_aware`：可选，是否启用“室内取景防卡墙”，默认 `false`。
- `safety_offset_cm`：可选，启用防卡墙时使用的安全偏移（cm），默认 `15.0`。
- `trace_channel`：可选，防卡墙 Trace 通道名，默认 `Visibility`。
- `trace_complex`：可选，防卡墙是否使用复杂碰撞，默认 `false`。
- `look_at`：可选，是否把相机朝向自动对准 bounds center，默认 `false`。
- `auto_fallback`：可选，防卡墙增强：自动尝试多个候选相机位，默认 `false`。
- `fallback_step_cm`：可选，`auto_fallback=true` 时的偏移步长（cm），默认 `200`。
- `fallback_offsets_cm`：可选，自定义候选偏移（世界坐标 cm 向量数组）；当提供时，`auto_fallback` 的默认候选不会自动生成。

行为说明：

- 会遍历 folder 下 Actor，聚合有效 bounds。
- 默认只重新计算并写入相机 `location`；若 `look_at=true` 会同步修改 `rotation`（`roll=0`）。
- 返回 `desired_location`（基准理想位）与 `new_location`（实际写入），并附带 `rotation/fov`。
- 当 `collision_aware=true` 时，会从目标 bounds center 向候选相机位做 Trace：
  - 未命中遮挡：直接使用候选位。
  - 命中遮挡：把相机放到命中点沿“Trace 方向反向”回退 `safety_offset_cm` 的位置，避免穿墙/卡墙。
  - 若 `auto_fallback=true` 或提供 `fallback_offsets_cm`，会在多候选中选择“距离目标更远且无遮挡/可修正”的相机位，并返回 `fallback_used/fallback_index/fallback_offset_cm`。
- 仅支持透视视口；若当前有效视口不是透视视口，会返回错误。

### `screenshot_viewport_buffer`

抓取当前视口的“深度/法线/底色”等调试截图（默认深度图），用于更可靠地发现白盒空间错误：穿插、悬空、遮挡、缝隙、楼梯被挡等。

> 注意：该命令返回的是调试 buffer，不是最终 lit 画面。`SceneDepth/DeviceDepth/WorldNormal/BaseColor` 默认走 `SceneCapture2D`，不会包含 Level Viewport 的最终反射/后期合成，不能用来判断 `PlanarReflection`、SSR 或 Single Layer Water 最终画面是否生效。需要判断最终画面时使用 `screenshot_viewport`。

- `buffer`：可选，默认 `SceneDepth`。常用：
  - `SceneDepth`
  - `DeviceDepth`
  - `WorldNormal`
  - `BaseColor`

说明：`SceneDepth/DeviceDepth/WorldNormal/BaseColor` 会优先走 **SceneCapture**（不依赖 editor debug viewmode shader，稳定）；其他值会回退到 **Buffer Visualization**（可能受引擎/项目设置影响）。

其他参数与 `screenshot_viewport` 一致：
- `format`：`png/jpg/webp`
- `quality`：1~100（对 `png` 无效）
- `max_size`：最大边长（会等比缩放）
- `output_file`：可选；相对路径按项目根目录解析。若未显式传 `format`，会优先使用 `output_file` 的 `png/jpg/webp` 扩展名；若同时传了 `format`，扩展名必须一致。

深度图附加参数（仅 `SceneDepth/DeviceDepth` 生效）：
- `invert`：可选，默认 `true`；为 `true` 时“近亮远暗”（更像 UE 的深度调试观感）。
- `depth_mode`：可选，仅 `SceneDepth` 使用；默认 `auto_percentile`（当未提供 `depth_far_cm` 时）。可选：
  - `auto/auto_percentile/percentile`：从截图像素采样 depth，按分位数自动选取可视化范围（默认 2%~98%），避免视口相机较远时整张图接近纯黑/纯白。
  - `fixed/fixed_far/far`：固定范围映射（`depth_near_cm`~`depth_far_cm`）。
- `depth_near_cm`：可选，仅 `SceneDepth` 使用；固定模式下的近端（cm），默认 `0`。
- `depth_far_cm`：可选，仅 `SceneDepth` 使用；**提供后默认走 fixed 模式**。固定模式下默认 `10000`（未提供时）。
- `depth_auto_pct_low` / `depth_auto_pct_high`：可选，仅 auto 模式；默认 `2` / `98`（0~100）。

行为说明：

- **优先 SceneCapture（推荐）**：直接用当前 Level Viewport 的相机（位置/旋转/FOV）做一次 SceneCapture，并读取 RenderTarget 得到对应 buffer；不依赖 `Buffer Visualization` 的 debug 材质。
- **回退 Buffer Visualization（实验）**：临时切换当前 Level Viewport 到 `Buffer Visualization` 模式并设置 `<buffer>`；截图完成后恢复原 view mode 与原 Buffer Visualization Mode。
- 返回字段会带 `capture_mode="scene_capture_buffer"`、`final_lit_composition=false`、`scene_capture_buffer=true`、`validation_scope="debug_buffer_only"`、`buffer`、`method`（`scene_capture` / `buffer_visualization`）和实际使用的 `viewport`，便于批量留证与回归对比。
- 目标 viewport 选择：优先当前正在编辑的 Level Viewport；若无法获取“当前”，则选择面积最大的透视视口（避免抓到隐藏/未渲染视口导致纯黑截图）。

### `viewport_frame_actor`

- `id`：目标 Actor 名称或标签。
- `padding`：额外取景留白倍数，默认 `1.1`。
- `collision_aware`：可选，是否启用“室内取景防卡墙”，默认 `false`。
- `safety_offset_cm`：可选，启用防卡墙时使用的安全偏移（cm），默认 `15.0`。
- `trace_channel`：可选，防卡墙 Trace 通道名，默认 `Visibility`。
- `trace_complex`：可选，防卡墙是否使用复杂碰撞，默认 `false`。
- `look_at`：可选，是否把相机朝向自动对准 bounds center，默认 `false`。
- `auto_fallback`：可选，防卡墙增强：自动尝试多个候选相机位，默认 `false`。
- `fallback_step_cm`：可选，`auto_fallback=true` 时的偏移步长（cm），默认 `200`。
- `fallback_offsets_cm`：可选，自定义候选偏移（世界坐标 cm 向量数组）；当提供时，`auto_fallback` 的默认候选不会自动生成。

行为说明：

- 使用目标 Actor 的有效 bounds。
- 默认只重新计算并写入相机 `location`；若 `look_at=true` 会同步修改 `rotation`（`roll=0`）。
- 返回 `desired_location`（基准理想位）与 `new_location`（实际写入），并附带 `rotation/fov`。
- 当 `collision_aware=true` 时，会从目标 bounds center 向候选相机位做 Trace：
  - 未命中遮挡：直接使用候选位。
  - 命中遮挡：把相机放到命中点沿“Trace 方向反向”回退 `safety_offset_cm` 的位置，避免穿墙/卡墙。
  - 若 `auto_fallback=true` 或提供 `fallback_offsets_cm`，会在多候选中选择“距离目标更远且无遮挡/可修正”的相机位，并返回 `fallback_used/fallback_index/fallback_offset_cm`。
- 仅支持透视视口；若当前有效视口不是透视视口，会返回错误。

### `viewport_focus_actor_safe`

用于白盒验收的“更稳聚焦”：

- 内部走 `viewport_frame_actor` 的逻辑（而不是 `FocusViewportOnBox`）
- 默认开启：
  - `collision_aware=true`（防卡墙）
  - `look_at=true`（自动朝向目标）
  - `auto_fallback=true`（多候选取景点）

### `viewport_pick_actor_at_screen`

- `screen_x` / `screen_y`：屏幕像素坐标。
- `trace_distance`：可选，Trace 最大距离，默认 `100000.0`。
- `trace_channel`：可选，碰撞通道名，默认 `Visibility`。
- `trace_complex`：可选，是否使用复杂碰撞，默认 `true`。
- `ignore_actor_ids`：可选，忽略的 Actor 名称或 Label 列表（用于避开遮挡物）。
- `allow_no_hit`：可选，默认 `false`；为 `true` 时未命中也返回成功并给出 `hit=false`。

行为说明：

- 先把屏幕点反投影成世界射线，再做一次直线 Trace。
- 成功时会返回命中 Actor 摘要、Component 名称与路径，以及命中位置、法线、距离等信息。
- 未命中 Actor 时：
  - `allow_no_hit=false`：返回错误 `actor_not_hit`。
  - `allow_no_hit=true`：返回成功，`hit=false`，且不修改任何编辑器状态。

### `viewport_select_actor_at_screen`

- `screen_x` / `screen_y`：屏幕像素坐标。
- `selection_mode`：可选，`replace / add / remove`，默认 `replace`。
- 其它 Trace 参数与 `viewport_pick_actor_at_screen` 相同。

行为说明：

- 会先从屏幕点拾取 Actor。
- 成功后按 `selection_mode` 更新编辑器当前选择集。
- 返回命中 Actor 摘要、完整 `actor_info`、命中信息，以及更新后的选择集。
- 若 `allow_no_hit=true` 且未命中，则不会修改选择集，只返回当前选择集（同时 `hit=false`）。

### `level_get_nearby_actor_obbs`

- `radius`：球形查询范围半径。
- 查询中心二选一：
  - `id`：中心 Actor 名称或标签（以该 Actor 的 bounds center 作为球心；若 bounds 无效则退回 Actor location）。
  - `center`：显式指定世界坐标球心（此模式下 `include_self` 无意义，会被忽略）。
- `include_self`：可选，仅 `id` 模式有效；是否包含中心 Actor，默认 `false`。
- 可选过滤参数（减少噪声，建议白盒流程默认填）：
  - `folder_path_prefix` / `accept_folder_path_prefix`：仅返回该 folder 前缀下 Actor
  - `ignore_folder_path_prefix`：忽略该 folder 前缀下 Actor
  - `accept_tags[]` / `ignore_tags[]`
  - `accept_class_substrings[]` / `ignore_class_substrings[]`：对 `Class->GetPathName()` 做包含匹配
  - `limit`：最多返回数量（0 表示不限制）

行为说明：

- OBB 基于 Actor 局部轴（`axis_x/axis_y/axis_z`），支持 **非均匀缩放 + 旋转** 的白盒几何（例如斜坡/倾斜平台）。
- 返回范围内 Actor 列表，每项都包含：
  - `actor`
  - `distance`
  - `obb.center`
  - `obb.axis_x / axis_y / axis_z`
  - `obb.half_lengths`
  - `obb.corners`

### `navmesh_build`

- `wait_for_finish`：可选，是否等待构建结束，默认 `false`。
- `timeout_seconds`：可选，仅在 `wait_for_finish=true` 时生效，默认 `10.0`。

行为说明：

- 在 Editor World 触发 `UNavigationSystemV1::Build()`。
- 需要关卡内存在有效 `NavMeshBoundsVolume` 才会生成可查询 Nav 数据；否则可能返回成功但 `navmesh_find_path` 仍无法投影/查路。
- `wait_for_finish=true` 会最多等待 `timeout_seconds`，并返回 `build_in_progress` 供调用方决定是否重试。

### `navmesh_project_point`

- `point`：必填，世界坐标点（也兼容字段名 `location`）。
- `project_query_extent`：可选，投影查询盒体半尺寸（cm），默认 `50,50,200`；也兼容字段名 `project_query_extent_cm`。

行为说明：

- 在 Editor World 调用 `UNavigationSystemV1::ProjectPointToNavigation`。
- 返回 `projected=true/false`：
  - `true`：附带 `projected_point`。
  - `false`：只表示“在给定 extent 下无法投影到 NavMesh”，不是硬错误（便于脚本在查路前做诊断）。
- 典型用途：当你怀疑 `navmesh_find_path(project_to_nav=true)` 把点投影到楼梯台阶/上层平台时，用此命令先把“投影落点”结构化输出，避免误判。

### `navmesh_find_path`

- `start` / `end`：必填，世界坐标。
- `allow_partial`：可选，是否接受 partial path，默认 `false`。
- `project_to_nav`：可选，是否把输入点投影到 Nav 上，默认 `true`。
- `project_query_extent`：可选，投影查询盒体半尺寸（cm），默认 `50,50,200`。
- `allow_projection_failure`：可选，默认 `false`；为 `true` 时，投影失败不作为硬错误，而是返回 `path_found=false` 并附带投影信息（用于诊断“点不在 Nav 上/投影不到”）。

行为说明：

- 返回 `path_found`、`is_partial`、`path_length_cm`、`path_points[]`，并返回：
  - `start_used/end_used`：实际用于查路的点（可能是投影点）
  - `start_projected_ok/end_projected_ok`、`*_projected_distance_cm`
  - `projection_failed_reason`（仅当 `allow_projection_failure=true` 且投影失败时）
- 注意：NavMesh/查路只覆盖“沿可行走面连续移动”的连通（walkable connectivity）。跳跃/电梯/滑索等连通需要额外建模为显式边（建议见 `Plugins/UeAgentInterface/docs/Proposed_WhiteboxValidation_Commands.md`）。

### `level_validate_connectivity`

对白盒常用的“按序/按对”连通性验收（基于 NavMesh），并支持把“跳跃/传送/梯子/设备”等 **非 walk 连接** 作为显式边纳入同一张图里做验收：

- 输入二选一：
  - `points[]`：世界坐标点列表（建议使用 **脚底点/落脚点**）
  - `probe_actor_ids[]`：探针 Actor（如 `TargetPoint`）的名称或 Label
- `pairs[]`：可选，显式指定需要验收的“边”；每项 `{from_index,to_index}`，并可选 `edge_type`：
  - `edge_type` 省略/空/`walk`：走 NavMesh 查路（旧行为）
  - `edge_type!=walk`：显式边 **只做端点校验**（投影/距离阈值），不查路、不验证设备语义；用于把 jump/teleport/ladder 等连接纳入“整体可达图”的验收
  - 不提供 `pairs[]` 时默认按序验收 `0->1,1->2,...`
- `project_to_nav`：可选，默认 `true`；会先把点投影到 Nav 上再查路。
- `project_query_extent`：可选，默认 `50,50,200`。
- `max_projection_distance_cm`：可选，默认 `-1`（不限制）。若设置为 `>=0`，当某点投影到 Nav 的距离超过该阈值时，会视为失败（用于避免“投影到了别的楼层/别的走道”导致的误判）。
- `allow_partial`：可选，默认 `false`。
- `stop_on_failure`：可选，默认 `false`；为 `true` 时遇到第一对失败就提前返回（更快）。
- `include_path_points`：可选，默认 `false`；为 `true` 时在 `walk_checked=true` 的 pair 内返回 `path_points`（最多 `max_path_points`，并返回 `path_points_truncated`）。
- `graph_root_index`：可选，默认 `0`；基于通过的边构建有向图并返回 `graph`（可达性 + SCC，用于验收“回环/返回路径”）。

返回：

- `all_connected`：是否全部 pairs 都通过（walk 边=查路成功；显式边=端点校验通过）
- `pairs_truncated/first_failure_pair_index/first_failure_reason`：当 `stop_on_failure=true` 时用于定位第一处失败
- `nodes[]`：节点来源（点或 actor 摘要）
- `pairs[]`：逐对结果（包含投影落点、`*_projected_distance_cm`、`*_projection_within_limit`、`edge_type`、`walk_checked`、path_found、failure_reason、path_length_cm 等）
- `graph`：图验收摘要（`reachable_indices/unreachable_indices/sccs/has_cycle`）

### `level_trace_world_ray`

- `start`：必填，射线起点。
- `direction`：必填，射线方向（会自动归一化）。
- `trace_distance`：可选，最大距离；也兼容 `distance` 字段。
- `trace_channel`：可选，默认 `Visibility`。
- `trace_complex`：可选，默认 `true`。
- `ignore_actor_ids`：可选，忽略的 Actor 名称/标签数组。
- `ignore_folder_path_prefix` / `ignore_tags[]` / `ignore_class_substrings[]`：可选，全局忽略过滤器（按 Outliner folder 前缀 / Tag / ClassPath 子串忽略）；主要用于白盒增量检查时“屏蔽噪声对象”（例如天空盒、装饰组、临时调试物）。
- `include_all_hits`：可选，默认 `false`；为 `true` 时会用 `LineTraceMulti` 并返回 `hits[]`（按 `distance` 排序，用于诊断“被谁遮挡/穿过了哪些对象”）。注意：`LineTraceMulti` 的返回通常只覆盖**起始重叠 + 到第一次阻挡命中为止**的 hit（不会穿过阻挡继续返回后面的碰撞）。
- `max_hits`：可选，默认 `32`；`include_all_hits=true` 时最多返回多少条命中。
- `include_actor_folder_tags`：可选，默认 `false`；为 `true` 时会在主命中补充 `hit_actor_folder_path/hit_actor_tags`，并在 `hits[]` 内补充 `actor.folder_path/tags`，便于快速定位挡路物。

批量模式（可选）：

- `rays[]`：对象数组；每项至少包含 `start/direction`，可选覆盖 `trace_distance/trace_channel/trace_complex/ignore_actor_ids`。
- 同样支持在单项里覆盖：`include_all_hits/max_hits/include_actor_folder_tags`。
- `max_items`：可选，最多处理条数；超出会截断并返回 `truncated=true`（默认 `4096`）。
- `continue_on_error`：可选，默认 `false`；为 `true` 时会把单项参数错误记录为 `ok=false + error`，不中断整批。

返回批量模式时：`mode=batch`，并返回 `rays[]`（每项含 `index/ok/error/hit/...`）以及 `hit_count/error_count/first_error_index` 等汇总字段。

行为说明：

- 不依赖 viewport，从任意世界点发起 LineTrace。
- 返回 `hit`、命中 `location/normal/distance`，以及 `actor_name/actor_id/component_*` 等。
- 当 `include_all_hits=true` 时，额外返回：
  - `hit_count`、`hits_truncated`、`hits[]`（每项包含 `blocking_hit/time/distance/location/normal` 与 actor/component 摘要）
  - `include_actor_folder_tags=true` 时还会补充 `hit_actor_folder_path/hit_actor_tags` 与 `hits[].actor.folder_path/tags`

### `level_snap_to_surface`

把某个 Actor 沿射线吸附到命中面（常用于修复：悬空、贴合差、门缝、电梯平台不贴合地面等）。

- `id`：必填，目标 Actor 名称或标签。
- 可选：
  - `start`：射线起点（默认用 Actor 当前 location）
  - `direction`：射线方向（默认 `0,0,-1`）
  - `trace_distance`：默认 `100000`
  - `trace_channel`：默认 `Visibility`
  - `trace_complex`：默认 `true`
  - `ignore_actor_ids[]`：忽略的 Actor 名称/标签数组
  - `offset_cm`：命中点偏移（cm）
  - `offset_mode`：`normal/direction`（默认 `normal`）
  - `align_rotation`：是否按命中法线对齐 Actor 旋转（默认 `false`，白盒通常只吸附位置即可）

返回：`snapped=true/false`，以及命中信息、`previous_location/rotation`、`new_location/rotation`。

### `level_sweep_capsule`

- `start` / `end`：必填，Sweep 起点/终点。
- `radius_cm` / `half_height_cm`：必填，胶囊尺寸（cm）。
- `trace_channel`：可选，默认 `Pawn`。
- `trace_complex`：可选，默认 `false`。
- `find_initial_overlaps`：可选，默认 `true`。
- `ignore_actor_ids`：可选，忽略的 Actor 名称/标签数组。
- `ignore_folder_path_prefix` / `ignore_tags[]` / `ignore_class_substrings[]`：可选，全局忽略过滤器（按 Outliner folder 前缀 / Tag / ClassPath 子串忽略），用于减少噪声与误报。
- `include_all_hits`：可选，默认 `false`；为 `true` 时会用 `SweepMulti` 并返回 `hits[]`（按 `time` 排序，便于诊断“到底撞到了哪些东西”）。注意：`SweepMulti` 的返回通常只覆盖**起始重叠 + 到第一次阻挡命中为止**的 hit（不会“穿过阻挡”继续返回后续碰撞）。
- `max_hits`：可选，默认 `32`；`include_all_hits=true` 时最多返回多少条命中（防止 JSON 过大）。
- `include_actor_folder_tags`：可选，默认 `false`；为 `true` 时会在主命中与 `hits[]` 里补充 `hit_actor_folder_path/hit_actor_tags`（以及 `hits[].actor.folder_path/tags`），用于快速定位“是谁挡住了路”。
- `return_penetration_depth`：可选，默认 `false`；为 `true` 且 `start_penetrating=true` 时返回 `penetration_depth_cm`（用于判断“卡进去多深”）。

批量模式（可选）：

- `sweeps[]`：对象数组；每项至少包含 `start/end`，可选覆盖 `radius_cm/half_height_cm/trace_channel/trace_complex/find_initial_overlaps/ignore_actor_ids`。
  - 若单项未填写 `radius_cm/half_height_cm`，会回退使用顶层同名字段作为默认值。
- 同样支持在单项里覆盖：`include_all_hits/max_hits/include_actor_folder_tags/return_penetration_depth`。
- `stop_on_blocking_hit`：可选，默认 `false`；遇到第一段 `blocking_hit=true` 则提前停止并返回 `truncated=true`。
- `max_items`：可选，最多处理条数；超出会截断并返回 `truncated=true`（默认 `4096`）。
- `continue_on_error`：可选，默认 `false`；为 `true` 时会把单项参数错误记录为 `ok=false + error`，不中断整批。

返回批量模式时：`mode=batch`，并返回 `sweeps[]`（每项含 `index/ok/error/blocking_hit/...`）以及 `blocking_hit_count/first_blocking_index/error_count` 等汇总字段。

行为说明：

- 用胶囊做 Sweep 通行性检测（门洞太低、走廊太窄、电梯轨迹被挡等）。
- 返回 `blocking_hit`、`start_penetrating`，以及命中信息字段（同 Trace）。
- 实战建议：做“净空/通行”验证时，`start/end.z` 建议在地面上方留一点余量（例如 `+5cm`），或设 `find_initial_overlaps=false`，避免“刚好贴地”触发 `start_penetrating` 的误判。
- 当 `start_penetrating=true` 时，会额外返回 `start_penetrating_advice`（包含结构化建议：抬高 Z / 关闭 `find_initial_overlaps` 等）。
- 若需要更强的可解释性（例如生成“阻挡原因报告”），可开 `include_all_hits=true` 并结合 `include_actor_folder_tags=true`。

### `level_sweep_capsule_path`

- `points`：必填，至少 2 个点；每点为 `{"x","y","z"}`。默认语义为 **脚底点（落脚点）**。
- `points_mode`：可选，`feet/center`，默认 `feet`。
  - `feet`：`points[]` 视为脚底点；若 `snap_to_floor=true` 会先向下 Trace 修正到落脚面，再转换为胶囊中心点路径做 Sweep。
  - `center`：`points[]` 直接视为胶囊中心点路径（高级用法）。
- `radius_cm` / `half_height_cm`：必填，胶囊尺寸（cm）。
- `step_cm`：可选，采样步长（cm），默认 `50`。
- `max_samples`：可选，最大采样点数量，默认 `2048`（超出会截断并返回 `truncated=true`）。
- `trace_channel`：可选，默认 `Pawn`。
- `trace_complex`：可选，默认 `false`。
- `find_initial_overlaps`：可选，默认 `true`。
- `return_penetration_depth`：可选，默认 `false`；为 `true` 且 `start_penetrating=true` 时返回 `first_penetration_depth_cm`（以及 `segments[].penetration_depth_cm`）。
- `include_actor_folder_tags`：可选，默认 `false`；为 `true` 时在首个阻挡命中返回 `hit_actor_folder_path/hit_actor_tags`，并在 `segments[]` 的阻挡段同样补充，便于定位“哪个对象挡住了”。
- `ignore_actor_ids`：可选，忽略的 Actor 名称/标签数组。
- `ignore_folder_path_prefix` / `ignore_tags[]` / `ignore_class_substrings[]`：可选，全局忽略过滤器（按 Outliner folder 前缀 / Tag / ClassPath 子串忽略）。

贴地与擦地误报相关参数（主要对 `points_mode=feet` 有意义）：

- `snap_to_floor`：可选，默认 `true`（仅 `feet` 模式默认开启）；把脚底点向下 Trace 到真实落脚面。
- `require_floor`：可选，默认 `true`（当 `feet + snap_to_floor`）；若某个采样点找不到落脚面，会返回 `path_valid=false`、`floor_missing=true` 并早停。
- `floor_trace_up_cm` / `floor_trace_down_cm`：可选，默认 `50/200`；控制落脚面 Trace 的上下范围（建议保持较小，避免吸到别的楼层）。
- `floor_trace_channel`：可选，默认 `Visibility`。
- `floor_trace_complex`：可选，默认 `true`。
- `floor_clearance_cm`：可选，默认 `2`；把胶囊中心点抬离地面一点，减少 `start_penetrating` 误报。
- `ignore_walkable_floor_hits`：可选，默认 `false`；忽略“像可行走地面”的命中（需配合 `snap_to_floor` 才可靠）。
- `max_walkable_slope_deg`：可选，默认 `45`；用于判断命中法线是否可行走。

调试输出控制：

- `stop_on_blocking_hit`：可选，默认 `true`；遇到第一个阻挡就停止（更快）。
- `include_samples`：可选，返回采样点（input/feet/center + floor hit 信息）。
- `include_segments`：可选，返回每段 sweep 的命中与过滤统计（调试用，数据量更大）。

行为说明：

- 适合做“走廊/楼梯/电梯路径净空”的自动验收：把“中途被挡”变成可定位的 `segment_index` + 命中信息。
- 由于 `points_mode=feet` 更易生成（可从 OBB 顶面点派生），但必须明确“脚底→胶囊中心”的转换策略，否则会出现大量擦地误报；因此建议默认开启 `snap_to_floor + floor_clearance_cm`。
- 当阻挡段 `start_penetrating=true` 时，会在对应 `segments[]`（以及顶层首个阻挡信息）返回 `start_penetrating_advice`，提示如何降低擦地/初始重叠的误报。

### `level_check_overlaps`

- `shape`：必填，`box/sphere/capsule`。
- `center`：必填，世界坐标中心点。
- `box_extent`：当 `shape=box` 必填。
- `radius_cm`：当 `shape=sphere/capsule` 必填。
- `half_height_cm`：当 `shape=capsule` 必填。
- `rotation`：可选（box/capsule），默认 `0,0,0`。
- `trace_channel`：可选，默认 `Visibility`。
- `trace_complex`：可选，默认 `false`。
- `limit`：可选，最多返回 overlap 条数，默认 `100`。
- `include_overlaps`：可选，默认 `true`；为 `false` 或 `limit=0` 时只返回 `overlap_count`（不回传 `overlaps[]`，避免 JSON 太大）。
- `include_actor_folder_tags`：可选，默认 `false`；为 `true` 时会在 `overlaps[].actor` 补充 `folder_path/tags`。
- `ignore_actor_ids`：可选，忽略的 Actor 名称/标签数组。
- `ignore_folder_path_prefix` / `ignore_tags[]` / `ignore_class_substrings[]`：可选，全局忽略过滤器（按 Outliner folder 前缀 / Tag / ClassPath 子串忽略）。

批量模式（可选）：

- `checks[]`：对象数组；每项至少包含 `shape/center`，并按 shape 补齐所需字段；可选覆盖 `trace_channel/trace_complex/limit/ignore_actor_ids`。
- 同样支持在单项里覆盖：`include_overlaps/include_actor_folder_tags`。
- `stop_on_overlap`：可选，默认 `false`；遇到第一项 `overlap_count>0` 则提前停止并返回 `truncated=true`。
- `max_items`：可选，最多处理条数；超出会截断并返回 `truncated=true`（默认 `4096`）。
- `continue_on_error`：可选，默认 `false`；为 `true` 时会把单项参数错误记录为 `ok=false + error`，不中断整批。

返回批量模式时：`mode=batch`，并返回 `checks[]`（每项含 `index/ok/error/overlap_count/...`）以及 `total_overlap_count/first_overlapping_index/error_count` 等汇总字段。

行为说明：

- 返回 `overlap_count` 与 `overlaps[]`（每项包含 actor 摘要与 component 信息）。
- 用于发现摆放穿插、互相卡住、门洞/墙体不贴合等问题。

### `editor_list_dirty_resources`

- 无参数。

行为说明：

- 返回当前编辑器里所有待处理的脏包资源。
- 资源类型统一抽象为 `resource`，可能是：
  - 当前关卡
  - 其它关卡
  - 普通资产
- 返回项包含 `resource_path`、`object_path`、`kind`、`is_current_level`、`is_open_in_editor` 等字段。

### `asset_import_texture`

- `source_filename`：必填，外部贴图文件绝对路径或项目相对路径；当前显式允许 `png/jpg/jpeg/tga/bmp/exr/hdr/dds/psd/tif/tiff`，最终还会调用 UE `TextureFactory::FactoryCanImport` 做二次判断。
- `destination_path`：必填，目标内容目录（如 `/Game/VFX/Textures`）。
- `destination_name`：可选，目标资产名；若使用的 UE 导入管线忽略该字段，仍以源文件名为准，因此推荐把源文件也命名成目标资产名。
- `replace_existing`：可选，默认 `true`。
- `replace_existing_settings`：可选，默认 `true`。
- `save_after_import`：可选，默认 `true`。
- `open_editor`：可选，默认 `false`。
- `srgb`：可选，布尔值；用于颜色贴图时通常为 `true`，遮罩/数据贴图通常为 `false`。
- `compression_settings`：可选，UE 枚举名或数值，如 `TC_Default`、`TC_EditorIcon`。
- `mip_gen_settings`：可选，UE 枚举名或数值，如 `TMGS_FromTextureGroup`、`TMGS_NoMipmaps`。
- `lod_group`：可选，UE 枚举名或数值，如 `TEXTUREGROUP_Effects`、`TEXTUREGROUP_UI`。
- `no_compression` / `no_alpha` / `defer_compression` / `create_material`：可选，透传给 `UTextureFactory` 的导入选项。

返回字段：

- `texture_asset_path`、`texture_object_path`
- `texture_size_x`、`texture_size_y`、`texture_num_mips`
- `texture_has_alpha`
- `srgb`、`compression_settings`、`mip_gen_settings`、`lod_group`
- `texture_asset_paths[]`、`texture_object_paths[]`
- 通用导入字段：`imported_object_count`、`imported_objects[]`、`primary_asset_path` 等。

行为说明：

- 该命令只负责把外部贴图正式导入为 UE Texture2D，并在导入后回读关键属性；材质图、Niagara Renderer、SubUV 行列数等仍走对应资产的 JSON / folder workflow。
- 枚举字段解析失败、布尔字段类型错误、扩展名不支持、UE 工厂拒绝导入都会返回硬错误，不会静默忽略。

### `asset_import_fbx_skeletal_mesh`

- `source_filename`：必填，外部 FBX 文件绝对路径。
- `destination_path`：必填，目标内容路径（如 `/Game/Characters/Paladin/Mesh`）。
- `skeleton_path`：可选，已有 Skeleton；不填时按 FBX 内容导入新 Skeleton。
- `destination_name`：可选；当前导入管线会记录该字段，但 FBX factory 仍可能按源文件或内部对象名生成资产名，导入后以 `primary_asset_path / skeletal_mesh_asset_path / skeletal_mesh_asset_paths[]` 为准。
- `replace_existing` / `replace_existing_settings`：可选，默认 `true`。测试导入时建议使用独立目标目录，避免误覆盖业务资产。
- `save_after_import`：可选，默认 `true`。
- `open_editor`：可选，默认 `false`。
- `import_materials` / `import_textures`：可选，默认 `false`。
- `create_physics_asset`：可选，默认 `false`。
- `import_animations`：可选，默认 `false`。
- `import_morph_targets`：可选，导入 FBX Morph Target。
- `import_skin_weight_profiles`：可选；主 FBX 导入不会隐式导入 Skin Weight Profile，会在 `validation_issues[]` 和 `validation_report` 中提示使用 `skeletal_mesh_import_skin_weight_profile`。
- `update_skeleton_reference_pose`：可选，默认 `false`。
- `preserve_existing_morph_targets`：可选，默认 `true`；当前新导入路径只返回兼容 warning，reimport 保留 Morph Target 需要单独 reimport 能力。
- `validate_after_import`：可选，默认 `true`。启用时读回 LOD、Morph、材质槽和 Skin Weight Profile 摘要。
- `expected_morph_targets[]` / `expected_material_slots[]` / `expected_lod_count`：可选，用于导入后硬校验。

行为说明：

- 通过 FBX 工厂自动导入 Skeletal Mesh。
- 返回 `imported_object_paths`，并按类型拆出 `skeletal_mesh_asset_paths / skeleton_asset_paths / physics_asset_paths`；`primary_asset_path` 是本次导入的代表资产。
- 返回角色变形相关字段：`skeletal_mesh_asset_path`、`morph_targets_imported[]`、`skin_weight_profiles_imported[]`、`lod_count`、`material_slot_count`、`section_count`、`morph_target_count`、`skin_weight_profile_count`、`validation_issues[]`、`validation_error_count`、`validation_passed`、`validation_report`。
- 如果 `validate_after_import=true` 且 `expected_morph_targets[]` 中任何名称未导入，命令返回失败，错误为 `fbx_skeletal_mesh_import_validation_failed`，不会把“导入了 mesh 但没有 Morph Target”伪装成成功。
- 如果源文件不是 `.fbx`，返回 `source_file_is_not_fbx`；文件不存在返回 `source_file_not_found`；`destination_path` 不是合法 `/Game/...` 包路径时返回 `invalid_destination_path`。
- 适合先导入角色网格，再把动作批量导入到同一 Skeleton。

Morph Target 推荐验证顺序：

```json
{
  "source_filename": "D:/Temp/MorphSource.fbx",
  "destination_path": "/Game/__UeAgentInterfaceSmoke/MorphImport",
  "import_morph_targets": true,
  "validate_after_import": true,
  "expected_morph_targets": ["Smile"],
  "save_after_import": false,
  "open_editor": false
}
```

第一步用上面的参数执行：

```powershell
UeAgentInterfaceCMD/dist/uai-cli.exe exec --cmd asset_import_fbx_skeletal_mesh --params-file tmp/morph_import.json --json-output
```

然后读取 report 里的 `data.skeletal_mesh_asset_path`，把真实资产路径写入后续只读验证参数：

```json
{
  "asset_path": "/Game/__UeAgentInterfaceSmoke/MorphImport/MorphSource"
}
```

依次执行：

```powershell
UeAgentInterfaceCMD/dist/uai-cli.exe exec --cmd skeletal_mesh_get_morph_targets --params-file tmp/morph_get.json --json-output
UeAgentInterfaceCMD/dist/uai-cli.exe exec --cmd skeletal_mesh_validate_morph_targets --params-file tmp/morph_get.json --json-output
```

预览校验需要补目标名和权重：

```json
{
  "asset_path": "/Game/__UeAgentInterfaceSmoke/MorphImport/MorphSource",
  "morph_target": "Smile",
  "weight": 1.0
}
```

```powershell
UeAgentInterfaceCMD/dist/uai-cli.exe exec --cmd skeletal_mesh_preview_morph_target --params-file tmp/morph_preview.json --json-output
```

测试资产不需要保留时，优先使用 `save_after_import=false`，验证结束后通过 dirty resource 流程丢弃未保存导入包；若已保存到 Content，应显式清理测试目录，不要把 `/Game/__UeAgentInterfaceSmoke` 留在项目里。

### `asset_import_fbx_animation`

- `source_filename`：必填，外部 FBX 文件绝对路径。
- `destination_path`：必填，目标内容路径（如 `/Game/Characters/Paladin/Animations`）。
- `skeleton_path` / `skeletal_mesh_path`：二选一必填。
  - 若只给 `skeletal_mesh_path`，命令会自动解析其绑定 Skeleton。
- `replace_existing` / `replace_existing_settings`：可选，默认 `false`。
- `save_after_import`：可选，默认 `true`。
- `open_editor`：可选，默认 `false`。

行为说明：

- 导入结果是 `AnimSequence` 资产。
- 返回 `skeleton_path` 与 `imported_animation_paths`，便于后续直接接 `AnimBlueprint` / Montage / 结构化动画工作流。

### `asset_import_geometry_cache`

- `source_file`：必填，外部 Geometry Cache / Alembic 文件路径。相对路径按项目根目录解析。
- `destination_path`：必填，目标内容路径（如 `/Game/Deformers/GeometryCache`）。

行为说明：

- 通过 UE 自动导入管线导入缓存资产。
- 返回 `imported_assets[]`、`imported_asset_count` 和 `plugin_status`。
- Geometry Cache 内部逐帧顶点数据不通过 JSON 编辑；导入后使用 `geometry_cache_get_info` 与 `geometry_cache_validate_against_skeletal_mesh` 做验证。详见 `18_Deformer_MLDeformer_GeometryCache.md`。

### `asset_export_property_json`

- 这是当前“小型浅层资产”的主工作流；能被 `properties[]` 表达的逐条纯属性 setter 已迁移到对应 `deprecatedCommand` 分册。
- 对字段较多、但仍适合单文件 JSON 的资产，推荐先最小创建，再导出属性 JSON，当作真实模板继续补全。

- `asset_path`：必填，目标资产路径。
- `property_names[]`：可选；不填时会按资产类型使用内建默认预设。
- `output_file`：可选；若提供，会把完整 JSON 直接写到该路径。

当前默认预设：

- `AnimSequence`
  - `RateScale`
  - `bEnableRootMotion`
  - `bForceRootLock`
  - `RootMotionRootLock`
  - `Interpolation`
- `Texture`
  - `SRGB`
  - `CompressionSettings`
  - `MipGenSettings`
  - `LODGroup`
  - `NeverStream`
  - `VirtualTextureStreaming`
  - `Filter`
- `StaticMesh`
  - `LightMapResolution`
  - `LightMapCoordinateIndex`
  - `LODGroup`
  - `bAllowCPUAccess`
- `SkeletalMesh`
  - `bEnablePerPolyCollision`
  - `LODSettings`
  - `DefaultAnimatingRig`

行为说明：

- 返回的 JSON 结构固定包含：
  - `format_version`
  - `asset_path`
  - `object_path`
  - `asset_class`
  - `property_preset`
  - `properties[]`
- `properties[]` 每项包含：
  - `property_name`
  - `value_text`
  - `cpp_type`
  - `value_json` / `curve_json`：当属性是 `FRuntimeFloatCurve`、`FRuntimeVectorCurve`、`FRuntimeCurveLinearColor`、`FCurveTableRowHandle` 或曲线资产引用时返回。
- 如果某个默认属性在当前资产上不存在，会落到 `missing_properties[]`，不会中断整条导出。

### `asset_apply_property_json`

- 这是与 `asset_export_property_json` 成对的主回写入口。
- 推荐流程是：导出 JSON -> 修改 `value_text` -> 回写，而不是长链路反复调用原子属性命令。
- 推荐方法论：
  - 先创建或导入最小可用资产
  - 再 `export_property_json`
  - 再在导出结果上补高价值字段
  - 再 `apply_property_json`

- `asset_path`：可选；若不填，可从 `json_file` 内的 `asset_path` 读取。
- `json_file`：可选；指向 `asset_export_property_json` 导出的 JSON 文件。
- `properties[]`：可选；不走文件时可直接内联属性数组。
- `save_after_apply`：可选，默认 `false`。

行为说明：

- `json_file` 和 `properties[]` 至少要提供一种。
- `properties[]` 每项格式：
  - `property_name`
  - `value_text`
  - `curve_json` 或 `value_json`：可选；存在时优先按结构化曲线 JSON 写入，不再要求 `value_text`。两者同时存在时，以更明确的 `curve_json` 为准，`value_json` 只作为兼容旧导出的别名。
- 返回包含 `property_results[]`。每个结果会记录 `requested_value_text`、`applied_value_text`、`property_import_status`、`property_import_verified`、`value_text_exact_match`、`value_text_changed_after_import`、`cpp_type`。
- 如果 `properties[]` 条目有 JSON 结构问题，例如数组元素不是 object、字段拼写错误、`property_name/value_text` 缺失或类型不对，对应结果会带 `json_issues[]`，每项包含 `severity/code/path/message`。
- 曲线结构化 JSON 写入失败时，失败项会返回 `property_import_status=curve_json_apply_failed` 和 `json_issues[]`；未知字段、字段拼写相近、缺 key 值、重复 key 时间、非法插值/外推模式都会显式返回。
- 曲线属性写入会先在临时曲线上完整解析；失败时不会改写目标曲线，也不会把目标资产标脏。多通道曲线任一 channel 失败时，已解析成功的其它 channel 也不会被部分写入。
- 如果某项 `ImportText` 解析失败，命令失败，`property_results[]` 会保留已处理项和失败项，失败项的 `property_import_status=import_failed`，错误字符串会包含 `property_name` 和请求值。
- 如果 `properties[]` 中某项不是 JSON object，命令失败，`property_results[]` 会包含 `property_import_status=invalid_property_entry` 和 `json_issues[]`，避免坏条目被静默跳过。
- 当前会复用对象子属性路径解析，因此像 `CharacterMovement.*` 这类对象链属性也能沿同一套机制继续扩展到资产侧。
- 这条命令适合做“导出 JSON -> 手工或脚本改 `value_text` -> 回写资产”的轻量结构化工作流，不等于完整 folder profile。

### `curve_export_json`

- `asset_path`：必填，支持 `/Game/...` 或对象路径。
- `output_file`：可选。相对路径按项目根目录解析，返回绝对路径。

当前覆盖：

- `UCurveFloat`
- `UCurveVector`
- `UCurveLinearColor`
- `UCurveTable`，支持 rich/simple row 的导出。

返回结构固定包含：

- `schema=ue_agent_interface.curve.v1`
- `curve_kind`
- `storage`
- `carrier_cpp_type`
- `time_domain`
- `channels`
- `keys[]`
- `asset_path / object_path / asset_class`

### `curve_apply_json`

- `asset_path`：必填。
- `curve`：可选，内联曲线 JSON。
- `json_file`：可选，读取单文件曲线 JSON；若文件内有顶层 `curve` 对象，会优先使用该对象。
- `create_if_missing`：可选，默认 `false`。为 `true` 时按 `curve_kind` 创建缺失曲线资产。
- `curve_kind`：创建时必需或从曲线 JSON 读取；支持 `float`、`vector`、`linear_color`、`curve_table`。
- `save_after_apply`：可选，默认 `false`。
- `output_file`：可选，保存 apply 后的 readback JSON；相对路径按项目根目录解析。

诊断与回读：

- 成功返回 `curve_read_back` 和 `json_issues[]`。
- 失败返回 `curve_json_apply_failed`，并在 `data.json_issues[]` 中给出完整路径。
- 未知字段会返回 `json_unknown_field`，并尽量给出“Did you mean”提示。
- key 缺 `value`、重复时间、非法 `interp_mode/tangent_mode/tangent_weight_mode/pre_infinity_extrap/post_infinity_extrap` 都会失败。
- 失败 apply 不会把目标资产标脏；Vector / LinearColor / CurveTable 等多通道或多行曲线采用临时对象整体验证，避免部分 channel/row 先写入。

最小示例：

```json
{
  "asset_path": "/Game/Curves/C_Test",
  "create_if_missing": true,
  "curve_kind": "float",
  "save_after_apply": true,
  "curve": {
    "schema": "ue_agent_interface.curve.v1",
    "curve_kind": "float",
    "storage": "curve_asset",
    "carrier_cpp_type": "UCurveFloat",
    "channels": {
      "value": {
        "keys": [
          { "time": 0.0, "value": 0.0, "interp_mode": "Linear" },
          { "time": 1.0, "value": 1.0, "interp_mode": "Cubic", "tangent_mode": "Auto" }
        ]
      }
    }
  }
}
```

### `editor_console_exec`

用途：执行 UE 编辑器底部状态栏 `Cmd` 输入框的等价控制台命令路径。该命令不模拟 Slate 输入框，而是在 UAI 服务端复刻 `FConsoleCommandExecutor` 的实际执行链：优先使用 PIE / Debug LocalPlayer，上下文存在时走 `GameMode/GameState.ProcessConsoleExec`，最后走 `GEditor->Exec` 或 `GEngine->Exec`。

关键参数：

- `command`：单条控制台命令。可以包含多行，服务端会按 UE `Cmd` executor 的行解析方式逐行执行。
- `commands[]`：多条控制台命令数组。`command` 和 `commands[]` 可以同时存在，执行顺序为 `command` 解析出的行，再接数组解析出的行。
- `world_context`：可选，`auto` / `editor` / `pie`，默认 `auto`。`auto` 尽量贴近状态栏 `Cmd` 行为：PIE 存在时优先 PIE，否则使用 Editor world。
- `allow_high_risk`：可选，默认 `false`。为 `false` 时会阻断退出、崩溃、任意 Python、地图切换、对象保存/导入、删除/销毁等高风险命令。
- `stop_on_error`：可选，默认 `true`。遇到阻断或未处理命令时是否停止后续命令。
- `fail_on_unhandled`：可选，默认 `true`。控制台命令返回未处理时是否让 UAI 命令失败。
- `add_to_history`：可选，默认 `true`。是否加入 UE 控制台历史。
- `max_output_chars`：可选，默认 `65536`，单条命令返回的合并输出字符上限，最大 `1048576`。
- `max_output_lines`：可选，默认 `128`，单条命令返回的结构化输出行数上限。

返回字段：

- `executor="Cmd"`：表示使用 UE 状态栏 `Cmd` executor 等价语义。
- `command_count`、`executed_count`、`handled_count`、`blocked_count`、`unhandled_count`：执行统计。
- `results[]`：每条命令的结果，包含 `command`、`handled`、`blocked`、`high_risk`、`high_risk_reason`、`route`、`world_context_used`、`output`、`output_lines[]`、`output_truncated`。
- 阻断高风险命令时返回失败 `editor_console_command_blocked_high_risk`；未处理且 `fail_on_unhandled=true` 时返回失败 `editor_console_command_unhandled` 或更具体的失败原因。

示例：

```json
{
  "command": "editor_console_exec",
  "params": {
    "command": "r.ViewDistanceScale",
    "max_output_chars": 4096
  }
}
```

```json
{
  "command": "editor_console_exec",
  "params": {
    "commands": [
      "stat fps",
      "viewmode shadercomplexity"
    ],
    "world_context": "editor"
  }
}
```

注意：`editor_console_exec` 是兜底/调试入口，不应替代已有结构化 UAI 指令。凡是 UAI 已有明确读写命令的资产、关卡、视口、编译、截图、配置和生命周期操作，仍优先使用结构化指令，以获得更稳定的读回和错误语义。

### `editor_resolve_dirty_resources`

- `save_resource_paths` / `discard_resource_paths`：资源路径数组。
- 兼容旧字段：`save_asset_paths` / `discard_asset_paths`。
- 兼容别名：`save_resources` / `discard_resources`
- `save_current_level` / `discard_current_level`
- `save_all_dirty` / `discard_all_dirty`
- 兼容别名：`save_all` / `discard_all`
- `close_all_asset_editors`
- `only_save_dirty`

行为说明：

- 只处理脏资源，不会直接关闭编辑器。
- 返回处理前后 `dirty_resources_before / dirty_resources_after`。
- 若还有未处理的脏资源，会通过 `remaining_dirty_resource_count` 显式告诉调用方。

### `editor_close`

- `request_exit`：是否真正请求关闭编辑器，默认 `true`。
- `close_all_asset_editors`：关闭前是否先关闭资产编辑器，默认 `true`。

行为说明：

- 该命令不会替调用方做保存/丢弃判断。
- 若仍存在未处理脏资源，会返回失败 `editor_has_unresolved_dirty_resources`，并在 `data.dirty_resources` 中给出完整清单。
- 只有当脏资源全部处理完后，才会允许关闭编辑器。

## Landscape

| 指令 | 作用 | 关键参数 | 典型用途 |
|---|---|---|---|
| `landscape_create` | 在当前关卡创建 Landscape | `location`、`scale`、`quads_per_section`、`sections_per_component`、`component_count_x`、`component_count_y` | 初始化测试地形 |
| `landscape_raise_circle` | 抬高圆形区域 | `center`、`radius_cm`、`strength_cm`、`falloff` | 快速做起伏地形 |

## 最小请求示例

```json
{
  "request_id": "level-001",
  "command": "level_get_actor_transform",
  "params": {
    "id": "MyActor"
  }
}
```
