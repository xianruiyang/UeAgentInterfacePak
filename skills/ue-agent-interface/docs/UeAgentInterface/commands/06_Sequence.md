# 指令详解：Sequence

> 废弃写入命令已迁移到 `deprecatedCommand/06_Sequence.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

覆盖 `Level Sequence` 与 `UMG Animation` 两部分。

## Level Sequence

| 指令 | 作用 | 关键参数 | 说明 |
|---|---|---|---|
| `sequence_list_level_sequences` | 列出序列资产 | `root_path`、`limit` | 资产检索 |
| `sequence_create_level_sequence` | 创建关卡序列 | `asset_path`、`start_seconds`、`duration_seconds`、`display_rate_num`、`display_rate_den`、`open_editor`、`allow_editor_open` | open_editor=true 时必须同时传 allow_editor_open=true |
| `sequence_open_level_sequence` | 打开 Sequencer | `asset_path`、`allow_editor_open` | 进入编辑上下文；必须显式传 allow_editor_open=true |
| `sequence_get_level_sequence_info` | 读取序列摘要 | `asset_path` | 返回 binding / track / section 摘要 |
| `sequence_screenshot` | 按帧/时间截取 Level Sequence 画面，也可批量输出连续序列帧总览图 | `asset_path`、`frame_index`、`time_seconds`、`start_frame_index`、`count`、`frame_interval`、`start_time_seconds`、`interval_seconds`、`format`、`quality`、`max_size`、`target`、`create_frame_sheet`、`write_individual_frames`、`frame_sheet_padding`、`frame_sheet_max_size`、`frame_sheet_label_scale` | 用临时 LevelSequencePlayer 求值，并通过临时 SceneCapture 输出；多帧默认只写一张带帧号标注的合成 sheet |
| `sequence_export_folder` | 导出文件夹式 JSON 子集与完整结构清单 | `asset_path`；可选 `clean_output_dir`、`include_validation`、`include_complete_inventory` | 当前推荐的 `Level Sequence` 主编辑路径；会写出 coverage/roundtrip 边界，默认额外写出 `complete/inventory.json` |
| `sequence_apply_folder` | 从文件夹式 JSON 子集回写 | `asset_path`；可选 `create_if_missing`、`save_after_apply`、`strict`、`replace_mode`、`verify_after_apply`、`auto_force_skeletal_custom_mode_for_control_rig`、`fail_on_warnings`、`fail_on_unsupported_tracks`、`fail_on_partial_roundtrip`、`fail_on_structural_diff`、`structural_diff_max_entries` | 读取 `Saved/UeAssetFolders/LevelSequence` 下的结构化目录；默认 patch，显式 replace 才删除旧轨道 |

> UI 安全边界：常规 Sequence 自动化应使用 `sequence_export_folder`、`sequence_apply_folder`、`sequence_get_level_sequence_info` 和 `sequence_screenshot`，这些路径不会打开 Sequencer 编辑器。只有人工检查或明确需要编辑器 UI 时才使用 `sequence_open_level_sequence`，并必须传 `allow_editor_open=true`；`sequence_create_level_sequence(open_editor=true)` 也遵守同一授权要求。缺少授权时分别返回 `sequence_open_level_sequence_requires_allow_editor_open` 或 `open_editor_requires_allow_editor_open`。

## 文件夹式工作流

- `sequence_export_folder / sequence_apply_folder`
  - 这是 `Level Sequence` 当前推荐的主编辑路径。`tracks/*.json` 是面向自动化制作的常用 Sequencer authoring 子集；`complete/inventory.json` 是只读完整结构清单，用来作为核对 UE 真实 Sequencer 对象层级、UE class、section 和 raw UPROPERTY 的参照。
  - 固定导出根目录：`Saved/UeAssetFolders/LevelSequence`
  - 当前第一版稳定结构：
    - `asset.json`
    - `settings/sequence.json`
    - `bindings/index.json`
    - `bindings/<Binding>/binding.json`
    - `bindings/<Binding>/tracks/*.json`
    - `outliner/folders.json`
    - `master_tracks/index.json`
    - `validation/checks.json`
    - `validation/coverage_report.json`
    - `complete/inventory.json`
  - 当前稳定导出/回写的轨道类型：
    - `spawn`
    - `transform`
    - `skeletal_animation`
    - `control_rig`
    - `visibility`
    - `property`
      - `float`
      - `double`
      - `bool`
      - `integer`
      - `color`
      - `byte`
      - `string`
      - `vector`
      - `rotator`
      - `actor_reference`
      - `object`
  - 当前 `binding.json` 会额外导出 `binding_kind`、`parent_binding_guid` 与常见 `bound object` 摘要。
  - 当前 `apply_folder` 已能自动恢复：
    - 常见 `Actor possessable`
    - 常见 `ActorComponent possessable`
    - 常见 `Actor spawnable`
  - 其中 `ActorComponent possessable` 当前依赖父 binding 或 owner actor 身份可解析。
  - `outliner/folders.json` 当前已稳定支持：
    - 根 folder / 子 folder
    - `child_binding_guids`
    - `child_binding_tracks`
      - 当前稳定轨道类型：
        - `spawn`
        - `transform`
        - `skeletal_animation`
        - `control_rig`
        - `visibility`
        - `property(float/double/bool/integer/color)`
    - `child_master_tracks`
      - `camera_cut`
      - `sub_sequence`
      - `cinematic_shot`
  - `master_tracks/index.json` 当前已导出真实摘要，并已纳入第一版稳定 apply：
    - `camera_cut`
    - `sub_sequence`
  - `cinematic_shot` 当前已完成独立 smoke 验证，纳入稳定 master track apply 面。
  - `tracks/*.json` 是 authoring 文件，不再写入 round-trip 诊断字段；诊断统一查看 `validation/coverage_report.json.tracks[]`，完整只读清单可查看 `complete/inventory.json.tracks[]`。
    - `ue_class`：仍保留在 track authoring 文件中，用于识别真实 UE track class，但不作为写入字段。
    - `roundtrip_status`：`partial_roundtrip`、`readonly_summary` 或 `unsupported`；当前 Sequence folder profile 不再把自身描述成完整 Sequencer 真源。
    - `apply_support`：`supported_partial` 或 `unsupported`。
    - `is_lossless_roundtrip` / `roundtrip_lossy`：是否可视为无损。当前常见轨道多数仍为 `partial_roundtrip`，因为复杂绑定、结构引用、特殊 channel 类型和 editor-only 状态没有完整表达；常见 channel 的默认值、key、interpolation 和 tangent 已由 section `channels[]` 表达。
    - `source_section_count`、`exported_section_count`、`exported_key_count`：用于快速判断是否发生 section 压缩或摘要导出。
    - `roundtrip_notes[]`：说明该轨道为什么是 partial、readonly 或 unsupported。
  - 每个已导出的 section 会尽量包含 `section_metadata`：
    - `section_class`、`section_path`
    - `has_start_frame`、`has_end_frame`、`start_frame`、`end_frame`、`start_seconds`、`end_seconds`、`duration_frames`、`duration_seconds`
    - `row_index`、`overlap_priority`
    - `is_active`、`is_locked`
    - `pre_roll_frames`、`post_roll_frames`
    - `color_tint`
    - `sequence_apply_folder` 会回写这些通用字段；easing、blend、condition、custom time-warp 等高级状态仍由 coverage 标记为 partial。
  - 每个已导出的 section 会额外包含 `channels[]`，作为曲线/离散通道真源层：
    - 当前覆盖 `double`、`float`、`bool`、`integer`、`byte`、`string` channel。
    - `channel_index` 是同类型 channel 在该 section 的 `ChannelProxy` 中的索引，用于按 UE 实际 channel 顺序回写。
    - `has_default/default_value` 记录 channel 默认值；`sequence_apply_folder` 会同步设置或移除默认值。
    - `keys[]` 记录每个 channel 的真实 frame/time/value。
    - `double` / `float` key 额外记录 `interp_mode`、`tangent_mode`、`tangent.arrive_tangent`、`tangent.leave_tangent`、`tangent.arrive_tangent_weight`、`tangent.leave_tangent_weight`、`tangent.tangent_weight_mode`。
    - 回写顺序是先按 authoring schema 重建基础轨道/key，再用 `channels[]` 覆盖 UE channel 的默认值、键、插值和 tangent，避免专用 add-key 命令丢失曲线形状。
    - 尚未覆盖的特殊 channel 类型、结构引用和 editor-only 状态仍由 coverage 标记为 partial，并需要专门 schema。
  - `asset.json`、`settings/sequence.json`、`tracks/*.json` 和 section 对象会导出 `raw_properties[]` / `sequence_raw_properties[]` / `movie_scene_raw_properties[]`：
    - 每项记录 `property_name`、`authored_name`、`cpp_type`、`property_class`、`value_text`、`property_flags`、`editable`、`blueprint_visible`、`transient`、`deprecated`、`edit_const`、`structural`、`reference_like`、`container_like`、`can_apply_raw`。
    - `value_text` 来自 UE `FProperty::ExportTextItem_Direct`，用于表达当前 UPROPERTY 的真实文本值。
    - `sequence_apply_folder` 只回写 `can_apply_raw=true` 的字段，并在写回后立即导出读回值；若读回值不同，会返回 warning。
    - 默认允许写回的 raw 字段必须同时满足：`CPF_Edit`、非 `Transient`、非 `Deprecated`、非 `EditConst`、非 Sequencer 结构字段、非对象/类/软引用、非 array/map/set 容器。
    - 被阻断字段会保留在 JSON 中，并通过 `raw_apply_block_reasons[]` 标明原因；它们是诊断真源，不是可直接写回的 authoring 字段。
    - 结构字段包括 `MovieScene`、`ObjectBindings`、`Possessables`、`Spawnables`、`Tracks`、`CameraCutTrack`、`RootFolders`、`MarkedFrames`、`ChannelProxy`、`EvaluationField`、`CompiledDataManager`、`NodeGroups` 等，避免 raw import 破坏 Sequencer 对象图。
  - `complete/inventory.json`：
    - `schema=uai.sequence.complete_inventory.v1`
    - `source_of_truth_role=readonly_complete_sequencer_inventory`
    - `writeback_contract=folder_authoring_subset_plus_common_section_metadata_plus_safe_raw_uproperty_text`
    - 记录真实 `LevelSequence` / `MovieScene` 路径、类、display rate、tick resolution、playback range、evaluation type、clock source，并导出 `sequence_raw_properties[]` 与 `movie_scene_raw_properties[]`。
    - 按 binding/master track 列出所有真实 track、section、UE class、section metadata、raw properties、channels、class counts，并嵌入 `BuildMovieSceneTrackSummary` 摘要。
    - 该文件是“读完整、写回受控”的真源清单；常用 authoring JSON 会消费安全 raw 字段和 common channel 字段，但复杂引用、容器、结构对象图、特殊 channel 类型和 editor-only 状态仍必须通过专门 schema 或后续命令补齐，不得把它理解为已经能无损重建任意 Sequencer 资产。
  - `validation/coverage_report.json` 汇总本次导出覆盖面：
    - `implementation_status=partial_folder_profile`
    - `authoring_contract=curated_common_subset_not_full_ue_sequencer_model`
    - `is_complete_target_schema=false`
    - `is_lossless_roundtrip`、`partial_roundtrip_track_count`、`readonly_summary_track_count`、`unsupported_track_count`
    - `blocking_gaps[]` 和每条轨道的 coverage 明细
  - `sequence_apply_folder` 的安全参数：
    - `replace_mode=patch`：默认行为；只清空/重建 JSON 命中的已有 track section，不删除 JSON 未提到的旧轨道。
    - `replace_mode=replace_binding_tracks`：应用每个 binding 前先删除该 binding 下所有旧轨道，再按 folder JSON 重建。
    - `replace_mode=replace_all_tracks`：在 `replace_binding_tracks` 基础上，还会删除并重建 master tracks。
    - `strict=true`：默认等价于 `fail_on_warnings=true` 与 `fail_on_unsupported_tracks=true`；存在运行时 warning 或输入 coverage 中含 readonly/unsupported track 时失败。
    - `fail_on_partial_roundtrip=true`：把输入 coverage 中的 `partial_roundtrip` 也作为失败条件；由于当前 profile 本质是常用子集，这个开关通常用于验证是否意外依赖了非无损能力。
    - `verify_after_apply=true`：默认开启；返回 `post_apply_coverage_report`、`coverage_diff` 和 `structural_diff`，用于确认 UE 当前真实 Sequence 中的轨道覆盖状态及输入/写回后的结构差异。
    - `auto_force_skeletal_custom_mode_for_control_rig=true`：默认开启。同一 binding 同时存在 `skeletal_animation` 与 `control_rig` 轨道时，回写 skeletal animation section 会强制 `force_custom_mode=true`，让 Sequencer 用自己的动画实例提供 base pose，避免 AnimBP 驱动角色在叠加 Control Rig 时基础姿态漂移。确需完全按 JSON 字段回写时可显式设为 `false`。
    - `structural_diff`：schema 为 `uai.sequence.folder_structural_diff.v1`；返回 `input_entry_count`、`post_entry_count`、`missing_entry_count`、`extra_entry_count`、`changed_entry_count`、`is_structurally_equal`、`missing_entries_in_post_apply`、`extra_entries_in_post_apply` 和 `changed_entries`。该比较使用“有效 authoring 语义”作为 canonical 面：track 文件按轨道语义 key 匹配，`keys[]` 会覆盖 `channels[]`，对象路径/package 路径会归一化，binding 内嵌 track 摘要、导出注解、不可回写 raw track 属性、空 channel 和等价 Control Rig transform 类型不会造成假差异。
    - `structural_diff_max_entries`：限制 `changed_entries` 返回明细数量，默认 `50`；每条 changed entry 会返回 canonical 长度、首个差异位置和裁剪后的差异窗口，便于继续补齐缺口。
    - `fail_on_structural_diff=true`：在 `verify_after_apply=true` 且 structural diff 不可用或 `is_structurally_equal=false` 时让命令失败；默认 `false`，不破坏旧脚本。
    - 返回字段 `raw_properties_applied`：本次通过安全 raw UPROPERTY 机制成功 import 的字段数量，覆盖 Sequence、MovieScene、已支持 Track 和 Section 层级。
    - 返回字段 `channels_applied`：本次通过 `channels[]` 成功回写的 section channel 数量。
    - 返回字段 `auto_fix_count` / `auto_fixes[]`：本次由命令语义自动修正的项目。Control Rig 叠加骨骼动画时，`skeletal_animation_sections_force_custom_mode_for_control_rig` 记录被强制开启 `force_custom_mode` 的 skeletal animation section 数。
  - 推荐方法：
    1. `sequence_create_level_sequence`
    2. `sequence_export_folder`
    3. 编辑结构化目录
    4. `sequence_apply_folder`
    5. 再次 `sequence_export_folder`，基于 UE 补全后的真实结构继续补字段
    6. `sequence_get_level_sequence_info`

## 通用属性轨道

> 废弃写入命令已迁移到 `deprecatedCommand/06_Sequence.md` 的对应章节。

`property_type` 当前支持：

- `bool`
- `byte`
- `double`
- `float`
- `integer`
- `color`
- `rotator`
- `vector`
- `actor_reference`
- `object`
- `string`

公共参数：

- `property_path`
  - 不填时默认等于 `property_name`
  - 组件或嵌套属性建议显式填写完整路径
- `save_after_set`

按类型的差异：

- `bool`
  - `value`
  - 可选 `value_before_key`
- `byte`
  - 可直接使用数值 `value`
  - 也可配合 `enum_path` 使用 `value_name`
  - 可选 `value_before_key` 或 `value_before_key_name`
- `double`
  - `value`
  - 可选 `value_before_key`
- `float`
  - `value`
  - 可选 `value_before_key`
- `integer`
  - `value`
  - 可选 `value_before_key`
- `color`
  - 可传顶层 `red/green/blue`
  - 可选 `alpha`
  - 也可传 `value:{r,g,b,a}`
  - 可选 `value_before_key:{...}`
- `rotator`
  - 推荐传 `value:{pitch,yaw,roll}`
  - 可选 `value_before_key:{pitch,yaw,roll}`
  - 也支持顶层 `pitch/yaw/roll`
- `vector`
  - 推荐传 `value:{x,y,z,w}`
  - 可选 `value_before_key:{x,y,z,w}`
  - 也支持顶层 `x/y/z/w`
  - 可选 `vector_precision=float|double`
  - 可选 `channels_used=2|3|4`
  - 也支持直接用 `property_type=vector2d/vector3d/vector4d/vector2f/vector3f/vector4f`
- `actor_reference`
  - 推荐传 `value_actor_id`
  - 也支持 `value_binding_guid`
  - 可选 `value_before_key_actor_id` 或 `value_before_key_binding_guid`
  - 可选 `component_name/socket_name`
  - 前置值也支持 `value_before_key_component_name/socket_name`
- `object`
  - 需要 `property_class_path`
  - key 值使用 `value_path`
  - 可选 `value_before_key_path`
  - 为了稳定，仍建议显式传 `property_class_path`
- `string`
  - `value`
  - 可选 `value_before_key`

典型场景：

- `byte`
  - 适合 `uint8` 或枚举属性
  - 若是枚举，建议显式传 `enum_path`
- `rotator`
  - 适合 `FRotator` 属性
  - 常见场景如组件 `RelativeRotation`
- `vector`
  - 适合 `FVector2D / FVector / FVector4 / FVector2f / FVector3f / FVector4f`
  - 常见场景如组件 `RelativeScale3D`、`RelativeLocation` 等向量属性
- `actor_reference`
  - 适合 `AActor*` 或派生 Actor 引用属性
  - 常见场景是“一个 Actor 指向关卡内另一个 Actor”的编辑器关系
- `object`
- `string`
  - 例如 `StaticMeshComponent.StaticMesh`
  - 其它 `UObject*` / 资源引用属性

## `sequence_get_level_sequence_info`

当前除了基础字段，还会返回：

- `master_tracks[]`
- `bindings[]`
- `bindings[].tracks[]`
- `tracks[].sections[]`

当前已补 section 摘要的类型：

- `visibility`
- `bool`
- `byte`
- `double`
- `float`
- `integer`
- `color`
- `rotator`
- `vector`
- `actor_reference`
- `object`
- `transform`
- `skeletal_animation`
- `control_rig`
- `widget_transform`

其中：

- `byte` 会返回 `key_count`
- `color` 会返回 `red/green/blue/alpha_key_count`
- `rotator` 会返回 `pitch/yaw/roll_key_count`
- `vector` 会返回 `vector_precision`、`channels_used` 以及 `x/y/z/w_key_count`
- `actor_reference` 会返回 `key_count`、`default_binding_guid`
- `object` 会返回 `key_count`、`default_value_path`
- `string` 会返回 `key_count`
- `skeletal_animation` 会返回 `animation_asset`、`slot_name`、`play_rate`、`reverse` 等摘要
- `control_rig` 会返回 `control_rig_class`、`is_additive`、section 摘要与控制通道 key 数

### `sequence_apply_folder` 的 `control_rig` 轨道

`bindings/<Binding>/tracks/*.json` 可写入：

```json
{
  "track_type": "control_rig",
  "track_name": "FK Control Rig",
  "display_name": "FK Control Rig",
  "control_rig_class": "/Script/ControlRig.FKControlRig",
  "is_additive": false,
  "sections": [
    {
      "section_type": "control_rig",
      "keys": [
        {
          "time_seconds": 0.0,
          "control": "hand_r",
          "value": {
            "location": {"x": 0, "y": 0, "z": 0},
            "rotation": {"pitch": 0, "yaw": 0, "roll": 0},
            "scale": {"x": 1, "y": 1, "z": 1}
          }
        }
      ]
    }
  ]
}
```

说明：

- `control_rig_class` 可传 `UControlRig` 派生类路径，也可传 Control Rig Blueprint 资产路径；不传时默认使用 `/Script/ControlRig.FKControlRig`。
- 每个 key 需要 `control` 或 `control_name`，并需要 `time_seconds` 或 `frame`。`frame` 使用序列 display rate。
- `control_type` 仅作为导出可读字段；回写时以实际 Control Rig control 类型为准。
- 支持的 control 类型：`float/scale_float`、`bool`、`integer/enum`、`vector2d`、`position`、`scale`、`rotator`、`transform/euler_transform/transform_no_scale`。
- `rotator` 使用 `{ "pitch": ..., "yaw": ..., "roll": ... }`；`transform` 使用 `location/rotation/scale`，缺省 scale 时按 `(1,1,1)`。
- 当前 apply 会把多个 `sections[]` 的 key 合并到一个 Control Rig section，并返回 warning；需要多 section 精确语义时应先小步验证。

## `sequence_screenshot`

说明：

- 用于 Level Sequence 选帧审查，按 `frame_index` 或 `time_seconds` 把指定序列求值到目标帧并输出图片。
- 批量审查镜头阶段时，使用 `start_time_seconds + count + interval_seconds`，或 `start_frame_index + count + frame_interval` 一次输出连续序列帧。`frame_index` 使用序列 display rate，且相对 playback start 计算。
- 命令会在编辑器世界中创建临时 `LevelSequencePlayer` 与临时 `SceneCapture2D`，不保存关卡，不启动 PIE。结束时停止 player、销毁临时 actor，并在原关卡干净时恢复 dirty flag。
- 有 Camera Cut 时优先使用序列当前激活 camera；没有 Camera Cut 时默认回退到当前 Level Viewport 相机。可传 `fallback_to_viewport_camera=false` 强制要求序列相机。
- 单帧模式返回单张帧图。多帧模式默认只写一张序列帧总览图，`file_path`、`frame_sheet_file_path` 与 `sequence_frame_image_path` 都指向该图；每个格子左上角标注 `F<frame_index>`。
- `frames[]` 始终返回每个采样帧的 metadata，包括 `frame_index`、`time_seconds`、`frame_label`、相机来源和 tile 尺寸。默认不再给每帧写单独图片；如需兼容旧流程，可传 `write_individual_frames=true`。
- 可传 `create_frame_sheet=false` 关闭总览图；若同时没有 `write_individual_frames=true`，命令会返回 `multi_frame_output_disabled`。总览图统一按最小正方形网格排布，即 `ceil(sqrt(frame_count)) x ceil(sqrt(frame_count))`，不足格子留空；`frame_sheet_padding` 控制间距；`frame_sheet_max_size` 控制总览图最长边；`frame_sheet_label_scale` 控制帧号字号。
- 批量模式上限为 120 张；若请求帧超出 playback range，会失败并返回 `preview_frame_range_exceeds_sequence`，避免尾帧重复误导判断。

示例：

```json
{
  "command": "sequence_screenshot",
  "params": {
    "asset_path": "/Game/Cinematics/LS_Test",
    "start_frame_index": 0,
    "count": 8,
      "frame_interval": 12,
      "format": "png",
      "max_size": 1280,
      "target": "viewport"
    }
  }
```

若轨道是 `MovieSceneByteTrack`，摘要还会包含：

- `enum_path`

## UMG Animation

| 指令 | 作用 | 关键参数 | 说明 |
|---|---|---|---|
| `sequence_list_umg_animations` | 列出动画 | `asset_path` | 查询 WidgetBlueprint 中现有动画 |
| `sequence_get_umg_animation_info` | 读取动画详情 | `asset_path`、`animation_name` | 返回 binding / track / section 摘要 |

说明：

- UMG 动画的正式 authoring 应通过 `animations/animations.json` 表达轨道和 key。
- float 轨道可显式传 `property_name / property_path`；不传时常见默认目标是 `RenderOpacity`。
- color 轨道除 `ColorAndOpacity` 外，也可用于 `BackgroundColor` 等颜色属性；建议显式传 `property_name / property_path`。

## 当前边界

- `Level Sequence` 当前已经有文件夹式结构化工作流，但它是 `partial_folder_profile`，不是通用 Sequencer 全覆盖；必须优先查看 `validation/coverage_report.json` 中每个 track 的 `roundtrip_status`。
- `sequence_apply_folder` 当前已能重建常见 `Actor / ActorComponent / Actor spawnable` 绑定；更复杂的自定义 binding 仍未纳入稳定重建面。
- `outliner/folders.json` 当前已能稳定回写 folder 树、常见 binding 归属、当前稳定 binding 内 track 归属与稳定 master track 归属；仍未覆盖导出面之外的 track 类型。
- 可选的 `settings/sequence.json` 只有不存在时才会跳过；文件存在但读取失败或 JSON 语法解析失败会直接失败返回并带文件路径。
- `outliner/folders.json` 中引用的 binding track spec 如果读取或解析失败，会进入 `warning_count / warnings[]`，消息包含 track 文件名与底层读取/解析错误。
- `master_tracks/index.json` 当前已稳定回写 `camera_cut / sub_sequence / cinematic_shot`；其它 master track 仍未纳入稳定 apply 面。
- `Level Sequence` 仍不是通用 Sequencer 全覆盖，目前最强的是统一属性轨、高频 transform、visibility、skeletal animation 和基础 Control Rig key 写入；Audio/Event/Attach/Constraint/Material/TimeWarp/DataLayer 等 track 家族仍是 readonly summary 或 unsupported。
- 新并入文件夹式 workflow 的 `property_type=byte/string/vector/rotator/actor_reference/object` 当前按“有 key 的结构化 round-trip”验收；只有 default、没有 key 的极端场景仍建议先小步 live 验证。
- `property_type=byte` 当前适合 `uint8` 和枚举属性；若要稳定写枚举名，建议显式传 `enum_path`。
- `property_type=rotator` 当前适合常见 `FRotator` 属性；复杂嵌套 struct 仍建议先用小步 live 验证。
- `property_type=vector` 当前适合常见向量 struct 属性；复杂嵌套 struct 仍建议先用小步 live 验证。
- `property_type=actor_reference` 当前适合同序列内的 Actor 绑定引用；如果传 `value_actor_id`，实现会在当前 sequence 中自动复用或创建目标 actor 的 binding。
- `property_type=object` 当前针对常见 `UObject` 引用属性稳定可用，但还不是任意复杂 property track 系统。
- `property_type=string` 当前适合常见 `FString` 属性，支持 `value_before_key` 作为首个关键帧前置值。
- `UMG Animation` 当前重点是 `RenderTransform / RenderOpacity / ColorAndOpacity / BackgroundColor` 以及通用 `float_property / color_property`；还没有 padding / slot 布局类轨道。

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/06_Sequence.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。
