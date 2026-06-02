# Modeling Mode 指令

适用场景：

- 激活 `Modeling Mode`
- 选择建模目标 Actor
- 启动建模工具并设置参数
- 接受或取消当前工具结果
- 保存建模后的网格资产
- 替换 Actor 使用的静态网格

说明：

- 本文档同时覆盖两层信息：
  - UAI 命令怎么调
  - UE `AddPrimitiveTool` 当前与本项目相关的关键 `ShapeSettings`
- 这里写的“参数”，如果没有特别说明，指的是 UE 工具属性，不是 HTTP 命令层自己额外发明的字段。

## 1. 通用控制

### `modeling_activate_mode`

- 作用：激活 UE 编辑器的 `Modeling` 模式。
- 参数：无。

### `modeling_get_selection`

- 作用：返回当前 `Modeling` 相关选择状态。
- 返回重点：
  - `selected_actor_count`
  - `selected_actors`
  - `mesh_selection_topology_mode`
  - `mesh_selection_element_type`

### `modeling_set_selection`

- 作用：设置当前建模目标 Actor，并可同步到几何目标。
- 参数：
  - `actor_ids`
  - `sync_geometry_targets`，可选，默认 `true`

### `modeling_set_mesh_selection_mode`

- 作用：设置几何元素选择模式。
- 参数：
  - `element_type`：`vertex / edge / face`
  - `topology_mode`：`triangle / polygroup / none`
  - `convert_existing_selection`，可选，默认 `true`

### `modeling_get_mesh_selection_info`

- 作用：读取当前几何选择模式与目标数量。

### `modeling_clear_mesh_selection`

- 作用：清空当前几何元素选择。

### `modeling_select_mesh_elements_via_screen`

- 作用：按屏幕坐标拾取几何元素。
- 参数：
  - `screen_x`
  - `screen_y`
  - `change_type`，可选：`replace / add / remove / toggle`
  - `clear_on_miss`，可选

### `modeling_select_mesh_elements_via_world_ray`

- 作用：按世界射线拾取几何元素。
- 参数：
  - `world_origin`
  - `world_direction`
  - `change_type`，可选：`replace / add / remove / toggle`
  - `clear_on_miss`，可选

## 2. 工具生命周期

### `modeling_start_tool`

- 作用：启动任意 `Modeling Tool`。
- 参数：
  - `tool_identifier`
  - `accept`，可选
  - `post_action`，可选
  - `tool_properties`，可选，数组，每项包含：
    - `property_set`
    - `property_name`
    - `value_text`
- 返回：
  - 若传入 `tool_properties`，返回 `property_import_results[]`，每项包含 `requested_value_text`、`applied_value_text`、`property_value_read_back`、`property_import_status`、`property_import_verified`、`property_import_error`、`value_text_exact_match`、`value_text_changed_after_import`、`cpp_type`。

### `modeling_get_active_tool`

- 作用：返回当前活动工具与属性集摘要。

### `modeling_get_active_tool_properties`

- 作用：读取当前活动工具的属性集与属性名列表。

### `modeling_set_active_tool_property`

- 作用：设置当前活动工具属性。
- 参数：
  - `property_set`
  - `property_name`
  - `value_text`
- 返回通用属性写入观测字段：`requested_value_text`、`applied_value_text`、`property_value_read_back`、`property_import_status`、`property_import_verified`、`property_import_error`、`value_text_exact_match`、`value_text_changed_after_import`、`cpp_type`。空字符串 `value_text` 视为合法写入值，不再被当作缺参。

### `modeling_invoke_active_tool_action`

- 作用：调用当前活动工具或属性集上的无参动作。
- 参数：
  - `action_name`
  - `property_set`，可选

### `modeling_accept_tool`

- 作用：接受当前工具结果。

### `modeling_cancel_tool`

- 作用：取消当前工具。

## 3. 资产与输出

### `modeling_save_mesh_asset`

- 作用：保存当前选择 Actor 引用的静态网格资产。
- 参数：
  - `actor_id`

### `modeling_replace_actor_mesh`

- 作用：替换 Actor 使用的静态网格。
- 参数：
  - `actor_id`
  - `static_mesh_asset`

### `modeling_snap_to_ground`

- 作用：将 Actor 简单吸附到地面。
- 参数：
  - `actor_id`
  - `trace_distance`，可选
  - `ground_offset`，可选

## 4. 封装好的常用建模命令

### 4.1 资产准备

- `modeling_convert_actor_to_dynamic_mesh`
- `modeling_duplicate_to_new_static_mesh`

### 4.2 基础几何创建

- `modeling_create_box`
- `modeling_create_cylinder`
- `modeling_create_sphere`
- `modeling_create_plane`
- `modeling_create_stairs`
- `modeling_create_ramp`
- `modeling_create_ramp_corner`

#### `bounds + rotation` 调用口径

这些基础元件除了支持常规 `tool_properties` 外，还支持：

- `bounds.center + bounds.extent`
- 或 `bounds.min + bounds.max`
- 再配合 `rotation` / `orientation`

示例：

```json
{
  "command": "modeling_create_box",
  "params": {
    "bounds": {
      "center": { "x": 0, "y": 0, "z": 100 },
      "extent": { "x": 200, "y": 100, "z": 50 }
    },
    "rotation": { "pitch": 0, "yaw": 45, "roll": 0 },
    "folder_path": "config/MyWhitebox"
  }
}
```

当前行为：

- 自动推导尺寸参数
- 自动 `accept`
- 固定 `TargetSurface=AtOrigin`
- 固定 `PivotLocation=Centered`
- 接受工具后把 Actor 放到 `bounds.center + rotation`
- 若传入 `folder_path`，会直接放进指定 Outliner folder
- 若显式传入 `tool_properties`，显式值覆盖自动求解值

#### 当前尺寸与语义规则

- `modeling_create_box`
  - `Depth = 2 * extent.x`
  - `Width = 2 * extent.y`
  - `Height = 2 * extent.z`
- `modeling_create_plane`
  - `Depth = 2 * extent.x`
  - `Width = 2 * extent.y`
- `modeling_create_cylinder`
  - `Radius = max(extent.x, extent.y)`
  - `Height = 2 * extent.z`
- `modeling_create_sphere`
  - `Radius = max(extent.x, extent.y, extent.z)`
- `modeling_create_stairs`
  - `X = run`
  - `Y = width`
  - `Z = rise`
  - 若未显式覆盖，则自动推导 `NumSteps / StepHeight / StepDepth / StepWidth`
- `modeling_create_ramp`
  - `Depth = 2 * extent.x`
  - `Width = 2 * extent.y`
  - `Height = 2 * extent.z`
  - 语义是沿局部 `+X` 抬升的三棱柱斜坡
- `modeling_create_ramp_corner`
  - `Depth = 2 * extent.x`
  - `Width = 2 * extent.y`
  - `Height = 2 * extent.z`
  - 语义是直角转角斜坡件，用于斜坡与转角的复合过渡

#### 常见 ShapeSettings

所有基础元件共享：

- `TargetSurface`
- `PivotLocation`
- `Rotation`
- `PolygroupMode`

与项目当前自动化白盒最相关的建议是：

- 用 `bounds + rotation` 时，不要再手改 `PivotLocation`
- 需要稳定自动化时，优先保持 `AtOrigin + Centered`
- 需要覆盖时，优先覆盖细分与几何形状参数，而不是覆盖放置口径

### 4.3 基础变形

- `modeling_extrude_faces`
- `modeling_inset_faces`
- `modeling_bevel_edges`
- `modeling_offset`
- `modeling_push_pull`
- `modeling_mirror`
- `modeling_duplicate_faces`

### 4.4 切割与布尔

- `modeling_boolean`
- `modeling_trim`
- `modeling_plane_cut`
- `modeling_mesh_cut`
- `modeling_voxel_boolean`

### 4.5 拓扑与重构

- `modeling_remesh`
- `modeling_simplify`
- `modeling_subdivide`
- `modeling_weld_edges`
- `modeling_fill_holes`
- `modeling_recompute_normals`

### 4.6 变换与对齐

- `modeling_set_pivot`
- `modeling_bake_transform`
- `modeling_align_to_world`

### 4.7 UV 与材质槽

- `modeling_auto_uv`
- `modeling_project_uv`
- `modeling_set_material_slot`
- `modeling_add_material_slot`
- `modeling_remove_material_slot`

### 4.8 碰撞

- `modeling_generate_simple_collision`
- `modeling_generate_convex_collision`

#### 白盒要点：`modeling_create_*` 后先补碰撞

当前项目里，`modeling_create_*` 创建出来的 `StaticMeshActor` **可能默认没有可用碰撞**（典型表现：`level_trace_world_ray hit=false`、`navmesh_find_path` 投影/连通异常）。

如果这些几何要参与“可玩白盒”（角色通行/净空/导航验收），建议立即补一层碰撞并回测：

1. `modeling_activate_mode`
2. `modeling_set_selection`（把新建 Actor 加入选择集，`sync_geometry_targets=true`）
3. `modeling_generate_convex_collision`（建议传 `accept=true`，走一次自动生成）
4. 用 `level_trace_world_ray` / `level_sweep_capsule` / `navmesh_build + navmesh_find_path` 回测

## 5. 推荐调用顺序

### A. 创建新几何

1. `modeling_activate_mode`
2. `modeling_create_*` 或 `modeling_start_tool`
3. 需要时设置 `tool_properties`
4. `modeling_accept_tool`
5. 需要时 `modeling_save_mesh_asset`

### B. 修改已有网格

1. `modeling_activate_mode`
2. `modeling_set_selection`
3. 启动目标工具
4. 设置参数
5. `modeling_accept_tool`
6. 需要时保存资产

## 6. 当前边界

- `modeling_*` 依赖编辑器上下文，不能当成完全 headless 系统
- `Modeling` 负责做几何，不负责决定整体布局
- `ramp / rampCorner` 只负责表达几何，不自动等于“角色可达”
- 复杂空间与可达关系必须先回到：
  - [../../../docs/levelDesignDocs/core/自动化关卡设计.md](../../../docs/levelDesignDocs/core/自动化关卡设计.md)
  - [../../../docs/levelDesignDocs/modeling/Modeling辅助搭建.md](../../../docs/levelDesignDocs/modeling/Modeling辅助搭建.md)

<!-- UAI_FORMAL_COMMAND_INDEX_BEGIN -->

## 补充命令正式索引
>
> 以下命令仍属于本正式分册；已废弃写入命令不在正式分册列出，仅保留在 `deprecatedCommand/10_Modeling.md`。

| Command | 作用 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `modeling_accept_tool` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_activate_mode` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_bevel_edges` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_cancel_tool` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_clear_mesh_selection` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_duplicate_faces` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_get_active_tool` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_get_active_tool_properties` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_get_mesh_selection_info` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_get_selection` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_inset_faces` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_invoke_active_tool_action` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_push_pull` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_replace_actor_mesh` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_save_mesh_asset` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_select_mesh_elements_via_screen` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_select_mesh_elements_via_world_ray` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_set_active_tool_property` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_set_mesh_selection_mode` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_set_selection` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_snap_to_ground` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_start_tool` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |

<!-- UAI_FORMAL_COMMAND_INDEX_END -->
