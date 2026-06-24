# 指令详解：Animation Assets / Skeleton

> 废弃写入命令已迁移到 `deprecatedCommand/13_AnimationAssets_Skeleton.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## Animation Sequence

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_sequence_get_info` | 读取 AnimSequence 资产摘要 | `asset_path`；可选 `include_curve_keys` |
| `anim_sequence_analyze_root_motion` | 采样 AnimSequence 的 root motion / root bone / 朝向骨骼轨道，输出转身角度、水平距离和建议曲线/marker | `asset_path`；可选 `sample_count`、`orientation_bone_name`、`include_samples`、`include_suggested_keys`、`meaningful_yaw_threshold_degrees`、`meaningful_translation_threshold_cm` |
| `anim_sequence_sample_pose` | 采样 AnimSequence 在指定时间或帧的骨骼姿态，返回本地或世界空间 transform | `asset_path`；可选 `bone_names[]`/`bones[]`、`frame_index` 或 `time_seconds`、`frame_indices[]`、`time_seconds_list[]`、`space=local/world`、`evaluation_type=raw/source/compressed`、`skeletal_mesh_path`、`include_ref_pose`、`max_bones` |
| `anim_sequence_screenshot` | 按帧/时间截取 AnimSequence 预览图，也可批量输出序列帧总览图 | `asset_path`；可选 `skeletal_mesh_path`、`frame_index` 或 `time_seconds`；批量可传 `start_time_seconds`、`count`、`interval_seconds` 或 `start_frame_index`、`count`、`frame_interval`；`format`、`quality`、`max_size`、`target`、`create_frame_sheet`、`write_individual_frames`、`frame_sheet_padding`、`frame_sheet_max_size`、`frame_sheet_label_scale` |
| `anim_sequence_set_curve` | 统一管理 AnimSequence 曲线与 key | `asset_path`、`curve_name`；可选 `curve_type=float`、`curve_json`、`keys[]`、`time_seconds/value`、`clear_existing_keys`、`remove`、`meta_data_curve`、`remove_name_from_skeleton`、`save_after_set` |
| `anim_sequence_set_bones` | 统一管理骨骼动画轨删除 | `asset_path`；可选 `remove_bone_names[]`、`include_children`、`children_excluded[]`、`exclude_children_recursively`、`remove_all_bone_animation`、`remove_virtual_bone_names[]`、`finalize_after_set`、`save_after_set` |
| `anim_sequence_apply_bone_tracks` | 写入 AnimSequence 骨骼 transform 轨道 key，可创建新 AnimSequence 或更新已有轨道 | `asset_path`；可选 `create_if_missing`、`target_skeleton`/`skeleton`、`preview_skeletal_mesh`/`skeletal_mesh_path`、`frame_rate`/`fps`、`num_frames`、`tracks[]`、`replace_existing_tracks`、`save_after_apply` |
| `anim_sequence_set_metadata` | 统一管理 AnimSequence metadata 生命周期 | `asset_path`；可选 `metadata_class_path`、`metadata_values`、`remove`、`clear_all`、`save_after_set` |
| `anim_sequence_set_notify_track` | 新增 / 更新 / 删除 notify track | `asset_path`、`track_name`；可选 `track_color`、`remove`、`save_after_set` |
| `anim_sequence_set_notify` | 新增 / 更新 / 删除单条 notify | `asset_path`；新增时传 `time_seconds`，更新/删除时传 `notify_index`；可选 `track_name`、`notify_name`、`notify_class`、`notify_state_class`、`duration_seconds`、`tick_type`、`trigger_weight_threshold`、`notify_trigger_chance`、`notify_filter_type`、`notify_filter_lod`、`can_be_filtered_via_request`、`trigger_on_dedicated_server`、`trigger_on_follower`、`notify_color`、`remove`、`save_after_set` |
| `anim_sequence_set_sync_markers` | 批量新增 / 删除 / 清空 sync marker | `asset_path`；可选 `add_markers[]`、`remove_marker_names[]`、`remove_notify_track_names[]`、`clear_all`、`save_after_set` |

## BlendSpace

BlendSpace 使用单文件 JSON 工作流，不推荐长期用散装属性命令 authoring。

推荐流程：

`blendspace_create -> blendspace_export_json -> 修改 JSON -> blendspace_validate_json -> blendspace_apply_json -> blendspace_export_json 读回`

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `blendspace_create` | 创建 BlendSpace / BlendSpace1D / AimOffset / AimOffset1D | `asset_path`、`skeleton`；可选 `blendspace_kind=blendspace_2d|blendspace_1d|aim_offset|aim_offset_1d`、`axes[]`、`samples[]`、`save_after_create` |
| `blendspace_get_info` | 读取 BlendSpace 摘要 | `asset_path` |
| `blendspace_export_json` | 导出 BlendSpace 单文件 JSON | `asset_path`；可选 `output_file` |
| `blendspace_validate_json` | 只读校验 BlendSpace JSON | `json_file` 或 `json`；可选 `asset_path` |
| `blendspace_apply_json` | 回写轴、样本和设置 | `json_file` 或 `json`；可选 `asset_path`、`dry_run`、`validate_only`、`save_after_apply` |
| `blendspace_preview_sample` | 在指定输入位置采样权重 | `asset_path`、`position` |

JSON 关键字段：

- `blendspace_kind`：资产类型。`blendspace_1d` 只使用 X 轴；2D 使用 X/Y。
- `skeleton`：目标 Skeleton。样本动画必须兼容该 Skeleton。
- `axes[]`：`axis_index`、`name`、`min`、`max`、`grid_num`、`snap_to_grid`、`wrap_input`。
- `samples[]`：`animation`、`position`、`rate_scale`。apply 时会清空并按 JSON 重建样本列表。

示例：

```json
{
  "asset_path": "/Game/Animation/BS_Locomotion",
  "skeleton": "/Game/Characters/Hero/SK_Hero_Skeleton.SK_Hero_Skeleton",
  "blendspace_kind": "blendspace_1d",
  "axes": [
    { "axis_index": 0, "name": "Speed", "min": 0.0, "max": 600.0, "grid_num": 6 }
  ],
  "samples": [
    { "animation": "/Game/Animation/A_Idle.A_Idle", "position": { "x": 0.0, "y": 0.0, "z": 0.0 } },
    { "animation": "/Game/Animation/A_Run.A_Run", "position": { "x": 600.0, "y": 0.0, "z": 0.0 } }
  ]
}
```

### `anim_sequence_get_info`

当前返回：
- `skeleton`
- `preview_skeletal_mesh`
- `sequence_length`
- `rate_scale`
- `num_frames`
- `interpolation_type`
- `additive_animation_type`
- `additive_base_pose_type`
- `additive_base_pose_sequence`
- `additive_base_pose_frame_index`
- `root_motion_enabled`
- `force_root_lock`
- `root_motion_lock_type`
- `retarget_source`
- `retarget_source_asset`
- `bone_compression_settings`
- `curve_compression_settings`
- `variable_frame_stripping_settings`
- `track_count`
- `track_names[]`
- `metadata_count`
- `metadata[]`
- `curve_count`
- `curves[]`
- `notifies[]`
- `notify_tracks[]`
- `sync_markers[]`
- `unique_notify_names[]`
- `unique_marker_names[]`

说明：
- `notifies[]` 当前会回读 `notify_index / notify_name / track_name / time_seconds / duration_seconds / tick_type / trigger/filter 字段 / color / class`。
- `metadata[]` 当前会回读 metadata 类与简单 `properties` 摘要。
- `notify_tracks[]` 用于快速确认 notify 和 marker 依附在哪条轨上。
- `sync_markers[]` 适合做 marker sync 自动化回读。

### `anim_sequence_analyze_root_motion`

说明：
- 只读采样命令，用于判断动画是否真的包含 root 轨道运动，而不是只看 `root_motion_enabled` 开关。
- 命令会同时读取 `ExtractRootMotionFromRange(0,time)` 的 root motion 结果、root bone 在采样点相对首帧的 raw delta，以及可选朝向骨骼相对首帧的 yaw delta，便于识别“资产有 root 轨道但 root 只位移，身体朝向转在 hips/pelvis 上”的情况。
- 未传 `orientation_bone_name` 时会按 `hips -> pelvis -> spine -> root` 自动选择第一个存在的骨骼。
- 适合给 Turn-In-Place、root-motion turn montage、pivot/turn 动作补 `TurnYaw`、`Distance`、`TurnStart`、`PivotCommit`、`TurnEnd` 等基础信号；`FootPlant` / `FootLock` 仍建议结合脚骨/视觉审核单独确认，不能只从 root 或 hips/pelvis 轨道推断。

参数：
- `asset_path`：目标 AnimSequence。
- `sample_count`：采样点数，默认 `17`，范围 `2..121`。
- `orientation_bone_name`：用于估计角色朝向变化的骨骼名；不传时自动选择 `hips/pelvis/spine/root`。
- `include_samples`：是否返回每个采样点的 transform 和增量，默认 `true`。
- `include_suggested_keys`：是否返回 `suggested_turn_yaw_keys` / `suggested_distance_keys`，默认 `true`。
- `meaningful_yaw_threshold_degrees`：判定 root yaw 有意义的阈值，默认 `15`。
- `meaningful_translation_threshold_cm`：判定水平位移有意义的阈值，默认 `2`。

返回：
- `root_motion_enabled`、`force_root_lock`、`has_root_bone_track`、`root_bone_name`、`orientation_bone_name`、`orientation_bone_index`。
- `total_yaw_degrees`、`total_horizontal_distance_cm`、`total_root_motion_path_distance_cm`、`max_abs_root_motion_yaw_degrees`、`max_root_motion_horizontal_distance_cm`。
- `max_abs_raw_root_delta_yaw_degrees`、`max_raw_root_delta_horizontal_distance_cm`、`total_orientation_bone_delta_yaw_degrees`、`max_abs_orientation_bone_delta_yaw_degrees`。
- `has_meaningful_root_yaw`、`has_meaningful_raw_root_yaw`、`has_meaningful_orientation_bone_yaw`、`has_meaningful_root_translation`、`has_meaningful_raw_root_translation`。
- `turn_classification`：`turn_positive_90`、`turn_negative_90`、`turn_positive_180`、`turn_negative_180`、`turn_positive_partial`、`turn_negative_partial` 或 `none`；`turn_classification_source` 说明来自 `root_motion` 还是 `orientation_bone`。
- `suggested_markers[]`：默认包含 `TurnStart`、`PivotCommit`、`TurnEnd`。
- `suggested_turn_yaw_source`、`suggested_root_motion_yaw_keys[]`、`suggested_orientation_yaw_keys[]`、`suggested_turn_yaw_keys[]` / `suggested_distance_keys[]`：可直接转换为 `anim_sequence_set_curve` 的 `keys[]`；`suggested_distance_keys[]` 使用累计 root motion 路径距离，保持单调递增。
- `samples[]`：采样点明细；包含 root motion transform、累计 path distance、raw root transform 和 raw root delta。

示例：
```json
{
  "asset_path": "/Game/Characters/PaladinRootMotion/Animations/sword_and_shield_turn_RM",
  "sample_count": 17,
  "include_samples": true
}
```

### `anim_sequence_sample_pose`

说明：
- 只读采样命令，用于把 AnimSequence 在某个时间或帧上的骨骼姿态读回为 JSON。
- 默认 `space=local`、`evaluation_type=raw`、`should_retarget=false`、`evaluate_curves=false`，适合把现有动画作为原型，采样本地骨骼 transform 后再用 `anim_sequence_apply_bone_tracks` 局部覆盖目标骨骼轨道。
- 不传 `bone_names[]` / `bones[]` 时返回最多 `max_bones` 根骨骼，默认 `512`；制作动画时建议只传需要修改或验证的骨骼，避免 report 过大。
- 返回 transform 同时包含欧拉角 `rotation` 和四元数 `quaternion`；写回动画轨时建议使用四元数，减少欧拉角顺序误差。

参数：
- `asset_path`：目标 AnimSequence。
- `bone_names[]` / `bones[]` / `sample_bones[]`：要返回的骨骼名；也可用单个 `bone_name` / `bone`。
- `frame_index` / `frame`：单帧采样。
- `time_seconds` / `time`：单时间采样。
- `frame_indices[]` / `frames[]`：多帧采样。
- `time_seconds_list[]` / `times_seconds[]` / `times[]`：多时间采样。
- `space`：`local` 或 `world`，默认 `local`。
- `evaluation_type`：`raw`、`source` 或 `compressed`，默认 `raw`。
- `skeletal_mesh_path` / `preview_skeletal_mesh`：可选预览网格，用于带网格比例的姿态评估，会检查 skeleton 兼容性。
- `should_retarget`、`extract_root_motion`、`incorporate_root_motion_into_pose`、`retrieve_additive_as_full_pose`、`evaluate_curves`：对应 UE pose evaluation options。
- `include_ref_pose`：是否同时返回参考姿势 transform。
- `max_bones`：未指定骨骼时最多返回的骨骼数，默认 `512`。

返回：
- `asset_path`、`object_path`、`skeleton`、`preview_skeletal_mesh`
- `space`、`evaluation_type`、`should_retarget`、`extract_root_motion`、`evaluate_curves`
- `sequence_length`、`num_frames`、`max_frame_index`、`sampling_frame_rate`
- `sample_count`、`requested_all_bones`、`requested_bone_count`、`truncated_bones`、`missing_bones[]`
- `samples[]`：每个采样点包含 `frame_index`、`time_seconds`、`normalized_time`、`bones[]`；每个 bone 返回 `bone_name`、`bone_index`、`transform`

示例：

```json
{
  "asset_path": "/Game/Characters/Hero/Animations/A_Idle",
  "bone_names": ["spine_03", "upperarm_r", "lowerarm_r", "hand_r"],
  "time_seconds_list": [0.0, 0.2, 0.4],
  "space": "local",
  "evaluation_type": "raw"
}
```

### `anim_sequence_screenshot`

说明：
- 用于动画选帧审查，按 `frame_index` 或 `time_seconds` 把指定 `AnimSequence` 固定到目标帧并输出图片。
- 批量审查动作阶段时，使用 `start_time_seconds + count + interval_seconds`，或 `start_frame_index + count + frame_interval` 一次输出序列帧总览图。该模式适合 Montage section 划分、攻击起手/命中/收招检查和跳跃关键姿势审查。
- 如果动画资产没有设置预览网格，建议显式传 `skeletal_mesh_path`；命令会检查 Skeleton 兼容性。
- 当前 `target` 只稳定开放 `viewport`，实现内部使用临时预览 Actor + SceneCapture，不依赖当前关卡相机。
- 当前会创建临时补光和背景板，并只把预览角色/背景板纳入捕获，避免当前关卡地面、水面、墙体或背光污染选帧截图。
- 单帧模式返回单张帧图。多帧模式默认只写一张序列帧总览图，`file_path`、`frame_sheet_file_path` 与 `sequence_frame_image_path` 都指向该图；每个格子左上角标注 `F<frame_index>`。
- `frames[]` 始终返回每个采样帧的 metadata，包括 `sequence_index`、`width`、`height`、`frame_index`、`frame_label`、`time_seconds`。默认不再给每帧写单独图片；如需兼容旧流程，可传 `write_individual_frames=true`。
- 可传 `create_frame_sheet=false` 关闭总览图；若同时没有 `write_individual_frames=true`，命令会返回 `multi_frame_output_disabled`。总览图统一按最小正方形网格排布，即 `ceil(sqrt(frame_count)) x ceil(sqrt(frame_count))`，不足格子留空；`frame_sheet_padding` 控制间距；`frame_sheet_max_size` 控制总览图最长边；`frame_sheet_label_scale` 控制帧号字号。
- 批量模式上限为 120 张；若请求时间或帧区间超过动画长度，会失败并返回 `preview_time_range_exceeds_sequence` 或 `preview_frame_range_exceeds_sequence`，避免尾帧重复误导判断。

示例：

```json
{
  "asset_path": "/Game/Characters/Paladin/Animations/sword_and_shield_180_turn__2_",
  "skeletal_mesh_path": "/Game/Characters/Paladin/Mesh/Paladin_WProp_J_Nordstrom",
  "frame_index": 24,
  "format": "png",
  "max_size": 1280,
  "target": "viewport"
}
```

批量示例：

```json
{
  "asset_path": "/Game/Characters/PaladinRootMotion/Animations/sword_and_shield_slash__2__RM",
  "skeletal_mesh_path": "/Game/Characters/PaladinRootMotion/Mesh/Paladin_WProp_J_Nordstrom_RM",
  "start_time_seconds": 0.8,
  "count": 8,
  "interval_seconds": 0.1,
  "format": "png",
  "max_size": 1024,
  "target": "viewport"
}
```

### `anim_sequence_set_curve`

说明：
- 这是当前曲线管理的统一入口，避免继续拆 `add_float_curve / remove_curve / add_curve_key` 多条命令。
- 当前稳定开放 `curve_type=float`。
- 推荐优先使用 `curve_json`，格式为 `ue_agent_interface.curve.v1` 的 float 曲线结构；写入前会校验未知字段、缺 key 值、重复时间、非法插值/切线/外推模式，并在 `json_issues[]` 返回。
- 单 key 写入可直接传顶层 `time_seconds` + `value`。
- 多 key 写入走 `keys[]`。
- `clear_existing_keys=true` 会先清掉该曲线现有 key，再重建当前输入。
- 曲线用于 IK 权重、脚锁定、手部贴合或步态阶段时，apply 后必须用 `anim_sequence_get_info(include_curve_keys=true)` 或重新导出曲线确认 key 数、时间、最大值和插值。只看到曲线名存在，不代表运行时权重有效。
- 移动动画的 IK 曲线通常需要支撑期高、摆动期低的过渡；全程 1.0 容易锁脚卡顿，全程 0.0 会让 Control Rig 看起来无效。

推荐参数形式：

```json
{
  "asset_path": "/Game/Anim/A_Idle_Copy",
  "curve_name": "StageCurve",
  "curve_type": "float",
  "curve_json": {
    "schema": "ue_agent_interface.curve.v1",
    "curve_kind": "float",
    "storage": "animation_raw_curve",
    "carrier_cpp_type": "FRichCurve",
    "channels": {
      "value": {
        "keys": [
          { "time": 0.10, "value": 1.0 },
          { "time": 0.20, "value": 2.0 }
        ]
      }
    }
  },
  "save_after_set": false
}
```

### `anim_sequence_set_bones`

说明：
- 这是当前骨骼动画轨处理的统一入口，避免继续拆 `remove_bone_track / remove_all_bone_tracks / remove_virtual_bones` 多条命令。
- 当前稳定面主要是“按骨骼名删除动画轨”。
- `include_children=true` 时会走递归删除；如需要排除部分子骨骼，可配合 `children_excluded[]` 与 `exclude_children_recursively`。
- `remove_virtual_bone_names[]` 当前也已接入，但由于它会影响关联 skeleton，使用时应明确知道目标序列绑定的 skeleton。

推荐参数形式：

```json
{
  "asset_path": "/Game/Anim/A_Idle_Copy",
  "remove_bone_names": ["pelvis"],
  "include_children": false,
  "finalize_after_set": true,
  "save_after_set": false
}
```

### `anim_sequence_apply_bone_tracks`

说明：
- 这是 AnimSequence 骨骼 transform 轨写入的主流程入口，用于把本地空间 location / rotation / scale key 写进 UE 原生 DataModel。
- `num_frames` 表示可播放帧数；UE DataModel 会对应 `num_frames + 1` 个采样 key。例如 `num_frames=24` 会写入 25 个 key，允许索引 `0..24`。
- `tracks[]` 中每条轨道必须指定 `bone`/`bone_name` 和 `keys[]`。若 key 不带 `frame`/`time_seconds`，`keys[]` 数量必须正好等于 `num_frames + 1`，按数组顺序写入；若带 `frame` 或 `time_seconds`，则按对应采样 key 写入，未指定的 key 使用该骨骼参考姿势。
- `rotation` 是绝对本地旋转，可用 `{ "pitch": 0, "yaw": 0, "roll": 0 }`（角度）或 `{ "x": 0, "y": 0, "z": 0, "w": 1 }`（四元数）。不要用 `rotation: {0,0,0}` 表示休息姿势；省略 `rotation` 才会保留该骨骼参考姿势。
- `rotation_delta` / `rotator_delta` / `quat_delta` / `quaternion_delta` / `additive_rotation` 表示在 ref pose 后叠加的旋转增量；`pre_rotation_delta` 系列表示在 ref pose 前叠加。LLM authoring 推荐优先使用 `rotation_delta`，未动画帧传空 key `{}`。
- `location`/`translation`/`position` 与 `scale` 可用 `{x,y,z}` 或 `[x,y,z]`；省略时使用对应骨骼参考姿势。
- `replace_existing_tracks=true` 会先清空现有骨骼动画轨；默认只新增或覆盖传入的目标骨骼轨。
- 创建新资产时必须提供 `target_skeleton`/`skeleton`，建议同时提供 `preview_skeletal_mesh` 便于后续截图预览。

推荐参数形式：

```json
{
  "asset_path": "/Game/Anim/A_ForwardPunch",
  "create_if_missing": true,
  "target_skeleton": "/Game/Characters/Hero/SK_Hero_Skeleton",
  "preview_skeletal_mesh": "/Game/Characters/Hero/SK_Hero",
  "frame_rate": { "numerator": 24, "denominator": 1 },
  "num_frames": 24,
  "replace_existing_tracks": true,
  "tracks": [
    {
      "bone": "upperarm_r",
      "keys": [
        { "frame": 0 },
        { "frame": 12, "rotation_delta": { "pitch": -55, "yaw": 20, "roll": 15 } },
        { "frame": 24 }
      ]
    }
  ],
  "save_after_apply": true
}
```

返回：
- `asset_path`、`object_path`
- `skeleton`、`preview_skeletal_mesh`
- `frame_rate`、`num_frames`、`sample_key_count`
- `created`、`replace_existing_tracks`、`applied_track_count`、`applied_tracks[]`
- `track_count`、`track_names[]`
- `saved`

### `anim_sequence_set_metadata`

说明：
- 这是 AnimSequence metadata 生命周期的统一入口，避免继续拆 `add_metadata / remove_metadata / clear_metadata` 多条命令。
- 传 `metadata_class_path` 且不带 `remove` 时，会“如果不存在则添加”，默认不重复创建同类 metadata。
- `metadata_values` 可用于同一条命令内直接写简单 metadata 属性。
- 传 `remove=true` 时，按类删除该序列上的全部同类 metadata。
- `clear_all=true` 时清空该序列上的全部 metadata。
- metadata 类必须是具体的 `UAnimMetaData` 派生类，不能是抽象基类。

推荐参数形式：

```json
{
  "asset_path": "/Game/Anim/A_Idle_Copy",
  "metadata_class_path": "/Script/GptProjectTest.GptAnimMetaTag",
  "metadata_values": {
    "tag": "Stage27Tag",
    "note": "Stage27Note"
  },
  "save_after_set": false
}
```

> 废弃写入命令已迁移到 `deprecatedCommand/13_AnimationAssets_Skeleton.md` 的对应章节。
### `anim_sequence_set_notify`

说明：
- 这是 AnimSequence notify 本体的统一入口，避免继续拆 `add_notify / update_notify / remove_notify / add_notify_state` 多条命令。
- 不传 `notify_class / notify_state_class` 时，会创建一条普通命名 notify。
- 传 `notify_state_class` 时，必须同时提供 `duration_seconds`。
- 新增时如 `track_name` 不存在，命令会先补齐 notify track。
- 当前优先支持 notify 结构、时间、轨道、颜色和常见触发/过滤字段；不继续扩到自定义 notify 对象 payload 属性编辑。

推荐参数形式：

```json
{
  "asset_path": "/Game/Anim/A_Idle_Copy",
  "track_name": "Markers",
  "time_seconds": 0.2,
  "notify_name": "FootstepL",
  "notify_color": { "r": 0.9, "g": 0.3, "b": 0.2, "a": 1.0 },
  "notify_filter_type": "lod",
  "notify_filter_lod": 1,
  "save_after_set": false
}
```

### `anim_sequence_set_sync_markers`

推荐参数形式：

```json
{
  "asset_path": "/Game/Anim/A_Idle_Copy",
  "add_markers": [
    { "marker_name": "LeftPlant", "time_seconds": 0.10, "notify_track_name": "Markers" },
    { "marker_name": "RightPlant", "time_seconds": 0.42, "notify_track_name": "Markers" }
  ],
  "save_after_set": false
}
```

说明：
- `remove_marker_names[]`：按 marker 名批量删除。
- `remove_notify_track_names[]`：按 notify track 批量删该轨上的 marker。
- `clear_all=true`：清空该序列全部 sync marker。
- 如果 `add_markers[].notify_track_name` 不存在，命令会先补对应 notify track。

## Skeleton

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `skeleton_get_info` | 读取 Skeleton 摘要 | `asset_path` |
| `skeleton_list_bones` | 列出 Reference Skeleton 骨骼层级 | `asset_path` |
| `skeleton_export_folder` | 导出 Skeleton 文件夹式结构化 JSON | `asset_path`；可选 `folder_path` |
| `skeleton_validate_folder` | 只读校验 Skeleton 文件夹 JSON | `folder_path`；可选 `asset_path`、`strict` |
| `skeleton_apply_folder` | 应用 Skeleton 文件夹 JSON | `folder_path`；可选 `asset_path`、`dry_run`、`validate_only`、`strict`、`save_after_apply` |
| `skeleton_set_preview_mesh` | 设置或清空 Skeleton preview mesh | `asset_path`、`skeletal_mesh_path` 或 `clear_preview_mesh`、`save_after_set` |

### Skeleton 文件夹式 JSON 主流程

推荐流程：

1. 用最小命令或现有资产准备 Skeleton。
2. `skeleton_export_folder` 导出真实结构。
3. 修改导出的 JSON 文件。
4. `skeleton_validate_folder` 做只读校验。
5. `skeleton_apply_folder` 回写，再 `skeleton_export_folder` 做读回 diff。

导出文件：

- `asset.json` / `skeleton.json`：资产身份、schema、class、engine version。
- `reference_skeleton.json`：Reference Skeleton 摘要，包含 bone index、parent、reference transform 和 retargeting 摘要。
- `retargeting.json`：`bone_translation_retargeting[]` 与 `use_retarget_modes_from_compatible_skeleton`。只导出 raw bones；virtual bone 没有独立 translation retarget mode，旧 JSON 中如果出现会被 warning 跳过，避免 UE 越界断言。
- `sockets.json`：Skeleton socket 新增、更新、删除。
- `virtual_bones.json`：virtual bone 新增、删除；条目设置 `remove=true` 时，即使同名 virtual bone 已存在也会进入删除路径，apply 后应通过 `skeleton_get_info.virtual_bones[]` 或重新导出确认已移除。
- `slots.json`、`blend_profiles.json`、`smart_names.json`、`animation_metadata.json`：结构占位与摘要。
- `compatible_skeletons.json`：compatible skeleton 列表与开关。
- `preview.json`：preview skeletal mesh。
- `dependencies.json`：preview mesh 等引用摘要。
- `validation/coverage_report.json`、`validation/readback_diff.json`、`validation/diagnostics.json`：覆盖状态、读回 diff 和 JSON 诊断。

`skeleton_apply_folder` 返回：

- `applied` / `dry_run`
- `structured_fields_applied`
- `raw_properties_applied`
- `operations_executed`
- `json_issues[]` / `json_issue_count`
- `property_results[]`
- `readback`
- `validation_report`

示例：

```json
{
  "folder_path": "D:/Project/Saved/UeAssetFolders/Skeleton/Game/Characters/Hero/SK_Hero_Skeleton",
  "strict": true,
  "save_after_apply": false
}
```

### `skeleton_get_info`

当前返回：
- `preview_skeletal_mesh`
- `root_bone_name`
- `bone_count`
- `socket_count`
- `virtual_bone_count`
- `slot_group_count`
- `compatible_skeleton_count`
- `slot_groups[]`
- `sockets[]`
- `virtual_bones[]`
- `compatible_skeletons[]`
- `use_retarget_modes_from_compatible_skeleton`
- `animation_notify_names[]`

说明：
- `compatible_skeletons[]` 和 `use_retarget_modes_from_compatible_skeleton` 适合做 skeleton 级重定向兼容关系回读。
- `slot_groups[]` 和 `animation_notify_names[]` 方便跟 Montage / Sequence 做联动检查。

### `skeleton_set_compatible_skeletons`

说明：
- 这是 skeleton 兼容关系的统一入口，避免继续拆 `add/remove/clear/set_use_retarget_modes` 多条命令。
- `set_compatible_skeleton_paths[]` 表示“整体替换”；`add_*` / `remove_*` 表示增量修改。
- 不允许把自己加为 compatible skeleton。

### `skeleton_set_socket`

说明：
- 不传 `remove` 时，命令会“存在则更新，不存在则创建”。
- 如果只想改偏移，不需要重建 socket。

### `skeleton_set_virtual_bone`

说明：
- 不传 `virtual_bone_name` 时，会让 UE 自动生成标准名字。
- 删除时按 `virtual_bone_name` 删除。

## 当前边界

- `AnimSequence` 当前已经覆盖资产级设置、压缩 / 剥帧设置、float 曲线、骨骼轨删除、metadata 生命周期、普通 notify、notify track、sync marker 和摘要回读。
- 官方 `AnimationBlueprintLibrary` 还存在 `vector / transform` 曲线相关 API，但基于当前 UE 5.6 数据模型实测，它们不够稳定，暂不作为正式稳定命令面对外暴露。
- 还没有继续扩到自定义 notify / notify state 对象的 payload 属性编辑，也没有扩到 `vector / transform` 曲线和更完整的压缩策略管理。
- `Skeleton` 当前聚焦 preview mesh、compatible skeleton、socket、virtual bone 和槽组/通知名回读，没有扩到更细粒度 retarget profile 编辑。

## 2026-04-21 增量更新

- `anim_sequence_set_metadata` 现在支持可选 `metadata_values`
- `anim_sequence_get_info.metadata[]` 现在会回读 `properties`

当前已稳定验证的 metadata 属性编辑范围：

- `FName`
- `FString`
- `FText`
- `bool`
- 数值类型

推荐写法：

```json
{
  "asset_path": "/Game/Anim/A_Idle_Copy",
  "metadata_class_path": "/Script/GptProjectTest.GptAnimMetaTag",
  "metadata_values": {
    "tag": "Stage27Tag",
    "note": "Stage27Note"
  },
  "save_after_set": false
}
```

说明：

- 属性名匹配会忽略大小写、下划线、连字符和空格差异。
- 当前不扩到嵌套 struct / array / object reference。

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/13_AnimationAssets_Skeleton.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。
