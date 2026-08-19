# Deprecated for authoring：IK Rig / IK Retargeter 写入命令

这些命令仍保留兼容，但完整制作和常规修改应走：

- `ik_rig_export_folder -> ik_rig_validate_folder -> ik_rig_apply_folder`
- `ik_retargeter_export_folder -> ik_retargeter_validate_folder -> ik_retargeter_apply_folder`

它们只适合 bootstrap、迁移脚本、schema 边界字段、局部补修和故障恢复。

## IK Rig

| 指令 | 原作用 | 推荐替代 |
|---|---|---|
| `ik_rig_set_solver` | 新增 / 更新 / 删除 solver | 编辑 `solvers.json` 后 `ik_rig_apply_folder` |
| `ik_rig_set_preview_mesh` | 设置或清空 preview mesh | 编辑 `preview.json` 后 `ik_rig_apply_folder` |
| `ik_rig_set_goal` | 新增 / 更新 / 删除 goal | 编辑 `goals.json` 后 `ik_rig_apply_folder` |
| `ik_rig_set_retarget_root` | 设置 retarget root | 编辑 `retarget_definition.json` 后 `ik_rig_apply_folder` |
| `ik_rig_set_retarget_chain` | 新增 / 更新 / 删除 retarget chain | 编辑 `retarget_definition.json` 后 `ik_rig_apply_folder` |

历史参数摘要：

- `ik_rig_set_solver`：`asset_path`；新增时传 `solver_type`，更新/删除时传 `solver_index`；可选 `enabled`、`start_bone_name`、`end_bone_name`、`move_to_index`、`connect_goal_names[]`、`disconnect_goal_names[]`、`settings{...}`、`goal_settings[]`、`bone_settings[]`、`remove`、`save_after_set`。
- `ik_rig_set_preview_mesh`：`asset_path`、`skeletal_mesh_path` 或 `clear_preview_mesh`、`save_after_set`。
- `ik_rig_set_goal`：`asset_path`、`goal_name`；新增/更新时传 `bone_name`；可选 `new_goal_name`、`position_alpha`、`rotation_alpha`、`position`、`rotation`、`current_transform{location/rotation/scale}`、`remove`、`save_after_set`。
- `ik_rig_set_retarget_root`：`asset_path`、`root_bone_name`、`save_after_set`。
- `ik_rig_set_retarget_chain`：`asset_path`、`chain_name`；可选 `start_bone_name`、`end_bone_name`、`goal_name`、`new_chain_name`、`remove`。

## IK Retargeter

| 指令 | 原作用 | 推荐替代 |
|---|---|---|
| `ik_retargeter_set_ik_rig` | 设置 source / target IK Rig | 编辑 `rigs.json` 后 `ik_retargeter_apply_folder` |
| `ik_retargeter_set_settings` | 设置 global / root / chain settings | 编辑 `global_settings.json`、`root_settings.json`、`chain_settings.json` 后 `ik_retargeter_apply_folder` |
| `ik_retargeter_set_pose` | 管理 retarget pose 生命周期与 pose 数据 | 编辑 `poses/source/*.json`、`poses/target/*.json` 后 `ik_retargeter_apply_folder` |
| `ik_retargeter_set_preview_mesh` | 设置 source / target preview mesh | 编辑 `preview_meshes.json` 后 `ik_retargeter_apply_folder` |

历史参数摘要：

- `ik_retargeter_set_ik_rig`：`asset_path`、`source_or_target`、`ik_rig_path`；可选 `clear_ik_rig`、`save_after_set`。
- `ik_retargeter_set_settings`：`asset_path`；可选 `global_settings{...}`、`root_settings{...}`、`target_chain_name`、`chain_settings{...}`、`reset_chain_to_default`、`save_after_set`。
- `ik_retargeter_set_pose`：`asset_path`、`source_or_target`；可选 `pose_name`、`create_if_missing`、`set_current`、`duplicate_from_pose`、`rename_from_pose`、`remove`、`reset_all`、`reset_bones[]`、`root_offset`、`bone_rotation_offsets[]`、`auto_align_all`、`auto_align_bones[]`、`auto_align_method`、`snap_bone_to_ground`、`save_after_set`。
- `ik_retargeter_set_preview_mesh`：`asset_path`、`source_or_target`、`skeletal_mesh_path`；可选 `clear_preview_mesh`、`save_after_set`。

`ik_retargeter_auto_map_chains` 和 `ik_retargeter_duplicate_and_retarget` 是动作命令，不在本废弃列表内。
