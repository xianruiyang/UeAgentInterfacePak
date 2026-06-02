# 指令详解：UMG（WidgetBlueprint）

> 废弃写入命令已迁移到 `deprecatedCommand/03_UMG.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## 资产与编译

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `umg_create_widget_blueprint` | 创建 WidgetBlueprint | `asset_path`、`parent_class`、`create_default_root`、`compile_after_create`、`open_editor`、`save_after_create` | 新建 UI 页面 |
| `umg_compile` | 编译 WidgetBlueprint | `asset_path`、`include_messages`、`severity_filter`、`max_messages`、`save_after_compile` | 改完控件树后验证 |
| `umg_get_compile_log` | 编译并读取 UMG 编译日志 | `asset_path`、`max_messages`、`severity_filter`、`save_after_compile` | 自动化拿错误列表 |
| `umg_get_info` | 读取 WidgetTree 结构与控件信息 | `asset_path` | 确认层级、控件名、槽类型 |
| `umg_export_folder` | 导出 WidgetBlueprint 文件夹结构 | `asset_path`；可选 `clean_output_dir`、`include_validation` | 导出到固定目录做结构化审查与编辑 |
| `umg_apply_folder` | 从文件夹结构回写 WidgetBlueprint | `asset_path`；可选 `create_if_missing`、`compile_after_apply`、`save_after_apply` | 读取固定目录并按“根控件复用 + 子树重建”策略应用 |

- `umg_create_widget_blueprint` 成功后会返回 `root_widget`；后续控件树应通过 `widget_tree/tree.json` 表达父子关系和 slot 属性。

## 文件夹式工作流

- `umg_export_folder` / `umg_apply_folder`：
  - 这是 `WidgetBlueprint` 的主编辑工作流；控件树、绑定、动画这类结构默认优先走文件夹式 JSON，而不是逐条原子命令。
  - 对属性很多的控件或 slot，推荐先写最小树结构，再 apply/export 一轮，用导出的真实 JSON 当模板继续补属性。
  - 固定导出根目录：`Saved/UeAssetFolders/WidgetBlueprint`
  - 单个资产目录按 `asset_path` 自动展开，例如 `/Game/UI/WBP_MainMenu` -> `Saved/UeAssetFolders/WidgetBlueprint/Game/UI/WBP_MainMenu`
  - `umg_export_folder` 默认：
    - `clean_output_dir=true`
    - `include_validation=true`
  - `umg_apply_folder` 默认：
    - `create_if_missing=true`
    - `compile_after_apply=true`
    - `save_after_apply=true`
  - 当前第一版导出/回写的稳定结构是：
    - `asset.json`
    - `settings/widget_blueprint.json`
    - `members/variables.json`
    - `widget_tree/tree.json`
    - `bindings/property_bindings.json`
    - `animations/animations.json`
    - `graphs/*.json`
    - `validation/checks.json`
  - 变量与逻辑图当前复用 `Blueprint` 文件夹工作流的稳定能力；控件树、绑定、动画走 UMG 自己的结构
    - 初始化和快速搭原型
    - 结构化回写前后的探针读取
    - schema 还没覆盖到的细节补修
  - `apply_folder` 第一版的控件树应用策略是“优先复用匹配的根控件，重建其余子树”，不是节点级 diff
  - 当前稳定动画轨道回写面：
    - `RenderOpacity`
    - `ColorAndOpacity`
    - `BackgroundColor`
    - `RenderTransform`
    - 通用 `float_property`
    - 通用 `color_property`
  - 当前 `bindings/property_bindings.json` 支持：
    - `property_variable`
    - `function`

## WidgetTree 编辑

> 废弃写入命令已迁移到 `deprecatedCommand/03_UMG.md` 的对应章节。

属性写入返回：

- `umg_apply_folder` 会在控件、slot、绑定和动画属性回写时返回写入观测信息。
- 属性导入失败时，返回数据会包含失败的 `widget_name`、`property_name` 和请求值，便于定位 JSON/结构化 JSON 中的坏字段。
- `umg_apply_folder` 的可选文件（`settings/widget_blueprint.json`、`bindings/property_bindings.json`、`animations/animations.json`）只有不存在时才会跳过；文件存在但读取失败或 JSON 语法解析失败会直接失败返回并带文件路径。
- 控件、绑定、动画数组中不是 object 或缺 `id/widget_name/property_name/name` 的条目会进入 `warning_count / warnings[]`，不再静默忽略。

- `widget_tree/tree.json` 中的 `make_variable`、`parent_widget`、`insert_index` 和 slot 属性共同决定控件变量、父子关系和布局顺序。
- TextBlock 的常用视觉属性已纳入 folder round-trip：`Text`、`ColorAndOpacity`、`Font.Size`、`Justification`、`AutoWrapText`、`MinDesiredWidth`、`ShadowOffset`、`ShadowColorAndOpacity`。标题、菜单等 UMG 字号不要绕开结构化源单独手改，否则下一次导出/回写难以复现。
- `bindings/property_bindings.json` 中的 `source_variable_name` 必须已经存在于 `WidgetBlueprint` 上；常见做法是在 `members/variables.json` 中先声明变量，再绑定控件属性。

## 跨域配合

- `WidgetBlueprint` 的事件图逻辑、本地变量、函数图/宏图仍走 `blueprint_*` 指令。
- `WidgetBlueprint` 的独立动画编辑命令当前主要走 `sequence_*`；但文件夹式工作流会在 `animations/animations.json` 中导出/回写常见 UMG 动画轨。
  - `sequence_list_umg_animations`
  - `sequence_get_umg_animation_info`

## 组合流程建议

1. `umg_create_widget_blueprint`
2. `umg_export_folder`
3. 编辑 `widget_tree/tree.json`、`bindings/property_bindings.json`、`animations/animations.json` 和 `graphs/*.json`
4. `umg_apply_folder`
5. `umg_compile`（`include_messages=true`）
6. `save_asset`

## 最小请求示例

```json
{
  "request_id": "umg-001",
  "command": "umg_export_folder",
  "params": {
    "asset_path": "/Game/AutoTests/UI/WBP_Test",
    "clean_output_dir": true,
    "include_validation": true
  }
}
```

## 2026-04-22 更新

- `settings/widget_blueprint.json` 新增 `is_focusable`。
- `umg_export_folder` 会导出 `WidgetBlueprint` 的 `is_focusable`。
- `umg_apply_folder` 会把 `is_focusable` 回写到 `bIsFocusable`，适合配合 `SetInputMode_UIOnlyEx` / `TakeWidget()` 的菜单焦点工作流。
- `animations/animations.json` 当前已扩到：
  - `opacity`
  - `color`
  - `background_color`
  - `float_property`
  - `color_property`
  - `transform`

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/03_UMG.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。
