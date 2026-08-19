# 废弃指令：Montage

> 本文件从 `../12_Montage.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## 资产与基础信息

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `montage_set_preview_mesh` | **Deprecated for authoring**：设置或清空预览 SkeletalMesh | `asset_path`、`skeletal_mesh_path` 或 `clear_preview_mesh`、`save_after_set` | 优先写 JSON |
| `montage_set_blend_options` | **Deprecated for authoring**：设置 Blend 和 AutoBlendOut | `asset_path`、可选 `blend_in_time`、`blend_out_time`、`blend_out_trigger_time`、`enable_auto_blend_out`、`blend_mode_in/out`、`save_after_set` | 优先写 `settings` |
| `montage_set_sync_group` | **Deprecated for authoring**：设置或清空 Marker Sync 的 Group/Slot | `asset_path`、可选 `sync_group_name`、`sync_slot_name` 或 `sync_slot_index`、`save_after_set` | 优先写 `sync` |
| `montage_set_skeleton_slot_group` | **Deprecated for Montage authoring**：注册 Slot 并设置到指定 Group | `slot_name`、`group_name`、`skeleton_path` 或 `asset_path`、`save_skeleton` | Montage JSON 中优先写 `skeleton_slots` |
| `montage_rename_skeleton_slot` | **Deprecated for Montage authoring**：重命名 Skeleton slot | `slot_name`、`new_slot_name`、`skeleton_path` 或 `asset_path`、`save_skeleton` | Montage JSON 中优先写 `skeleton_slots` |
| `montage_remove_skeleton_slot` | **Deprecated for Montage authoring**：从 Skeleton 删除 slot | `slot_name`、`skeleton_path` 或 `asset_path`、`save_skeleton` | Montage JSON 中优先写 `skeleton_slots` |

## Notify / Branching Point

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `montage_add_notify_track` | **Deprecated for authoring**：新增或更新 Notify Track | `asset_path`、`track_name`；可选 `track_color`、`save_after_add` |
| `montage_remove_notify_track` | **Deprecated for authoring**：删除空 Notify Track | `asset_path`、`track_name`、`save_after_remove` |
| `montage_add_notify` | **Deprecated for authoring**：新增普通 Notify 或命名 Notify | `asset_path`、`time_seconds`，以及 `notify_name` 或 `notify_class`；可选 `track_name`、`tick_type/branching_point`、`notify_color`、`trigger_weight_threshold`、`notify_trigger_chance`、`notify_filter_type`、`notify_filter_lod`、`can_be_filtered_via_request`、`trigger_on_dedicated_server`、`trigger_on_follower`、`save_after_add` |
| `montage_add_notify_state` | **Deprecated for authoring**：新增 Notify State | `asset_path`、`notify_state_class`、`time_seconds`、`duration_seconds`；可选 `track_name`、`tick_type/branching_point`、`notify_color`、`trigger_weight_threshold`、`notify_trigger_chance`、`notify_filter_type`、`notify_filter_lod`、`can_be_filtered_via_request`、`trigger_on_dedicated_server`、`trigger_on_follower`、`save_after_add` |
| `montage_update_notify` | **Deprecated for authoring**：修改已有 Notify | `asset_path`、`notify_index`；可选 `time_seconds`、`duration_seconds`、`track_name`、`notify_name`、`tick_type/branching_point`、`notify_color`、`trigger_weight_threshold`、`notify_trigger_chance`、`notify_filter_type`、`notify_filter_lod`、`can_be_filtered_via_request`、`trigger_on_dedicated_server`、`trigger_on_follower`、`save_after_set` |
| `montage_remove_notify` | **Deprecated for authoring**：删除 Notify | `asset_path`、`notify_index`、`save_after_remove` |

## Slot Track

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `montage_add_slot_track` | **Deprecated for authoring**：新增 Slot Track | `asset_path`、`slot_name`、`save_after_add` |
| `montage_rename_slot_track` | **Deprecated for authoring**：重命名 Slot Track | `asset_path`、`slot_name`、`new_slot_name`、`save_after_rename` |
| `montage_remove_slot_track` | **Deprecated for authoring**：删除空 Slot Track | `asset_path`、`slot_name`、`save_after_remove` |

## Segment

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `montage_add_segment` | **Deprecated for authoring**：给指定 Slot Track 追加或插入动画段 | `asset_path`、`slot_name`、`animation_asset`，可选 `start_pos`、`anim_start_time`、`anim_end_time`、`play_rate`、`loop_count`、`save_after_add` |
| `montage_update_segment` | **Deprecated for authoring**：修改已有动画段 | `asset_path`、`slot_name`、`segment_index`，可选 `animation_asset`、`start_pos`、`anim_start_time`、`anim_end_time`、`play_rate`、`loop_count`、`save_after_set` |
| `montage_remove_segment` | **Deprecated for authoring**：删除动画段 | `asset_path`、`slot_name`、`segment_index`、`save_after_remove` |

## Section

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `montage_add_section` | **Deprecated for authoring**：新增 Section | `asset_path`、`section_name`、`time_seconds`、`save_after_add` |
| `montage_rename_section` | **Deprecated for authoring**：重命名 Section | `asset_path`、`section_name`、`new_section_name`、`save_after_rename` |
| `montage_set_section_time` | **Deprecated for authoring**：修改 Section 时间 | `asset_path`、`section_name`、`time_seconds`、`save_after_set` |
| `montage_remove_section` | **Deprecated for authoring**：删除 Section | `asset_path`、`section_name`、`save_after_remove` |
| `montage_set_next_section` | **Deprecated for authoring**：设置或清空 NextSectionName | `asset_path`、`section_name`、`next_section_name` 或 `clear_next_section`、`save_after_set` |
