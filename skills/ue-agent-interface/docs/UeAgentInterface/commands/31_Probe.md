# 指令详解：Probe / Candidate Search

## Transform Probe

| 指令 | 作用 | 关键参数 | 典型用途 |
|---|---|---|---|
| `probe_actor_transform_candidates` | 对同一个 Actor 依次套用候选移动 / 旋转 / 缩放，截图后恢复原 transform，并输出原始帧 + 候选帧拼接图 | `id`、`candidates[]`；可选 `relative_to_original`、`format`、`quality`、`max_size`、`warmup_frames`、`write_individual_frames`、`create_frame_sheet`、`frame_sheet_max_size` | 在不提交最终变换的前提下，粗搜或细搜物品摆放、朝向、尺寸和动画关键姿势候选 |
| `probe_camera_pixel_scale` | 计算目标点 / Actor 相对当前 Level Viewport 相机的位置，并给出目标深度处屏幕 1 像素横向 / 纵向对应的相机空间距离 | `id` 或 `world_location`；可选 `target_point`、`sample_screen_x`、`sample_screen_y`、`pixel_step` | 需要把“移动多少 cm”换算成“画面上移动多少像素”时，用于候选点步长、精调、相机相关构图和屏幕空间判断 |
| `probe_ik_goal_candidates` | 浏览当前 Level Sequence 中 Control Rig 控制点的候选 transform：F0 来自目标帧未做候选变换的真实 sequence 评估；每个候选只设置同一 Control Rig 当前 control transform、解算、截图并恢复，不复制 sequence、不写 key | `sequence_path`、`control_name`、`candidates[]`；可选 `binding_guid` / `binding_name`、`track_name`、`frame_index` / `time_seconds`、`watched_bones`、`baseline_control_bone_map` 诊断兼容、`mesh_capture_bounds_padding`、`format`、`quality`、`frame_width`、`frame_height`、`write_individual_frames`、`create_frame_sheet` | 在真正给动画关键帧落 key 前，粗搜或细搜 IK / Control Rig 控制点移动、旋转、缩放候选；截图来自实际 sequence/control rig 当前状态解算，并返回骨骼采样和像素差异诊断 |
| `probe_ik_goal_review_frames` | 从最近一次或指定 `probe_ik_goal_candidates` 缓存中按 `F0..Fn` 编号筛选帧，默认重新高分辨率捕获选中帧并生成只包含这些帧的序列帧图 | `frames[]` / `frame_indices[]`；可选 `probe_request_id`、`frame_width`、`frame_height`、`rerender` / `recapture`、`use_cached_pixels`、`format`、`quality`、`frame_sheet_max_size` | 26 图或更多候选看不清时，输入少量编号重新出图确认；保留原 F 编号，不写 key，默认不再放大低清缓存像素 |
| `probe_ik_goal_apply_candidate` | 将最近一次或指定 `probe_ik_goal_candidates` 预览中的某个编号 transform 写回同一个 sequence / binding / Control Rig control 的同一帧 | `number` / `frame_index`；可选 `probe_request_id`、`sequence_path`、`control_name`、`candidate_index`、`save_after_apply` | 看完候选序列帧后，用数字快速把选中的控制点 transform 落到真实 Level Sequence key；legacy cache 才写 IK Rig goal |

### `probe_actor_transform_candidates`

用途：临时探测一个 Actor 的多个候选 transform。命令会先截取原始位置，再按 `candidates[]` 顺序把 Actor 移动 / 旋转 / 缩放到候选状态并截图，最后把 Actor 恢复到调用前 transform。默认会生成一张 frame sheet，便于人工或 LLM 直接比较哪个候选更接近目标。

关键参数：

- `id`：必填，Actor name 或 label。
- `candidates[]`：必填，候选 transform 数组，最多 64 个。每项可直接包含 `location`、`rotation`、`scale`，也可包含 `transform` 对象。
- `label`：可选，候选语义标签；返回 JSON 中保留。sheet 上使用 `F0/F1/...` 短标签，其中 `F0` 是原始状态。
- `relative_to_original`：可选，全局默认 `false`。为 `true` 时候选 `location/rotation` 按原始 transform 的增量解释，`scale` 按原始 scale 的倍率解释。
- `relative` / `relative_to_original`：可选，候选项级覆盖全局相对模式。
- 相对模式别名：`location_offset` / `location_delta` / `delta_location`，`rotation_offset` / `rotation_delta` / `delta_rotation`，`scale_multiplier` / `scale_factor`。
- `format`：可选，`png` / `jpg` / `webp`，默认 `png`。
- `quality`：可选，`1..100`，默认 `90`。
- `max_size`：可选，单帧最大边长，默认 `720`。
- `warmup_frames` / `render_warmup_frames`：可选，截图前刷新帧数，默认 `2`。
- `write_individual_frames`：可选，是否写出每张单帧图，默认 `true`。
- `create_frame_sheet` / `create_sheet`：可选，是否生成拼接图，默认 `true`。
- `frame_sheet_padding` / `frame_sheet_label_scale` / `frame_sheet_max_size`：可选，透传给 frame sheet 生成逻辑。

返回字段：

- `schema`：当前为 `uai.probe.actor_transform_candidates.v1`。
- `actor_name` / `actor_label`：命中的 Actor。
- `candidate_count`：候选数量，不包含原始帧。
- `frame_count`：输出帧数量，包含原始帧。
- `original_transform`：调用前 transform。
- `final_transform`：命令结束时读回 transform，正常应等于 `original_transform`。
- `restored`：是否已执行恢复。
- `frames[]`：原始帧和候选帧记录，包含 `frame_label`、`kind`、`candidate_index`、`candidate_label`、`applied_transform`、尺寸和可选 `file_path`。
- `candidates[]`：候选项摘要，包含候选标签、对应帧号、是否相对模式以及实际应用 transform。
- `frame_sheet` / `frame_sheet_file_path`：拼接图信息和路径。

示例：

```json
{
  "command": "probe_actor_transform_candidates",
  "params": {
    "id": "SM_Table",
    "relative_to_original": true,
    "max_size": 720,
    "frame_sheet_max_size": 2048,
    "candidates": [
      {
        "label": "left_20",
        "location": { "x": 0, "y": -20, "z": 0 }
      },
      {
        "label": "yaw_15",
        "rotation": { "pitch": 0, "yaw": 15, "roll": 0 }
      },
      {
        "label": "scale_110",
        "scale": { "x": 1.1, "y": 1.1, "z": 1.1 }
      }
    ]
  }
}
```

边界：

- 该命令是探测指令，不负责提交最终 authoring 状态。选定候选后，应使用对应资产 / Level Content / 动画写入流程生成真实结果。
- 命令不使用 UE transaction，不调用 `Modify()`，并在命令结束前恢复 Actor transform；但如果外部同时修改同一 Actor，调用者需要自行避免并发。
- sheet 只负责比较候选视觉效果，不替代后续 readback、compile、dirty resource 和任务级验收。

### `probe_camera_pixel_scale`

用途：读取当前 Level Viewport 的相机状态，计算目标 Actor / 世界点相对相机的位置，并在目标深度平面上计算屏幕横向 1 像素、纵向 1 像素分别对应多少相机空间距离。这个指令用于把视觉调整步长从“像素”换算为“cm”，或判断某个物体在当前相机下移动多少才会产生可见画面变化。

关键参数：

- `id`：可选，Actor name 或 label。与 `world_location` 二选一。
- `world_location` / `target_location` / `location`：可选，直接指定目标世界坐标；未传 `id` 时必填。
- `target_point` / `point`：可选，仅 `id` 模式有效。`bounds_center` 默认使用 Actor bounds center；`actor_location` / `origin` / `pivot` 使用 Actor location。
- `sample_screen_x` / `sample_screen_y`：可选，指定用于射线采样的屏幕像素点。默认使用目标投影到屏幕后的坐标；目标在相机后方时使用 viewport 中心但返回 `pixel_scale_valid=false`。
- `pixel_step`：可选，默认 `1.0`。命令会用 `sample_screen_point`、`sample_screen_point + (pixel_step,0)`、`sample_screen_point + (0,pixel_step)` 三条射线与目标深度平面相交，再换算成每 1 像素距离。

返回字段：

- `schema`：当前为 `uai.probe.camera_pixel_scale.v1`。
- `camera`：当前 editor viewport 相机，包含 `location`、`rotation`、`fov`、`forward/right/up` 和 `fov_axis=horizontal`。
- `viewport` / `viewport_size`：实际使用的 Level Viewport 信息。
- `target_source` / `target_point`：目标来源和取点方式。
- `actor_name` / `actor_label` / `actor_bounds`：`id` 模式下返回命中的 Actor 和 bounds。
- `target_world_location`：实际被计算的目标世界坐标。
- `relative_world_location`：目标相对相机世界向量。
- `camera_space_location`：目标相对相机的坐标，`x` 为相机 forward 深度，`y` 为相机 right 偏移，`z` 为相机 up 偏移。
- `distance_to_camera` / `depth_cm` / `in_front` / `in_front_of_camera`：距离、前向深度和是否在相机前方；`in_front` 与 `in_front_of_camera` 等价，前者便于脚本读取。
- `projected_screen_point`：目标投影屏幕坐标，包含 `valid` 和 `in_viewport`。
- `sample_screen_point`：实际用于像素尺度计算的屏幕采样点。
- `pixel_scale_valid`：是否成功计算目标深度处的像素尺度。
- `camera_space_units_per_pixel`：核心结果。`x` 为屏幕横向 1 像素对应的相机 right 方向距离，`y` 为屏幕纵向 1 像素对应的相机 up 方向距离，单位 cm。
- `analytic_camera_space_units_per_pixel`：基于当前水平 FOV、aspect、depth 的解析值，用于交叉校验。
- `world_units_per_pixel`：对应的世界空间向量长度。
- `world_delta_per_pixel_x` / `world_delta_per_pixel_y`：屏幕 x+1 / y+1 像素在世界空间的有向 delta。
- `camera_space_delta_per_pixel_x` / `camera_space_delta_per_pixel_y`：上述 delta 转到相机空间后的有向向量。
- `warnings[]`：目标在相机后方或射线平面相交失败等诊断。

示例：

```json
{
  "command": "probe_camera_pixel_scale",
  "params": {
    "id": "Paladin_PunchPreview",
    "target_point": "bounds_center",
    "pixel_step": 1.0
  }
}
```

边界：

- 当前仅支持 Perspective Level Viewport；正交视口会返回 `viewport_not_perspective`。
- 该命令只读 viewport / Actor 状态，不移动 Actor、不截图、不产生 dirty resource。
- `camera_space_units_per_pixel` 是目标深度平面上的局部尺度。物体本身有厚度时，不同深度处像素尺度会不同；需要精确到骨骼、控制点或碰撞点时应传 `world_location`。

## IK Goal Probe

### `probe_ik_goal_candidates`

用途：浏览当前 Level Sequence 中 Control Rig 控制点的多个候选 transform。命令读取 `sequence_path` 指向的真实 Level Sequence，定位指定 binding 上的 `UMovieSceneControlRigParameterTrack` 和 `control_name`，用一个 UE `LevelSequencePlayer` 跳到目标帧，记录该帧当前 Control Rig control transform 作为 F0 基准。随后每个候选都在同一个已绑定到 sequence 对象的 Control Rig 当前状态上调用 `SetControlLocalTransform(..., EControlRigSetKey::Never)`，解算、刷新 SkeletalMesh、截图；结束后恢复 F0 transform。命令不复制 sequence、不写真实 key、不保存资产、不使用外部模拟。

关键参数：

- `sequence_path`：必填，Level Sequence 资产。
- `control_name`：必填，要浏览的 Control Rig control 名。兼容别名 `goal_name`。
- `binding_guid` / `binding_id`：推荐传入，目标 sequence binding。未传时命令会按 `control_name` 自动寻找唯一的 Control Rig binding；如果匹配多个会失败并要求显式指定。
- `binding_name` / `binding_display_name`：可选，用 binding 名称定位；不如 GUID 稳定。
- `track_name`：可选，同一 binding 上有多条 Control Rig track 时用于消歧。
- `frame_index` / `frame` / `display_frame`：可选，按 sequence display rate 解释的目标帧，默认 `0`。
- `time_seconds` / `seconds`：可选，按 playback range 起点为 0 的相对秒数定位帧。
- `evaluation_frame`：可选，直接传 tick resolution frame；只在需要精确调试时使用。
- `watched_bones` / `probe_bones` / `diagnostic_bones`：可选字符串数组，指定用于验证候选是否真正改变姿态的骨骼。未传时命令会尝试常见人形骨骼；`baseline_control_bone_map` / `control_bone_map` 仅作为兼容诊断 map 和 watched-bone 来源，不会写 baseline controls，也不会改变 F0。
- `candidates[]`：必填，候选数组，最多 64 个。每项可使用 `transform`、`relative_transform` 或 `delta_transform` 表示相对 F0 control transform 的增量；也可使用 `absolute_transform` 或 `mode:"absolute"` 传绝对 control transform。
- `transform.location` / `relative_transform.location`：可选，相对位移 delta，单位 cm。别名：`translation`、`position`、`location_offset`、`delta_location`、`position_offset`、`delta_position`。
- `transform.rotation` / `relative_transform.rotation`：可选，相对欧拉角 delta。别名：`rotation_offset`、`delta_rotation`。
- `transform.scale` / `relative_transform.scale`：可选，相对 scale 倍率。
- `label`：可选，候选语义标签；sheet 上使用 `F0/F1/...`，其中 `F0` 是真实 sequence 原始状态。
- `mesh_capture_bounds_padding` / `bounds_padding`：可选，默认 `1.35`，范围 `1.0..4.0`。命令先求出所有候选帧的 union bounds，再用固定 bounds 做正面 / 侧面正交截图，避免每张图自动重取景掩盖差异。
- `frame_width` / `frame_height`：可选，单帧 tile 尺寸，默认 `1920x1280`。单帧 tile 内包含正面 / 侧面两个子视图，因此默认值会让每个子视图保留接近千像素宽的有效细节。
- `format`：可选，`png` / `jpeg` / `jpg` / `webp`，默认 `png`。
- `quality`：可选，`1..100`，默认 `95`。
- `write_individual_frames`：可选，是否写出每张单帧图，默认 `true`。需要精看某个 F 编号时应优先查看对应 `frames[].file_path`，不要从总 sheet 裁低分辨率图。
- `create_frame_sheet`：可选，是否生成拼接图，默认 `true`。
- `frame_sheet_padding` / `frame_sheet_label_scale` / `frame_sheet_max_size`：可选，透传给 frame sheet 生成逻辑。

返回字段：

- `schema`：当前为 `uai.probe.ik_goal_candidates.v2`。
- `implementation`：当前为 `single_sequence_player_live_control_rig_current_state_no_key_no_sequence_copy`。
- `sequence_path` / `sequence_object_path`：目标 Level Sequence。
- `binding_guid` / `binding_name`：实际使用的 binding。
- `control_name` / `control_type` / `control_rig_class`：实际使用的 Control Rig control 信息。
- `sequence_frame_index` / `sequence_time_seconds` / `evaluation_frame`：被预览的真实 sequence 帧。
- `original_control_transform`：F0 当前帧 control transform，也是相对候选的基准。
- `restored_control_transform` / `restored`：命令结束时恢复后的 control transform 和恢复结果。
- `writes_sequence_keys=false`、`duplicates_sequence=false`、`uses_external_simulation=false`：明确该指令只做当前状态预览，不提交 authoring 数据。
- `visual_validation_passed` / `pose_sample_validation_passed`：候选与 F0 的像素差异 / watched-bone 差异是否至少有一项超过阈值。它们是诊断结果，不会替代用户对 sheet 的判断。
- `union_bounds`：所有输出帧共同使用的截图 bounds。
- `watched_bones` / `warnings[]`：实际用于姿态差异诊断的骨骼和警告。
- `frames[]`：原始帧和候选帧记录，包含 `frame_label`、`kind`、`candidate_index`、`candidate_label`、`requested_control_transform`、`applied_control_transform`、`delta_transform`、`readback_matches_request`、`bounds`、`bone_samples[]`、`max_bone_location_delta_from_f0`、`mean_pixel_diff_from_f0`、尺寸和可选 `file_path`。
- `candidates[]`：候选项摘要，包含候选标签、对应帧号、`transform_mode`、`control_transform`、`delta_transform`、姿态 / 像素差异字段。
- `frame_sheet` / `frame_sheet_file_path`：拼接图信息和路径。
- `probe_request_id`：本次预览在当前 Editor 会话内缓存的 key；后续传给 `probe_ik_goal_apply_candidate.probe_request_id`。

示例：

```json
{
  "command": "probe_ik_goal_candidates",
  "params": {
    "sequence_path": "/Game/UAI/RightPunch/Seq_RightPunch_Blocking",
    "binding_guid": "0f4a8c9e-3998-4ef0-9c2f-33f8ef1d4b21",
    "control_name": "hand_r_ik_ctrl",
    "frame_index": 12,
    "watched_bones": ["RightHand", "RightForeArm", "RightArm", "Spine2", "Hips"],
    "mesh_capture_bounds_padding": 1.35,
    "frame_sheet_max_size": 1800,
    "candidates": [
      { "label": "forward_20", "transform": { "location": { "x": 20, "y": 0, "z": 0 } } },
      { "label": "forward_45", "transform": { "location": { "x": 45, "y": 0, "z": 0 } } },
      { "label": "forward_down", "transform": { "location": { "x": 45, "y": 0, "z": -12 } } },
      {
        "label": "forward_twist",
        "transform": {
          "location": { "x": 55, "y": -8, "z": -8 },
          "rotation": { "pitch": 0, "yaw": 8, "roll": -12 }
        }
      }
    ]
  }
}
```

边界：

- F0 必须来自实际 sequence 在目标帧的未修改状态；如果 F0 不对，应先修复 sequence、Control Rig、AnimSequence、Backward Solve 或 bake 流程，而不是在 probe 指令里伪造 baseline。
- 候选预览只改变当前 Control Rig transient state，不写 key。只有 `probe_ik_goal_apply_candidate` 会把选中候选写回原 sequence。
- 如果 `readback_matches_request=true` 但 `visual_validation_passed=false` 或 `pose_sample_validation_passed=false`，说明 control 值已被设置但当前 Control Rig / Sequencer 求值没有让 watched bones 或截图发生可见变化；应检查 control 是否参与求解、Control Rig 正反向流程、solver effector、binding 和 watched bones。
- 截图由 UE 内部 SceneCapture 对真实绑定对象生成，单帧内包含正面 / 侧面两个视角；不是外部图片模拟。捕获时会关闭眼适应，并使用临时无阴影补光提高姿态轮廓可读性。
- cache 仅存在于当前 Editor 进程内；重启 UE 后必须重新执行预览。

### Legacy IK Rig Asset Mode

`probe_ik_goal_candidates` 不再支持未绑定到 Level Sequence 的 IK Rig asset preview 路径。传 `asset_path` / `goal_name` 且不传 `sequence_path` 会失败并返回 `missing_sequence_path`。IK Rig asset 级求解调试应使用 `ik_rig_preview_solve` 等专用 IK Rig 指令；Control Rig / Sequencer 动画 authoring 必须使用 sequence/control-rig 主路径。

### `probe_ik_goal_review_frames`

用途：在执行过 `probe_ik_goal_candidates` 后，从当前 Editor 会话内的候选缓存中按序列帧图编号筛选少量帧，重新生成一张只包含这些帧的 frame sheet。sequence/control-rig 主路径默认会复用缓存中的 sequence、binding、control、帧号和 control transform，对选中帧重新做 transient 评估并重新高分辨率捕获；不写 key、不复制 sequence。输出图上的标签保持原始 `F0..Fn`，便于看清后继续把同一个编号传给 `probe_ik_goal_apply_candidate`。

关键参数：

- `frames[]` / `frame_indices[]` / `frame_indexes[]` / `numbers[]` / `selections[]`：推荐入口，数组值对应上一张候选图上的 `F0..Fn` 编号；支持数字、`"F20"` 字符串或包含 `frame_index` / `number` 的对象。只查看候选状态时不需要包含 `0`；只有需要和原始状态并排对比时才把 `F0` 加入选择。
- `frame_index` / `frame_number` / `number` / `index` / `selection`：可选单帧入口；主要用于快速只复看一个编号。
- `probe_request_id` / `candidate_cache_request_id`：可选，指定某次 `probe_ik_goal_candidates` 的 cache key。未提供时使用当前 Editor 会话内最近一次 IK goal probe。
- `rerender` / `recapture` / `rerender_selected_frames`：可选，sequence/control-rig 主路径默认 `true`。为 `true` 时只使用缓存元数据和 transform，重新解算并重新截图；为 `false` 时沿用缓存像素。
- `use_cached_pixels`：可选，默认 `false`。显式设为 `true` 时使用旧的缓存像素重排路径；该模式不能提升清晰度，只适合快速重排或排查缓存。
- `frame_width` / `frame_height`：可选，重捕获单帧 tile 尺寸，默认不低于 `1920x1280`，且不会低于源 probe 的 tile 尺寸。
- `mesh_capture_bounds_padding` / `bounds_padding`：可选，重捕获 bounds padding，默认沿用源 probe。
- `format`：可选，`png` / `jpeg` / `jpg` / `webp`，默认沿用源 probe 格式。
- `quality`：可选，`1..100`，默认沿用源 probe quality。
- `frame_sheet_padding` / `frame_sheet_label_scale` / `frame_sheet_max_size`：可选，透传给 frame sheet 生成逻辑；复看少量帧时可设更大的 `frame_sheet_max_size` 保持细节。

返回字段：

- `schema`：当前为 `uai.probe.ik_goal_review_frames.v1`。
- `implementation`：sequence/control-rig 默认为 `sequence_control_rig_recapture_selected_frames_no_key`；显式 `use_cached_pixels=true` 时为 `cached_probe_frame_pixels_no_sequence_eval_no_key`。
- `source_probe_request_id` / `probe_request_id`：使用的源候选缓存。
- `selection_semantics=frame_index_matches_source_sheet_label`、`label_mode=source_frame_label`：表示输入和输出标签都按源图 `F0..Fn` 编号解释。
- `requested_frames[]`：调用者请求的编号数组。
- `source_frame_count` / `selected_frame_count` / `frame_count`：源缓存帧数和本次输出帧数。
- `frames[]`：被选中的源帧摘要，包含 `source_frame_index`、`source_frame_label`、`kind`、`candidate_index`、`candidate_label`、`control_transform`、`rerendered` 和可选 `delta_transform`。
- `frame_sheet` / `frame_sheet_file_path`：新生成的筛选后拼接图。
- `reuses_cached_pixels` / `rerenders_selected_frames` / `evaluates_sequence`：说明本次是重捕获还是缓存像素重排。
- `writes_sequence_keys=false`、`duplicates_sequence=false`、`uses_external_simulation=false`：明确该命令只做预览，不提交 authoring 数据。

示例：

```json
{
  "command": "probe_ik_goal_review_frames",
  "params": {
    "probe_request_id": "probe_right_hand_f12_candidates",
    "frames": [20, 22, "F23"],
    "frame_width": 2400,
    "frame_height": 1600,
    "frame_sheet_max_size": 4096,
    "frame_sheet_label_scale": 2
  }
}
```

边界：

- cache 仅存在于当前 Editor 进程内；重启 UE 后必须重新执行 `probe_ik_goal_candidates`。
- 该命令只复看 `probe_ik_goal_candidates` 缓存的帧编号和 transform；它不是新的候选搜索，也不会应用 transform。
- sequence/control-rig 主路径默认重新捕获，因此不会因为源 sheet 或源缓存像素低清而继续低清。只有 `use_cached_pixels=true` 时才要求旧帧像素仍在缓存中；若旧帧像素因内存上限被释放，会返回 `probe_frame_pixels_not_available:F<n>`。
- `F0` 在 review 中允许显示，但它只是可选 baseline 参考帧，不是查看候选状态的必选项，也不能作为 `probe_ik_goal_apply_candidate` 的应用目标。

### `probe_ik_goal_apply_candidate`

用途：在执行过 `probe_ik_goal_candidates` 并查看 `F0..Fn` 序列帧图后，按数字快速把某个候选 transform 应用到同一个目标。若 cache 来自 sequence/control-rig 主路径，命令只写回同一个 Level Sequence、同一个 binding、同一个 Control Rig control、同一个 frame 的目标 control key；不会写任何 baseline controls。若 cache 来自 legacy IK Rig asset 路径，才写回 IK Rig goal `CurrentTransform`。

关键参数：

- `frame_index` / `frame_number` / `number` / `index` / `selection`：推荐入口，对应序列帧图上的 `F0..Fn` 数字。sequence 主路径中 `F0` 是原始帧，不能作为应用目标；选择候选请用 `F1..Fn`。
- `candidate_index`：可选替代入口，按 `candidates[]` 的 0 基下标选择候选；例如 `candidate_index=0` 对应 `F1`。不要和 `frame_index` 同时使用；同时存在时优先 `frame_index`。
- `probe_request_id` / `candidate_cache_request_id`：可选，指定某次 `probe_ik_goal_candidates` 返回的 cache key。未提供时使用当前 Editor 会话内最近一次 IK goal probe。
- `sequence_path` / `control_name`：sequence 主路径的可选安全校验字段；传入时必须与 cache 一致，否则失败。
- `asset_path` / `goal_name`：legacy IK Rig asset 路径的可选安全校验字段。
- `save_after_apply` / `save_after_set`：可选，默认 `false`。sequence 主路径中为 `true` 时保存 Level Sequence；legacy 路径中保存 IK Rig asset。

返回字段：

- sequence 主路径 `schema`：`uai.probe.ik_goal_apply_candidate.sequence_control_rig.v1`。
- `context_mode`：`sequence_control_rig` 或 legacy `ik_rig_asset`。
- `probe_request_id`：使用的预览 cache key。
- sequence 主路径返回 `sequence_path`、`binding_guid`、`control_name`、`control_type`、`sequence_frame_index`、`evaluation_frame`。
- `applied_frame_index` / `applied_frame_label`：实际应用的序列帧编号。
- `applied_candidate_index`：对应候选下标。
- `original_control_transform` / `previous_control_transform` / `applied_control_transform` / `final_control_transform`：sequence 主路径的写前、目标和写后读回 transform。
- `delta_transform`：候选相对原始 transform 的 delta。
- `baseline_mode` / `baseline_control_count` / `baseline_controls[]` / `baseline_controls_applied`：sequence 主路径当前返回 `control_transform`、`0`、空数组、`false`；不再应用 baseline controls。
- `ignored_cached_baseline_control_count`：兼容旧 Editor 会话缓存的诊断字段；新缓存应为 `0`。
- `already_applied`：应用前是否已经等于目标 transform。
- `applied_matches_selected`：写后读回是否与选择的 transform 匹配。
- `saved`：是否保存资产。
- `selection_semantics`：本次数字按 `frame_index_matches_sheet_label` 还是 `candidate_index_zero_based` 解释。

错误与保护语义：

- sequence 主路径在读回 `previous_control_transform` / `final_control_transform` 和调用 `AutoSetTangents` 前，会重置并强制触发 Control Rig section 的 `ChannelProxy` 懒重建，再校验 float channel map；这用于规避 UE `EvaluateTransformParameter` / `EvaluateVectorParameter` 对非法 channel 下标直接 assert 的问题。
- 若重建后 channel map 仍然缺失、越界或包含空 channel，命令返回失败，不再调用不安全的 UE 读回/切线路径。典型错误包括 `control_rig_float_channel_map_missing`、`control_rig_float_channel_range_invalid:...`、`control_rig_float_channel_null:...`。
- 这些错误表示当前 Level Sequence / Control Rig section 的 Sequencer channel 状态已不适合继续写入；应先重新生成 probe cache、重建或修复对应 Control Rig track/section，再继续应用候选。

示例：

```json
{
  "command": "probe_ik_goal_apply_candidate",
  "params": {
    "probe_request_id": "probe_right_hand_f12_candidates",
    "frame_index": 2,
    "sequence_path": "/Game/UAI/RightPunch/Seq_RightPunch_Blocking",
    "control_name": "hand_r_ik_ctrl",
    "save_after_apply": false
  }
}
```

边界：

- cache 仅存在于当前 Editor 进程内；重启 UE 后必须重新执行 `probe_ik_goal_candidates`。
- sequence 主路径会改变 Level Sequence key 数据；未保存时会产生 dirty resource。
- 应用候选后仍需继续做逐帧、正面 / 侧面视觉验收，必要时再以更小候选尺度继续 probe。
