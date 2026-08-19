# 废弃指令：UMG（WidgetBlueprint）

> 本文件从 `../03_UMG.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## WidgetTree 编辑

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `umg_add_widget` | **Deprecated for authoring**：新增控件到 WidgetTree | `asset_path`、`widget_class`、`widget_name`、`parent_widget`、`make_variable`、`insert_index`、`compile_after_add`、`save_after_add` | 仅用于 bootstrap/修补 |
| `umg_remove_widget` | **Deprecated for authoring**：删除控件 | `asset_path`、`widget_name`、`compile_after_remove`、`save_after_remove` | 仅用于修补 |
| `umg_rename_widget` | **Deprecated for authoring**：重命名控件 | `asset_path`、`widget_name`、`new_widget_name`、`compile_after_rename`、`save_after_rename` | 仅用于修补 |
| `umg_set_widget_property` | **Deprecated for authoring**：设置控件属性 | `asset_path`、`widget_name`、`property_name`、`value_text`、`compile_after_set`、`save_after_set` | 仅用于局部修补 |
| `umg_set_slot_property` | **Deprecated for authoring**：设置 Slot 属性 | `asset_path`、`widget_name`、`property_name`、`value_text`、`compile_after_set`、`save_after_set` | 仅用于局部修补 |
| `umg_bind_widget_property_to_variable` | **Deprecated for authoring**：绑定控件属性到蓝图变量 | `asset_path`、`widget_name`、`property_name`、`source_variable_name`、`compile_after_bind`、`save_after_bind` | 仅用于局部修补 |

## 跨域配合

  - **Deprecated for authoring**：`sequence_create_umg_animation`

  - **Deprecated for authoring**：`sequence_rename_umg_animation`

  - **Deprecated for authoring**：`sequence_remove_umg_animation`

  - **Deprecated for authoring**：`sequence_set_umg_animation_playback_range`

  - **Deprecated for authoring**：`sequence_set_umg_animation_display_rate`

  - **Deprecated for authoring**：`sequence_add_umg_widget_transform_key`

  - **Deprecated for authoring**：`sequence_add_umg_widget_translation_key`

  - **Deprecated for authoring**：`sequence_add_umg_widget_opacity_key`

  - **Deprecated for authoring**：`sequence_add_umg_widget_float_key`

  - **Deprecated for authoring**：`sequence_add_umg_widget_color_key`
