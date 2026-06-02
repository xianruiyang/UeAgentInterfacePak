# 指令详解：Sequence

> 废弃写入命令已迁移到 `deprecatedCommand/06_Sequence.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

覆盖 `Level Sequence` 与 `UMG Animation` 两部分。

## Level Sequence

| 指令 | 作用 | 关键参数 | 说明 |
|---|---|---|---|
| `sequence_list_level_sequences` | 列出序列资产 | `root_path`、`limit` | 资产检索 |
| `sequence_create_level_sequence` | 创建关卡序列 | `asset_path`、`start_seconds`、`duration_seconds` | 可选 `display_rate_num/den`、`open_editor` |
| `sequence_open_level_sequence` | 打开 Sequencer | `asset_path` | 进入编辑上下文 |
| `sequence_get_level_sequence_info` | 读取序列摘要 | `asset_path` | 返回 binding / track / section 摘要 |
| `sequence_screenshot` | 按帧/时间截取 Level Sequence 画面，也可批量输出连续序列帧总览图 | `asset_path`、`frame_index`、`time_seconds`、`start_frame_index`、`count`、`frame_interval`、`start_time_seconds`、`interval_seconds`、`format`、`quality`、`max_size`、`target`、`create_frame_sheet`、`write_individual_frames`、`frame_sheet_padding`、`frame_sheet_max_size`、`frame_sheet_label_scale` | 用临时 LevelSequencePlayer 求值，并通过临时 SceneCapture 输出；多帧默认只写一张带帧号标注的合成 sheet |
| `sequence_export_folder` | 导出文件夹式真源 | `asset_path`；可选 `clean_output_dir`、`include_validation` | 当前推荐的 `Level Sequence` 主编辑路径 |
| `sequence_apply_folder` | 从文件夹式真源回写 | `asset_path`；可选 `create_if_missing`、`save_after_apply` | 读取 `Saved/UeAssetFolders/LevelSequence` 下的结构化目录 |

## 文件夹式工作流

- `sequence_export_folder / sequence_apply_folder`
  - 这是 `Level Sequence` 当前推荐的主编辑路径。
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
  - 当前稳定导出/回写的轨道类型：
    - `spawn`
    - `transform`
    - `skeletal_animation`
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

- `Level Sequence` 当前已经有文件夹式结构化工作流，但还不是通用 Sequencer 全覆盖。
- `sequence_apply_folder` 当前已能重建常见 `Actor / ActorComponent / Actor spawnable` 绑定；更复杂的自定义 binding 仍未纳入稳定重建面。
- `outliner/folders.json` 当前已能稳定回写 folder 树、常见 binding 归属、当前稳定 binding 内 track 归属与稳定 master track 归属；仍未覆盖导出面之外的 track 类型。
- 可选的 `settings/sequence.json` 只有不存在时才会跳过；文件存在但读取失败或 JSON 语法解析失败会直接失败返回并带文件路径。
- `outliner/folders.json` 中引用的 binding track spec 如果读取或解析失败，会进入 `warning_count / warnings[]`，消息包含 track 文件名与底层读取/解析错误。
- `master_tracks/index.json` 当前已稳定回写 `camera_cut / sub_sequence / cinematic_shot`；其它 master track 仍未纳入稳定 apply 面。
- `Level Sequence` 仍不是通用 Sequencer 全覆盖，目前最强的是统一属性轨、高频 transform、visibility、skeletal animation。
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
