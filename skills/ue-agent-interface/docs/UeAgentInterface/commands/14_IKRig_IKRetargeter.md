# 指令详解：IK Rig / IK Retargeter

本分册只保留当前推荐主流程：创建最小资产、读取信息、导出文件夹式 JSON、校验、回写、批量重定向动作。

已能被 `ik_rig_apply_folder` 或 `ik_retargeter_apply_folder` 覆盖的零散写入命令已移动到 `deprecatedCommand/14_IKRig_IKRetargeter.md`，仍保留兼容，但不再作为 authoring 主入口。

## IK Rig

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `ik_rig_create` | 创建 IK Rig 最小资产 | `asset_path`；可选 `preview_skeletal_mesh`、`apply_auto_retarget_definition`、`save_after_create` |
| `ik_rig_get_info` | 读取 IK Rig 摘要 | `asset_path` |
| `ik_rig_export_folder` | 导出 IK Rig 文件夹式结构化 JSON | `asset_path`；可选 `folder_path` |
| `ik_rig_validate_folder` | 只读校验 IK Rig 文件夹 JSON | `folder_path`；可选 `asset_path`、`create_if_missing` |
| `ik_rig_apply_folder` | 应用 IK Rig 文件夹 JSON | `folder_path`；可选 `asset_path`、`dry_run`、`validate_only`、`create_if_missing`、`save_after_apply` |
| `ik_rig_apply_auto_retarget_definition` | 对匹配模板的骨架自动生成 retarget definition | `asset_path`、`save_after_set` |
| `ik_rig_preview_solve` | 不进 PIE 的 IK Rig 预览求解探针 | `asset_path`；可选 `skeletal_mesh_path`、`goals[]`、`sample_bones[]`、`include_all_bones`、`max_output_bones` |

### IK Rig 文件夹式 JSON 主流程

推荐流程：

1. `ik_rig_create` 创建最小资产，或使用现有 IK Rig。
2. `ik_rig_export_folder` 导出真实结构。
3. 修改导出的 JSON。
4. `ik_rig_validate_folder` 校验。
5. `ik_rig_apply_folder` 回写，再导出确认读回。

导出文件：

- `asset.json`
- `preview.json`
- `hierarchy.json`
- `goals.json`
- `retarget_definition.json`
- `solvers.json`
- `excluded_bones.json`
- `raw_properties.json`
- `readonly_properties.json`
- `validation/coverage_report.json`
- `validation/readback_diff.json`
- `validation/diagnostics.json`

当前可回写：preview mesh、retarget root、goals、retarget chains、solver 基础结构，以及已开放的 BodyMover / FBIK solver settings、goal settings、bone settings。

`ik_rig_apply_auto_retarget_definition` 是显式动作命令，不放进普通 folder apply 隐式执行。

### `ik_rig_get_info`

当前返回：

- `asset_path`
- `object_path`
- `preview_skeletal_mesh`
- `retarget_root`
- `goal_count`
- `goals[]`
- `retarget_chain_count`
- `retarget_chains[]`
- `solver_count`
- `solvers[]`

`solvers[]` 会按 solver 类型回读 `solver_kind`、`settings`、`goal_settings[]`、`bone_settings[]`。

### `ik_rig_preview_solve`

用途：在编辑器服务内用 `FIKRigProcessor` 对 IK Rig 执行一次 ref pose 输入的预览求解，不打开游戏、不全屏、不写资产。用于检查 solver 是否能初始化、goal override 是否生效、输出骨骼全局姿态是否合理。

关键参数：
- `asset_path`：IK Rig 资产。
- `skeletal_mesh_path`：可选；不传时使用 IK Rig 的 preview mesh。
- `goals[]`：可选 goal 覆盖。每项支持 `goal_name/name`、`bone_name`、`position`、`rotation`、`position_alpha`、`rotation_alpha`、`position_space`、`rotation_space`、`enabled`。
- `sample_bones[]`：可选，指定回读哪些骨骼。
- `include_all_bones` / `max_output_bones`：控制输出姿态采样规模，`max_output_bones` 默认 64，最多 512。

返回重点：
- `initialized`、`solved`
- `errors/warnings/messages` 与 `errors_after_solve/warnings_after_solve/messages_after_solve`
- `goals[]`，包含 `final_blended_position/final_blended_rotation`
- `output_pose_sample[]` 与 `missing_sample_bones[]`

如果 `initialized=false`，命令失败并返回 `ik_rig_preview_solve_initialize_failed`，同时 `data` 里保留 IK Rig logger 诊断。

## IK Retargeter

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `ik_retargeter_create` | 创建 IK Retargeter 最小资产 | `asset_path`；可选 `source_ik_rig`、`target_ik_rig`、`source_preview_mesh`、`target_preview_mesh`、`add_default_ops`、`save_after_create` |
| `ik_retargeter_get_info` | 读取 IK Retargeter 摘要 | `asset_path` |
| `ik_retargeter_export_folder` | 导出 IK Retargeter 文件夹式结构化 JSON | `asset_path`；可选 `folder_path` |
| `ik_retargeter_validate_folder` | 只读校验 IK Retargeter 文件夹 JSON | `folder_path`；可选 `asset_path`、`create_if_missing` |
| `ik_retargeter_apply_folder` | 应用 IK Retargeter 文件夹 JSON | `folder_path`；可选 `asset_path`、`dry_run`、`validate_only`、`create_if_missing`、`save_after_apply` |
| `ik_retargeter_auto_map_chains` | 对 retargeter op stack 自动做链映射 | `asset_path`；可选 `auto_map_type=exact/fuzzy/clear`、`force_remap`、`op_name`、`save_after_set` |
| `ik_retargeter_auto_align_pose` | 对当前或指定 retarget pose 执行自动姿势对齐 | `asset_path`、`source_or_target`；可选 `pose_name`、`create_if_missing`、`set_current`、`auto_align_method`、`auto_align_all`、`auto_align_bones[]/bones[]`、`snap_bone_to_ground`、`reset_*`、`save_after_set` |
| `ik_retargeter_duplicate_and_retarget` | 批量复制并重定向动画资产 | `asset_path`、`asset_paths[]`、`output_folder`；可选 `source_mesh_path`、`target_mesh_path`、`prefix`、`suffix`、`search`、`replace`、`include_referenced_assets` |
| `retarget_batch_export_json` | 生成批量重定向单文件 JSON | `retargeter`、`asset_paths[]`、`output_folder`；可选 `output_file`、`source_mesh`、`target_mesh`、`prefix/suffix/search/replace` |
| `retarget_batch_validate_json` | 校验批量重定向 JSON | `json_file` |
| `retarget_batch_apply_json` | 执行批量重定向 JSON | `json_file` |

### IK Retargeter 文件夹式 JSON 主流程

推荐流程：

1. 用 `ik_retargeter_create` 创建最小资产，并设置 source / target rig。
2. `ik_retargeter_export_folder` 导出真实结构。
3. 修改 `rigs.json`、`preview_meshes.json`、`global_settings.json`、`root_settings.json`、`chain_mappings.json`、`chain_settings.json`、`poses/*/Default.json`。
4. `ik_retargeter_validate_folder` 校验。
5. `ik_retargeter_apply_folder` 回写，再执行 retarget smoke。

导出文件：

- `asset.json`
- `rigs.json`
- `preview_meshes.json`
- `op_stack.json`
- `global_settings.json`
- `root_settings.json`
- `chain_mappings.json`
- `chain_settings.json`
- `poses/source/Default.json`
- `poses/target/Default.json`
- `batch_profiles.json`
- `raw_properties.json`
- `readonly_properties.json`
- `validation/coverage_report.json`
- `validation/chain_mapping_report.json`
- `validation/pose_diff_report.json`
- `validation/retarget_smoke_report.json`
- `validation/readback_diff.json`
- `validation/diagnostics.json`

当前可回写：source / target IK Rig、source / target preview mesh、global / root / chain settings、chain mapping、默认 source / target pose。

`ik_retargeter_auto_align_pose / ik_retargeter_auto_map_chains / duplicate-and-retarget` 是动作语义，保留为命令或批处理 JSON，不隐式塞进普通 folder apply。

### `ik_retargeter_auto_align_pose`

用途：把自动姿势对齐从旧的 `ik_retargeter_set_pose` 零散写入语义中抽出，作为明确动作命令使用。它仍复用 UE controller 的 `AutoAlignAllBones`、`AutoAlignBones`、`SnapBoneToGround`、`ResetRetargetPose` 能力。

关键参数：
- `asset_path`
- `source_or_target`: `source` 或 `target`
- `auto_align_method`: `chain_to_chain`、`mesh_to_mesh`、`local_rotation_axes`、`global_rotation_axes`，默认 `chain_to_chain`
- `auto_align_all`: 可选；未传 `auto_align_bones/bones/snap/reset/root_offset` 时默认执行全骨骼自动对齐
- `auto_align_bones[]` 或别名 `bones[]`
- `pose_name`、`create_if_missing`、`set_current`：可选，用于指定并切换姿势
- `snap_bone_to_ground`、`reset_all`、`reset_bones[]`、`root_offset`：可选的姿势修正动作

返回重点：
- `action=auto_align_pose`
- `auto_align_method`
- `used_auto_align_all`
- `used_auto_align_bones_count`
- `current_pose` 与 `current_pose_data`

### Retarget Batch JSON

批量重定向使用单文件 JSON，因为它是一次性动作，不是 retargeter 资产状态。

JSON 字段：

- `schema`: `ue_agent_interface.retarget_batch.v1`
- `retargeter`
- `source_assets[]` 或 `asset_paths[]`
- `source_mesh` 或 `source_mesh_path`
- `target_mesh` 或 `target_mesh_path`
- `output_folder`
- `prefix` / `suffix` / `search` / `replace`

示例：

```json
{
  "schema": "ue_agent_interface.retarget_batch.v1",
  "retargeter": "/Game/IK/RTG_PlayerToEnemy",
  "source_assets": ["/Game/Anim/A_Run"],
  "source_mesh": "/Game/Characters/Player/SK_Player",
  "target_mesh": "/Game/Characters/Enemy/SK_Enemy",
  "output_folder": "/Game/Anim/Retargeted",
  "prefix": "RTG_"
}
```

## 当前边界

- `IK Rig` folder workflow 覆盖 preview mesh、retarget root、goal、retarget chain、solver 基础结构与已开放的 BodyMover/FBIK 设置；未开放的 solver 专用 struct 仍以 UE controller 稳定支持为准。
- `IK Retargeter` folder workflow 覆盖 rigs、preview meshes、global/root/chain settings、chain mapping、默认 pose 数据；完整 op 专用 settings 仍以 UE controller 可稳定回写的字段为准。
- `Retarget Batch` 使用单文件 JSON，因为它是“复制并重定向一批动画”的动作，不是 retargeter 资产状态。
- 可由 folder JSON 覆盖的原子写入命令只用于 bootstrap、迁移、schema 边界和故障恢复，归档见 `deprecatedCommand/14_IKRig_IKRetargeter.md`。

<!-- UAI_FORMAL_COMMAND_INDEX_BEGIN -->

## 补充命令正式索引
>
> 以下命令仍属于本正式分册；已废弃写入命令不在正式分册列出，仅保留在 `deprecatedCommand/14_IKRig_IKRetargeter.md`。

| Command | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `ik_retargeter_set_ik_rig` | 设置 source / target IK Rig | 编辑 `rigs.json` 后 `ik_retargeter_apply_folder` | `success`、`warnings`、`errors` |
| `ik_retargeter_set_pose` | 管理 retarget pose 生命周期与 pose 数据 | 编辑 `poses/source/*.json`、`poses/target/*.json` 后 `ik_retargeter_apply_folder` | `success`、`warnings`、`errors` |
| `ik_retargeter_set_preview_mesh` | 设置 source / target preview mesh | 编辑 `preview_meshes.json` 后 `ik_retargeter_apply_folder` | `success`、`warnings`、`errors` |
| `ik_retargeter_set_settings` | 设置 global / root / chain settings | 编辑 `global_settings.json`、`root_settings.json`、`chain_settings.json` 后 `ik_retargeter_apply_folder` | `success`、`warnings`、`errors` |
| `ik_rig_set_goal` | 新增 / 更新 / 删除 goal | 编辑 `goals.json` 后 `ik_rig_apply_folder` | `success`、`warnings`、`errors` |
| `ik_rig_set_preview_mesh` | 设置或清空 preview mesh | 编辑 `preview.json` 后 `ik_rig_apply_folder` | `success`、`warnings`、`errors` |
| `ik_rig_set_retarget_chain` | 新增 / 更新 / 删除 retarget chain | 编辑 `retarget_definition.json` 后 `ik_rig_apply_folder` | `success`、`warnings`、`errors` |
| `ik_rig_set_retarget_root` | 设置 retarget root | 编辑 `retarget_definition.json` 后 `ik_rig_apply_folder` | `success`、`warnings`、`errors` |
| `ik_rig_set_solver` | 新增 / 更新 / 删除 solver | 编辑 `solvers.json` 后 `ik_rig_apply_folder` | `success`、`warnings`、`errors` |

<!-- UAI_FORMAL_COMMAND_INDEX_END -->
