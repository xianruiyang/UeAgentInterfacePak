# 废弃指令：Animation Assets / Skeleton

> 本文件从 `../13_AnimationAssets_Skeleton.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## Animation Sequence

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_sequence_set_settings` | **Deprecated for authoring**：批量设置 AnimSequence 常用属性 | `asset_path`；可选 `rate_scale`、`enable_root_motion`、`force_root_lock`、`root_motion_lock_type`、`interpolation_type`、`additive_animation_type`、`additive_base_pose_type`、`base_pose_sequence_path`、`clear_base_pose_sequence`、`base_pose_frame_index`、`retarget_source`、`retarget_source_asset_path`、`clear_retarget_source_asset`、`bone_compression_settings_path`、`curve_compression_settings_path`、`variable_frame_stripping_settings_path`、`save_after_set` |
| `anim_sequence_set_preview_mesh` | **Deprecated for authoring**：设置或清空 AnimSequence 预览网格 | `asset_path`、`skeletal_mesh_path` 或 `clear_preview_mesh`、`save_after_set` |

### `anim_sequence_set_settings`

### `anim_sequence_set_settings`

说明：
- 这是当前 AnimSequence 常用资产设置的统一入口，避免继续拆 `set_rate_scale / set_root_motion / set_interpolation / set_additive_base_pose / set_retarget_source` 多条命令。
- 当前优先覆盖“资产级配置”，并已补齐压缩 / 剥帧设置；仍不继续扩到更宽的曲线族、notify payload 和完整骨骼轨 authoring。
- 当前已经补齐压缩 / 剥帧设置：
  - `bone_compression_settings_path`
  - `curve_compression_settings_path`
  - `variable_frame_stripping_settings_path`
- `base_pose_sequence_path` 只在 additive base pose 相关工作流里有意义。
- `retarget_source_asset_path` 走的是 UE 5.6 公开的 retarget source asset 流程；清空时传 `clear_retarget_source_asset=true`。
