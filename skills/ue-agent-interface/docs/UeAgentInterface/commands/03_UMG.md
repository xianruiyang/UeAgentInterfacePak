# 指令详解：UMG（WidgetBlueprint）

> 废弃写入命令已迁移到 `deprecatedCommand/03_UMG.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## 资产与编译

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `umg_create_widget_blueprint` | 创建 WidgetBlueprint | `asset_path`、`parent_class`、`create_default_root`、`compile_after_create`、`open_editor`、`save_after_create` | 新建 UI 页面 |
| `umg_compile` | 编译 WidgetBlueprint | `asset_path`、`include_messages`、`severity_filter`、`max_messages`、`save_after_compile` | 改完控件树后验证 |
| `umg_get_compile_log` | 编译并读取 UMG 编译日志 | `asset_path`、`max_messages`、`severity_filter`、`save_after_compile` | 自动化拿错误列表 |
| `umg_get_info` | 读取 WidgetTree 结构与控件信息 | `asset_path` | 确认层级、控件名、槽类型 |
| `umg_screenshot` | 离屏渲染 WidgetBlueprint 并截图，可自动裁剪到可见控件外接框 | `asset_path`、`crop_mode`、`region`、`crop_x`、`crop_y`、`crop_width`、`crop_height`、`capture_width`、`capture_height`、`bounds_padding`、`format`、`quality`、`max_size`、`output_file`、`compile_before_capture` | 设计期查看 UMG 整体或局部控件 |
| `umg_list_widget_events` | 查询某个 Widget 可绑定的 BlueprintAssignable 事件 | `asset_path`、`widget_name`、`query`、`limit`、`only_unbound`、`include_hidden`、`compile_before_query` | 给 Button / Slider / CheckBox 等控件新增事件前确认真实事件名和 owner class |
| `umg_export_folder` | 导出 WidgetBlueprint 文件夹结构 | `asset_path`；可选 `clean_output_dir`、`include_validation` | 导出到固定目录做结构化审查与编辑 |
| `umg_apply_folder` | 从文件夹结构回写 WidgetBlueprint | `asset_path`；可选 `create_if_missing`、`compile_after_apply`、`save_after_apply` | 读取固定目录并按“根控件复用 + 子树重建”策略应用 |

- `umg_create_widget_blueprint` 成功后会返回 `root_widget`；后续控件树应通过 `widget_tree/tree.json` 表达父子关系和 slot 属性。

## 设计期截图

- `umg_screenshot` 不打开 Designer，不依赖运行时 viewport 或鼠标焦点；它用当前 EditorWorld 临时实例化 WidgetBlueprint 的生成类，并通过 Slate `FWidgetRenderer` 离屏渲染。
- 默认 `crop_mode=auto_bounds`：先按 `capture_width/capture_height` 渲染完整画布（默认 `1920x1080`），再根据非透明像素计算可见内容外接框；没有可见像素时回退整张画布。`bounds_padding` 默认 `0`，需要避免边缘被精确裁掉时再显式增加。
- 手动区域使用同一套 UMG 画布像素坐标：原点左上，X 向右，Y 向下。可传 `region` / `crop` 对象：

```json
{
  "region": {
    "x": 320,
    "y": 180,
    "width": 640,
    "height": 360
  }
}
```

- 也可传平铺字段：`crop_x/crop_y/crop_width/crop_height`。只要传了区域字段且未显式指定 `crop_mode`，命令会自动切到 `manual_region`。
- `crop_mode=full_canvas` 会输出完整画布。`format` 支持 `png/jpg/webp`，默认 `png` 并保留 alpha；`max_size` 默认 `2048`，只限制最终输出长边。
- 命令默认 `compile_before_capture=true`，确保截图来自最新生成类；编译失败会返回 `compile_failed_before_capture`，不保存资产。
- 返回字段包括 `file_path`、`canvas`、`content_bounds`、`crop`、`width/height`、`raw_width/raw_height`、`auto_bounds_found`、`compiled_before_capture` 和 `capture_mode=umg_widget_offscreen`。

## 控件事件查询

- `umg_list_widget_events` 用于在给控件写事件图前确认真实可绑定事件。它读取 `WidgetTree` 中的控件实例 class，并按 UE 组件事件菜单同款规则枚举 `BlueprintAssignable` multicast delegate。
- 输入 `widget_name` 是 Designer/`widget_tree/tree.json` 中的控件名；控件要能直接写入 `component_bound_event`，通常还需要在 `widget_tree/tree.json` 中 `make_variable=true`。
- 返回的 `events[].authoring_node` 可直接复制到 `graphs/EventGraph.json` 的节点数组里；字段名仍使用底层 Blueprint 统一格式 `component_name`：

```json
{
  "node_type": "component_bound_event",
  "component_name": "BtnStart",
  "delegate_property_name": "OnClicked",
  "delegate_owner_class": "/Script/UMG.Button"
}
```

- `widget_property_found=false` / `can_author_component_bound_event=false` 表示该控件虽然 class 上有事件，但当前 WidgetBlueprint 还不能直接创建绑定事件；优先检查控件是否存在、是否 `make_variable=true`，并重新 `umg_apply_folder` / 编译后再查。
- `query` 可按事件名、显示名、分类或 tooltip 过滤；`only_unbound=true` 可只看还没有绑定节点的事件。

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
  - `compile_after_apply=true` 时，apply 会在最终保存前读取编译结果；如果 `compile.has_error=true` 或 `compile.error_count>0`，命令失败返回 `compile_failed_after_apply`，响应中保留 `compile.messages[]`，并且不会执行最终保存。
  - 当前第一版导出/回写的稳定结构是：
    - `asset.json`
    - `settings/widget_blueprint.json`
    - `members/variables.json`
    - `widget_tree/tree.json`
    - `bindings/property_bindings.json`
    - `animations/animations.json`
    - `graphs/*.json`
    - `validation/checks.json`
  - 变量与逻辑图当前复用 `Blueprint` 文件夹工作流的稳定能力；控件树、绑定、动画走 UMG 自己的结构。
  - `umg_apply_folder` 会先通过 Blueprint proxy 应用 `members/*.json`，再重建 `widget_tree/tree.json`，最后在控件变量存在并完成一次编译后应用 `graphs/*.json`；这保证 `component_bound_event` 这类 WidgetBlueprint 事件节点能找到对应 `make_variable=true` 的控件变量。
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
- UMG 节点发现必须区分三层：控件树节点用 `umg_get_info / umg_export_folder` 查 `widget_tree/tree.json`、slot 和 `make_variable`；事件图/K2 节点用 `blueprint_inspect_nodes`、`blueprint_export_folder` 或 `node_graph_list(adapter=umg_k2)` 查真实 node class/pin；动画轨道用 `animations/animations.json` 或 `sequence_*` 读回。不要把 Designer 控件名、K2 节点名和动画轨道名混成同一种节点。
- 当前没有完整 UMG/K2 palette 查询命令。新增未在导出模板中出现过的事件节点、控件绑定节点或复杂 Slate/UMG 控件时，必须先用已有模板、明确 class/function reference 或新增候选查询能力取证；不得凭 UI 菜单显示名生成 JSON。
- `WidgetBlueprint` 的独立动画编辑命令当前主要走 `sequence_*`；但文件夹式工作流会在 `animations/animations.json` 中导出/回写常见 UMG 动画轨。
  - `sequence_list_umg_animations`
  - `sequence_get_umg_animation_info`

## 组合流程建议

1. `umg_create_widget_blueprint`
2. `umg_export_folder`
3. 编辑 `widget_tree/tree.json`、`bindings/property_bindings.json`、`animations/animations.json` 和 `graphs/*.json`
4. `umg_apply_folder`（默认已编译；失败时先修 `compile.messages[]`）
5. 需要额外诊断时再调用 `umg_compile`（`include_messages=true`）

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
