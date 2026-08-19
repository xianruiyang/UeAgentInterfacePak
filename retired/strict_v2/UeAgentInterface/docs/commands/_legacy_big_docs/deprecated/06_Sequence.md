# 废弃指令：Sequence

> 本文件从 `../06_Sequence.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## Level Sequence

| 指令 | 作用 | 关键参数 | 说明 |
|---|---|---|---|
| `sequence_set_level_sequence_playback_range` | **Deprecated for authoring**：设置播放范围 | `asset_path`、`start_seconds`、`duration_seconds` | 优先写 `settings/sequence.json` |
| `sequence_set_level_sequence_display_rate` | **Deprecated for authoring**：设置显示帧率 | `asset_path`、`display_rate_num/den` | 优先写 `settings/sequence.json` |
| `sequence_add_actor_binding` | **Deprecated for authoring**：添加 Actor 绑定 | `asset_path`、`actor_id` | 优先写 `bindings/*.json` |
| `sequence_remove_actor_binding` | **Deprecated for authoring**：删除 Actor 绑定 | `asset_path`、`binding_guid` | 优先写 `bindings/index.json` |

## 通用属性轨道

| 指令 | 作用 | 关键参数 | 说明 |
|---|---|---|---|
| `sequence_add_property_track` | **Deprecated for authoring**：统一创建属性轨道 | `asset_path`、`binding_guid`、`property_type`、`property_name` | 优先写 `bindings/<Binding>/tracks/*.json` |
| `sequence_add_property_key` | **Deprecated for authoring**：统一写入属性关键帧 | `asset_path`、`binding_guid`、`property_type`、`property_name`、`time_seconds` | 优先写 `bindings/<Binding>/tracks/*.json` |

## 专用兼容轨道命令

- **Deprecated for authoring**：`sequence_add_visibility_track`

- **Deprecated for authoring**：`sequence_add_visibility_key`

- **Deprecated for authoring**：`sequence_add_bool_property_track`

- **Deprecated for authoring**：`sequence_add_bool_property_key`

- **Deprecated for authoring**：`sequence_add_float_property_track`

- **Deprecated for authoring**：`sequence_add_float_property_key`

- **Deprecated for authoring**：`sequence_add_integer_property_track`

- **Deprecated for authoring**：`sequence_add_integer_property_key`

- **Deprecated for authoring**：`sequence_add_transform_track`

- **Deprecated for authoring**：`sequence_add_transform_key`

- **Deprecated for authoring**：`sequence_add_skeletal_animation_track`

- **Deprecated for authoring**：`sequence_add_skeletal_animation_section`

- **Deprecated for authoring**：`sequence_update_skeletal_animation_section`

- **Deprecated for authoring**：`sequence_remove_skeletal_animation_section`

## UMG Animation

| 指令 | 作用 | 关键参数 | 说明 |
|---|---|---|---|
| `sequence_create_umg_animation` | **Deprecated for authoring**：创建动画 | `asset_path`、`animation_name` | 优先写 `animations/animations.json` |
| `sequence_rename_umg_animation` | **Deprecated for authoring**：重命名动画 | `asset_path`、`animation_name`、`new_animation_name` | 优先写 `animations/animations.json` |
| `sequence_remove_umg_animation` | **Deprecated for authoring**：删除动画 | `asset_path`、`animation_name` | 优先写 `animations/animations.json` |
| `sequence_set_umg_animation_playback_range` | **Deprecated for authoring**：设置范围 | `asset_path`、`animation_name`、`start_seconds`、`duration_seconds` | 优先写 `animations/animations.json` |
| `sequence_set_umg_animation_display_rate` | **Deprecated for authoring**：设置帧率 | `asset_path`、`animation_name`、`display_rate_num/den` | 优先写 `animations/animations.json` |
| `sequence_add_umg_widget_translation_key` | **Deprecated for authoring**：写平移关键帧 | `asset_path`、`animation_name`、`widget_name`、`time_seconds` | 兼容旧入口 |
| `sequence_add_umg_widget_transform_key` | **Deprecated for authoring**：写 RenderTransform 关键帧 | `asset_path`、`animation_name`、`widget_name`、`time_seconds` | 优先写 `animations/animations.json` |
| `sequence_add_umg_widget_opacity_key` | **Deprecated for authoring**：写 RenderOpacity 关键帧 | `asset_path`、`animation_name`、`widget_name`、`time_seconds`、`opacity` | 优先写 `animations/animations.json` |
| `sequence_add_umg_widget_float_key` | **Deprecated for authoring**：写任意 float 属性关键帧 | `asset_path`、`animation_name`、`widget_name`、`time_seconds`、`value` | 优先写 `animations/animations.json` |
| `sequence_add_umg_widget_color_key` | **Deprecated for authoring**：写 ColorAndOpacity 关键帧 | `asset_path`、`animation_name`、`widget_name`、`time_seconds` | 优先写 `animations/animations.json` |
