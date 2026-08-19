# Modeling Mode 指令

## 紧凑返回契约

- 默认 `llm_compact` 的 `data` 只保留 LLM 决策需要的目标标识、关键状态、计数、摘要、warnings/errors 摘要和 artifact / 文件路径。
- 完整读回、大对象、长列表、编译日志、像素/帧/点数据、raw property metadata、诊断栈和内部中间状态默认不进入 `data`；需要时通过 `response_options` 的 debug/raw 视图、显式请求字段或外置 artifact 获取。
- 本分册中的旧局部参数、历史别名或原子入口只作为 alias / 兼容路径；新 authoring 应优先使用本分册推荐的 JSON、folder、统一 viewport、probe 或 domain 专用入口。


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
- UAI 启动带 `CreateMeshObjectTypeProperties.OutputType` 的 Modeling 工具时，默认输出为 `Dynamic Mesh` / `DynamicMeshActor`；需要静态网格时必须显式传 `OutputType=Static Mesh`。

## 返回契约

- Python `uai_core` wrapper 统一返回 `CommandResult`：业务字段读取 `CommandResult.data`，调试字段读取 `CommandResult.debug`，完整原始 envelope 仅在排查时读取 `CommandResult.envelope`。
- 默认 compact data 只保留 LLM 决策必需字段：Actor / asset / component 身份、output type、bounds / AABB / pivot 摘要、collision 摘要、mesh 计数、session / revision、关键写入状态、warnings 摘要和必要 artifact / sidecar 路径。
- 建模产物命令默认不得返回完整 mesh 顶点、三角面、polygroup、face/edge/vertex selection、DynamicMesh buffer、完整碰撞组件列表或完整属性反射表；这些内容必须进入 debug/raw、显式请求字段、sidecar、folder artifact 或后续专用空间感知指令。
- `modeling_create_*` 默认 data 返回 `created_actor`、`derived_primitive`、`output_type`、`bounds`、`rotation`、`collision.generated/mode/source/box_count/component_count` 等摘要；完整 mesh、完整 collision components、物理 cooked data 和 trace 诊断不进入默认 data。
- `modeling_voxel_grid_*` 默认 data 返回 `session_id`、`grid_id`、`revision`、`changed_cell_count`、`occupied_cell_count`、`bounds.cell_range`、apply 后的 mesh 计数、collision 覆盖摘要、`metadata.sidecar_path` 和 `metadata.anchor`；完整占用 cell 集、exposed face 列表、exact-cover box 明细和 sidecar 正文默认隐藏。
- `modeling_get_mesh_spatial_info` 的默认 data 只返回目标、frame、AABB min/max 和 `pivot_in_aabb.ratio`；world bounds、corners、center/extent、viewport frame、完整顶点采样和重复坐标字段默认不返回。
- `modeling_set_pivot` 默认 data 返回 pivot backend、目标、pivot before/after、关键点、geometry/collision preserved、资产写入策略和必要 sidecar/affected component 摘要；完整 LOD 顶点偏移、simple collision shape 明细、受影响组件长列表和 raw readback 进入 debug/raw。
- Modeling Mode raw / 兼容工具命令默认 data 只保留 `success`、当前工具 / 选择摘要、property import 结果摘要和 warnings 摘要；完整 property set 反射、选择元素列表、错误栈和 UE tool 内部状态进入 debug/raw。
- 矩阵中仍存在的 manifest-only Modeling 行没有当前 Python wrapper；其返回迁移按本通用 Modeling 契约和正式/废弃文档归属处理，不能伪造 wrapper 测试或把它们当成当前推荐 authoring 入口。

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

### `modeling_get_mesh_spatial_info`

- 作用：读取静态网格体资产、骨骼网格体资产，或场景中静态网格体组件、骨骼网格体组件、DynamicMesh 组件的视觉网格 AABB，并返回 pivot 在 AABB 内的相对位置。
- 参数：
  - `asset_path`：可选。传入静态网格体或骨骼网格体资产路径时读取资产局部空间。
  - `actor_id` / `actor_label` / `actor_path` / `actor`：可选。未传 `asset_path` 时用于定位场景 Actor。
  - `component_name` / `component`：可选。Actor 上存在多个可支持网格组件时必须传入。
  - `bounds_space`：可选；资产目标只支持 `asset_local`，场景组件目标只支持 `component_local`。
- 返回：
  - `target.target_type`：`static_mesh_asset` / `skeletal_mesh_asset` / `static_mesh_component` / `skeletal_mesh_component` / `dynamic_mesh_component`
  - `frame.bounds_space`：`asset_local` 或 `component_local`
  - `frame.bounds_source`：固定为 `visual_mesh`
  - `frame.unit`：固定为 `cm`
  - `aabb.min` / `aabb.max`
  - `pivot_in_aabb.ratio`：pivot 相对 AABB 的 0..1 比例；某轴尺寸为 0 时该轴为 `null` 并返回 `issues[].code=zero_size_axis`
- 语义边界：
  - pivot 取目标局部原点 `(0,0,0)`，不返回绝对 pivot 位置。
  - 默认不返回 world bounds、center、extent、corners 或 viewport frame 信息；后续如需扩展必须用显式参数开启，且扩展字段不能与默认字段重复。
  - StaticMesh 专用 `static_mesh_get_bounds` / `static_mesh_get_local_corners` 可继续作为资产级快捷读回入口；需要同时覆盖 StaticMesh / SkeletalMesh 资产、场景 Actor/mesh Component、DynamicMesh 或 pivot 相对 AABB 位置的新流程，应优先使用本命令。

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
    - `property_path`
    - `value_kind`
    - `value`
- 返回：
  - 若传入 `tool_properties`，返回结构化 `property_results[]`、应用计数和 `readback_verified`；失败项携带 `property_path/error_code`。
  - 若工具存在 `CreateMeshObjectTypeProperties.OutputType` 且调用方未显式覆盖，UAI 会写入 `Dynamic Mesh`，并返回 `default_output_type_applied=true`、`default_output_type=Dynamic Mesh`。

显式覆盖为静态网格示例：

```hjson
{
  tool_properties: [
    {
      property_set: CreateMeshObjectTypeProperties
      property_path: OutputType
      value_kind: enum
      value: {selected: "Static Mesh"}
    }
  ]
}
```

### `modeling_get_active_tool`

- 作用：返回当前活动工具与属性集摘要。

### `modeling_get_active_tool_properties`

- 作用：读取当前活动工具的属性集与属性名列表。

### `modeling_set_active_tool_property`

- 作用：设置当前活动工具属性。
- 参数：
  - `tool_properties[]`：必须且只能包含一个 `property_set/property_path/value_kind/value` descriptor。
- 返回公共 v2 apply/readback 摘要。字符串空值使用 `value: {literal: ""}`，仍是可靠合法值。

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
- 默认 `CreateMeshObjectTypeProperties.OutputType=Dynamic Mesh`
- 固定 `TargetSurface=AtOrigin`
- 固定 `PivotLocation=Centered`
- 接受工具后把 Actor 放到 `bounds.center + rotation`
- 默认按 primitive 类型生成可用碰撞，供玩家通行、trace/sweep 和 `level_get_nearby_mesh_shapes` 感知使用
- 若传入 `folder_path`，会直接放进指定 Outliner folder
- 若显式传入 `tool_properties`，显式值覆盖自动求解值

#### `collision` 参数

`modeling_create_*` 高层 bounds 路径默认按 primitive 类型选择碰撞。优先目标是碰撞贴合实际可见模型；如果简单组件不能贴合实际模型，默认使用 `DynamicMeshComponent` 的 complex collision，而不是退化成一个包住整体的 bounds box。

`simple_auto` 默认映射：

- `modeling_create_box` / `modeling_create_plane`：Actor 下挂 `UAI_ModelingCollision_*` `UBoxComponent`。
- `modeling_create_sphere`：Actor 下挂 `UAI_ModelingCollision_*` `USphereComponent`。
- `modeling_create_stairs`：Actor 下挂逐级 `UBoxComponent`，保留台阶实际阻挡。
- `modeling_create_cylinder` / `modeling_create_ramp` / `modeling_create_ramp_corner`：启用视觉 `DynamicMeshComponent` 的 complex-as-simple collision，避免圆柱、斜坡、转角斜坡被过大的 box 或错误台阶盒近似，并让默认 Pawn/Character sweep 不依赖 `trace_complex=true`。

只有使用 Actor 级 primitive collision component 时，视觉 `DynamicMeshComponent` 会被设为 `NoCollision`；使用 `complex_mesh` 时，碰撞由 `DynamicMeshComponent` 自身承担，内部会调用 DynamicMesh 的 complex-as-simple 路径并重建 physics data。

- `collision.mode`：可选，默认 `simple_auto`。支持：
  - `simple_auto`：按 primitive 类型自动选择。
  - `bounds_box` / `box` / `box_component`：单个本地 bounds box。
  - `sphere` / `sphere_component`：单个本地 sphere component。
  - `complex` / `complex_mesh` / `dynamic_mesh_complex` / `mesh_complex`：使用 `DynamicMeshComponent` complex-as-simple collision。
  - `stairs_step_boxes`：楼梯逐级 solid box。
  - `ramp_step_boxes`：显式兼容模式，斜坡按高度分段为台阶 box 近似；默认不再使用。
  - `ramp_corner_step_boxes`：显式兼容模式，转角斜坡按二维分段 box 近似；默认不再使用。
  - `none` / `disabled` / `no_collision`：不生成碰撞，并关闭视觉 `DynamicMeshComponent` 的 collision/query，避免 `trace_complex=true` 仍命中视觉三角面；只用于透明占位、提示或纯视觉调试件。
- `collision.profile_name` / `collision.profile`：可选，默认 `BlockAll`。
- `collision.enabled`：可选，默认 `query_and_physics`；支持 `query_only`、`physics_only`、`none` / `no_collision`。
- `collision.replace_existing`：可选，默认 `true`，只替换带 `UAIModelingPrimitiveCollision:*` tag 或 `UAI_ModelingCollision_*` 名称的旧组件。
- `collision.max_boxes` / `collision.max_shapes`：可选，默认 `256`。
- `collision.max_step_height_cm`：可选，默认 `20`，控制 ramp / ramp_corner 分段碰撞的最大单段高度。
- 兼容字段 `auto_generate_collision=false` 等价于 `collision.mode=none`。

返回 `collision`：

- `requested_mode`
- `mode`：实际使用的模式
- `generated`
- `skipped` / `skip_reason`：显式禁用 collision 时返回，例如 `collision_disabled`
- `source`：`actor_box_components` / `actor_sphere_component` / `dynamic_mesh_component`
- `profile_name`
- `enabled`
- `box_count` / `sphere_count` / `complex_component_count` / `shape_count`
- `disabled_dynamic_mesh_collision_components`
- `components[]`：每个碰撞来源的 `name`、`shape`、`kind`；box 返回 `relative_center` / `extent`，sphere 返回 `relative_center` / `radius`，complex mesh 返回 DynamicMesh component 摘要，并包含 `complex_as_simple=true` / `collision_trace_flag=use_complex_as_simple`

边界：

- 这套默认碰撞是场景 Actor 级碰撞，不会把 simple collision 写进 StaticMesh 资产 BodySetup。
- `complex_mesh` 依赖 DynamicMesh 场景组件自身碰撞，适合当前场景可玩性测试；验收时必须至少覆盖一次 `trace_complex=false` 的 Pawn/Character 胶囊 sweep，不能只用 `trace_complex=true` 的 ray/sweep。若最终要产出 StaticMesh 资产，仍应在资产生成/转换阶段处理 BodySetup 或确认目标平台接受 complex collision。
- 需要保存可复用 StaticMesh 资产碰撞时，显式输出或复制为 StaticMesh 后，继续使用 StaticMesh folder `collision.json` 或专用 collision 生成命令。
- 原始 `modeling_start_tool` 没有 bounds 合同，不默认推导这套碰撞；需要可玩白盒碰撞时应使用高层 `modeling_create_* + bounds`，或在后续显式生成碰撞。

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

### `modeling_set_pivot`

作用：设置当前建模目标的 pivot。该命令现在有两层行为：

- 传入 `preset` / `pivot_preset` / `custom_point` 等高层字段时，UAI 先做参数归一化，再调用合适后端。
- 未传高层字段时，保持兼容旧行为，仍作为 `BeginEditPivotTool` 的 raw wrapper，可继续传 `tool_properties`、`post_action` 和 `accept`。

高层参数：

- `actor_id` / `actor_label` / `actor_path` / `actor`：可选；传入后先同步 Modeling selection，再执行 pivot 操作。未传时沿用当前选择。
- `actor_ids`：可选；多 Actor raw EditPivotTool 路径仍可使用。
- `preset` / `pivot_preset`：可选；支持 `center`、`bottom`、`top`、`left`、`right`、`front`、`back`、`world_origin`。传入后默认 `accept=true`，除非显式传 `accept=false`。
- `bounds_space` / `box_space`：可选；`world` 使用世界 AABB，`component_local` / `asset_local` / `object_local` / `local` 使用对象局部 AABB。
- `custom_point` / `pivot_point`：可选；支持 DynamicMesh 组件、StaticMesh 组件、StaticMesh 资产和带 sidecar 的 voxel grid 后端。字段为 `{ "x": 0, "y": 0, "z": 0, "space": "component_local" }`；StaticMesh 使用 `component_local` / `asset_local` / `world`，voxel grid 额外支持 `grid` / `grid_local` / `voxel_grid`。
- `preserve_world_geometry`：可选；当前只支持 `true` 或省略。`false` 会返回 `unsupported_preserve_world_geometry_false`。
- `apply_to_all_lods`：可选；StaticMesh 后端默认 `true`，会写所有 source LOD；raw EditPivotTool 路径映射到 UE `UEditPivotToolProperties.bApplyToAllLODs`。
- `asset_write_policy`：可选；默认 `require_unique_asset`。支持：
  - `require_unique_asset`：若当前打开世界里有多个 StaticMeshComponent 引用同一 StaticMesh，返回 `static_mesh_asset_is_shared`，不静默修改共享资产。
  - `duplicate_if_shared`：若当前打开世界里检测到共享引用，先复制 StaticMesh 资产；目标是组件时会把该组件重绑到复制资产，再只写复制资产。
  - `allow_shared_asset` / `allow_selected_assets`：显式允许原地修改共享 StaticMesh，返回 `shared_asset_modified=true` 和受影响组件数。
  - `editor_pivot_offset_only`：只写 Actor 的编辑器 `PivotOffset`，不修改 mesh 顶点、不修改 simple collision，也不改变 `modeling_get_mesh_spatial_info` 的 mesh pivot ratio。
- `duplicate_asset_path` / `destination_asset_path`：可选；配合 `duplicate_if_shared` 指定复制后的 StaticMesh 资产包路径。省略时，`/Game` 资产在原包旁生成，非 `/Game` 源资产生成到 `/Game/UAI/Pivot/`。
- `readback`：可选；单 Actor EditPivotTool 路径可附带 `modeling_get_mesh_spatial_info` 读回。DynamicMesh / StaticMesh 写入后端默认返回 `pivot_before` / `pivot_after`。

DynamicMesh 组件后端：

- 触发条件：目标 Actor 解析到唯一 `UDynamicMeshComponent`，并传入 `preset` 或 `custom_point`。
- 空间语义：输入点为 component local 或 world；写入后通过平移 mesh 顶点并移动组件 world location 保持可见几何不动。
- 返回重点：`pivot_backend=dynamic_mesh_component`、`target`、`frame.bounds_space=component_local`、`pivot_point_component_local`、`pivot_before`、`pivot_after`、`geometry_preserved`、`world_bounds_origin_delta`、`world_bounds_extent_delta`、`collision_preserved`。

Voxel grid 后端：

- 触发条件：目标 Actor 解析到 `UDynamicMeshComponent`，且 Actor 带 `UAIEditableVoxelGrid:<grid_id>` tag 和 sidecar；带 sidecar 的体素产物不会走普通 DynamicMesh 顶点平移后端。
- 空间语义：sidecar `anchor` 表示 grid-local 中哪个点落在 Actor 原点。`GridToWorld` 继续表示未偏移体素网格到世界的稳定变换；mesh 顶点和 `UBoxComponent` 碰撞都按 `grid_point - anchor` 生成。
- 写入方式：`preset` 按当前生成 mesh 的 component-local AABB 求点；`custom_point.space=component_local/local/world` 会转换为新 anchor，`custom_point.space=grid/grid_local/voxel_grid` 直接作为新 anchor。写入后自动重建 mesh 和 exact-cover box collision，并保存 sidecar。
- 后续编辑：`modeling_voxel_grid_add_bounds/remove_bounds` 的 `bounds.space=world` 始终通过稳定 `GridToWorld` 转回 grid local，因此 pivot 改变后继续 add/remove/apply 不会因 Actor 原点移动而错位。需要稳定脚本坐标时推荐传 `grid` 或 `world`；`component_local/local/actor` 表示当前 Actor/component local，会加上 `anchor` 转回 grid local。
- 返回重点：`pivot_backend=voxel_grid`、`anchor_before`、`anchor_after`、`pivot_point_component_local`、`pivot_point_grid_local`、`pivot_before`、`pivot_after`、`geometry_preserved`、`collision_preserved`、`voxel_apply.collision.coverage_matches_occupied_cells`。

StaticMesh 资产/组件后端：

- 触发条件：`asset_path` 指向 `UStaticMesh`，或目标 Actor 解析到唯一 `UStaticMeshComponent`，并传入 `preset` 或 `custom_point`。
- 空间语义：资产目标使用 `asset_local`；组件目标使用 `component_local`，`bounds_space=world` 时只用世界 AABB 计算目标点，再转换回组件 local 写入。
- 写入方式：对 MeshDescription 顶点整体减去目标 pivot local；对 BodySetup simple collision 的 sphere/box/capsule/tapered capsule/convex 形状应用同一个 local 偏移；随后 rebuild StaticMesh。
- 场景保真：对当前打开世界里受该资产影响的组件，写入后把组件 world location 移到“旧 pivot 点的世界位置”，保持可见几何和 simple collision 不错位。`duplicate_if_shared` 且目标是组件时，只重绑并移动目标组件。
- 不支持的碰撞形状：若资产包含 LevelSet、SkinnedLevelSet、MLLevelSet 或 SkinnedTriangleMesh simple collision，命令返回 `unsupported_static_mesh_collision_shape`，避免只移动 mesh 而留下错误碰撞。
- 返回重点：`pivot_backend=static_mesh_asset`、`asset_write_policy`、`asset_duplicated`、`source_asset_path`、`edited_asset_path`、`pivot_point_asset_local`、`pivot_before`、`pivot_after`、`open_world_reference_count`、`affected_components[]`、`collision`、`lods_touched`、`collision_preserved`。

Actor 编辑器 pivot offset 后端：

- 触发条件：`asset_write_policy=editor_pivot_offset_only` 且目标为 Actor / mesh component。
- 空间语义：用 preset 或 custom point 得到组件 local pivot，再转换为 Actor local `PivotOffset`。
- 行为边界：只影响编辑器选择/变换 pivot；mesh 顶点、StaticMesh 资产、DynamicMesh 顶点和 collision 都不变。
- 返回重点：`pivot_backend=actor_editor_pivot_offset`、`pivot_point_component_local`、`pivot_point_world`、`pivot_offset_actor_local`、`mesh_geometry_changed=false`、`collision_preserved=true`。

EditPivotTool wrapper 后端：

- 触发条件：SkeletalMeshComponent、raw wrapper 调用，或当前高层后端不覆盖的旧 EditPivotTool 参数组合。
- `preset` 会映射为 UE EditPivotTool action：`Center`、`Bottom`、`Top`、`Left`、`Right`、`Front`、`Back`、`WorldOrigin`。
- `bounds_space=world` 会映射为 `UEditPivotToolActionPropertySet.bUseWorldBox=true`。
- 该路径沿用 UE EditPivotTool 行为，会修改选中组件对应资产；需要 StaticMesh 共享资产安全策略时，使用上面的 StaticMesh 后端字段，不要依赖 raw wrapper。

### 4.7 UV 与材质槽

- `modeling_auto_uv`
- `modeling_project_uv`
- `modeling_set_material_slot`
- `modeling_add_material_slot`
- `modeling_remove_material_slot`

### 4.8 碰撞

- `modeling_generate_simple_collision`
- `modeling_generate_convex_collision`

#### 白盒要点：Dynamic Mesh 默认输出与碰撞

当前项目里，`modeling_create_*` 默认创建 `DynamicMeshActor`，不再默认落成 `StaticMeshActor` 或静态网格资产。

如果这些几何要参与“可玩白盒”（角色通行/净空/导航验收），必须把输出类型和碰撞验收一起明确：

1. 使用高层 `modeling_create_* + bounds` 时，默认按 primitive 类型生成碰撞：box/plane 使用 actor box component，sphere 使用 actor sphere component，stairs 使用逐级 box component，cylinder/ramp/ramp_corner 使用 DynamicMesh complex collision。`level_get_nearby_mesh_shapes` 会把 actor primitive collision components 作为 `primitive_collision` 返回；DynamicMesh complex collision 仍以 DynamicMesh component 自身参与实际 trace/sweep/玩家碰撞。
2. 透明占位、连接提示、区域标识支架等非正式阻挡物必须显式传 `collision.mode=none`；此模式会关闭视觉 DynamicMesh 的碰撞/query，不应再被 complex trace 当成可走面，并必须使用透明材质或独立调试文件夹，避免和正式白盒结构混淆。
3. 保持默认 `Dynamic Mesh` 时，仍要用 `level_trace_world_ray`、`level_sweep_capsule`、`level_sweep_capsule_path`、`level_check_overlaps` 或 `navmesh_build + navmesh_find_path` 回测真实通行表现；返回 `collision.generated=true` 不是通行验收的替代。
4. 需要静态网格资产本体碰撞时，显式设置 `CreateMeshObjectTypeProperties.OutputType=Static Mesh`，或复制/保存为 StaticMesh 后，再执行 StaticMesh folder `collision.json`、`modeling_generate_convex_collision` 等资产碰撞流程。

### 4.9 可编辑体素组件生成器

这一组命令用于脚本化创建或修改离散体素白盒，输出固定为 `DynamicMeshActor`，不经过 StaticMesh 资产化流程。其空间口径为：

- `grid` / `grid_local` / `voxel_grid`：稳定体素网格局部坐标，单位为 UE cm；不受 pivot/anchor 改变影响。
- `world`：世界轴对齐 bounds，会先通过稳定 `GridToWorld` 转换为 grid local AABB，再按 `cell_size` 做 cover 离散化；pivot/anchor 改变后仍适合继续编辑同一世界区域。
- `component` / `component_local` / `actor` / `actor_local` / `local`：当前 Actor/component local 坐标；若 sidecar 有 `anchor`，会先加上 `anchor` 转回 grid local。
- `cell_size` 必须大于 0；Actor scale 固定为 `1,1,1`，旋转和位移由 grid transform 表达。
- sidecar `anchor` 是体素可编辑真源的一部分；`modeling_set_pivot` 修改 voxel pivot 时会同步它，`apply` 再用同一 anchor 偏移 mesh 顶点和 exact-cover box collision。

#### `modeling_voxel_grid_begin`

- 作用：开始创建或编辑一个体素网格 session。
- 创建模式下 Actor object name 会在目标 Level outer 下生成唯一名；重复 `grid_id`、旧同名 Actor 或刚删除的 pending-kill 残留不得导致 UE `SpawnActor` assert 崩溃。稳定身份以 `grid_id`、Actor tag 和返回的 `actor_id` 为准，不以固定 object name 为准。
- 关键参数：
  - `mode`：`create` / `edit`，默认 `create`。
  - `session_id`：可选；不传则自动生成。
  - `grid_id`：可选；新建时不传则自动生成，编辑时可从 Actor tag 读取。
  - `actor_id`：编辑已有体素 Actor 时必填。
  - `grid.cell_size`：默认 `100`。
  - `grid.origin`、`grid.rotation`：新建时的 grid transform。
  - `label`、`folder_path`：新建 Actor 元数据。
- 关键返回：
  - `session_id`
  - `grid_id`
  - `actor_id`
  - `output_type=dynamic_mesh_actor`
  - `revision`
  - `sidecar_path`
  - `anchor`

#### `modeling_voxel_grid_add_bounds`

- 作用：把一个 bounds 覆盖到的体素加入当前 session。
- 关键参数：
  - `session_id`
  - `expected_revision`，可选；用于防止过期写入。
  - `bounds.space`：默认 `world`；推荐明确传 `grid` 或 `world`。
  - `bounds.min` + `bounds.max`，或 `bounds.center` + `bounds.extent`。
  - `max_operation_cells`：默认 `200000`。
- 离散化规则：`min` 使用 `floor(min / cell_size)`，`max` 使用 `ceil(max / cell_size)`，语义是 cover 而不是只取中心点。
- 关键返回：
  - `changed_cell_count`
  - `occupied_cell_count`
  - `revision`
  - `bounds.cell_range`

#### `modeling_voxel_grid_remove_bounds`

- 作用：从当前 session 剔除一个 bounds 覆盖到的体素。
- 参数与 `modeling_voxel_grid_add_bounds` 相同。
- 关键返回：
  - `changed_cell_count`
  - `occupied_cell_count`
  - `revision`
  - `bounds.cell_range`

#### `modeling_voxel_grid_apply`

- 作用：把 session 内占用体素生成到 `DynamicMeshComponent`，并生成可碰撞的 box 组件。
- 关键参数：
  - `session_id`
  - `expected_revision`，可选。
  - `mesh_build`：当前支持 `exposed_faces`，即只生成暴露面。
  - `collision.mode`：`merged_box_components` / `exact_box_components` / `none`，默认 `merged_box_components`。
  - `collision.max_boxes`：默认 `2048`。
  - `collision.profile_name`：默认 `BlockAll`。
  - `collision.enabled`：默认 `query_and_physics`。
  - `collision.replace_existing`：默认 `true`。
  - `material_path` / `material.path`：可选；显式指定输出 `DynamicMeshComponent` slot 0 材质。
  - `keep_session`：默认 `false`；传 `true` 后可继续 add/remove。
- 网格/材质语义：
  - `exposed_faces` 按 CubeGrid 可见面约定生成：triangle winding 使用 UE/Modeling front-facing 方向，normal overlay 仍指向占用体素外侧。
  - 无显式材质且组件当前只有默认/旧默认材质时，默认清空 `DynamicMeshComponent.BaseMaterials[0]`，与真实 CubeGrid 输出的 `(None)` 材质 slot 保持一致；UAI 不创建材质、不创建材质实例、不自行模拟 checker 参数。
  - 旧版 UAI 体素默认写入的 `/MeshModelingToolsetExp/Materials/SimpleBaseMaterial`，以及曾被误用为默认的 `/MeshModelingToolsetExp/Materials/InProgressMaterial`、`/MeshModelingToolsetExp/Materials/CheckerMaterial`，都会被视为可迁移默认值；再次 apply 且未显式传材质时会清空为 CubeGrid component default。
  - 编辑已有体素 actor 且组件已有真实自定义材质时，默认保留现有材质；需要强制替换时传 `material_path`。
- 碰撞语义：
  - 默认碰撞不是一个包住整体的 actor/world/mesh AABB。
  - 默认碰撞是对占用 cell 做 exact-cover 合并后的多个 `UBoxComponent`。
  - 只有所有占用 cell 本身构成完整长方体时，结果才可能退化为 1 个 box。
  - 返回 `collision.coverage_matches_occupied_cells=true` 时，表示生成 box 覆盖 cell 数与当前占用 cell 数一致。
- 关键返回：
  - `output_type=dynamic_mesh_actor`
  - `mesh.exposed_face_count`
  - `mesh.vertex_count`
  - `mesh.triangle_count`
  - `mesh.material.path`
  - `mesh.material.source`：`explicit` / `existing_component` / `cubegrid_component_default`
  - `collision.box_count`
  - `collision.covered_cell_count`
  - `collision.coverage_matches_occupied_cells`
  - `metadata.sidecar_path`
  - `metadata.anchor`

示例：

```json
{
  "command": "modeling_voxel_grid_begin",
  "params": {
    "mode": "create",
    "label": "EditableVoxel_01",
    "folder_path": "config/Voxel",
    "grid": {
      "cell_size": 100,
      "origin": { "x": 0, "y": 0, "z": 0 },
      "rotation": { "pitch": 0, "yaw": 0, "roll": 0 }
    }
  }
}
```

```json
{
  "command": "modeling_voxel_grid_add_bounds",
  "params": {
    "session_id": "VG_SESSION_xxx",
    "bounds": {
      "space": "grid",
      "min": { "x": 0, "y": 0, "z": 0 },
      "max": { "x": 300, "y": 100, "z": 100 }
    }
  }
}
```

```json
{
  "command": "modeling_voxel_grid_apply",
  "params": {
    "session_id": "VG_SESSION_xxx",
    "collision": {
      "mode": "merged_box_components",
      "max_boxes": 2048,
      "profile_name": "BlockAll"
    }
  }
}
```

## 5. 推荐调用顺序

### A. 创建新几何

1. `modeling_activate_mode`
2. `modeling_create_*` 或 `modeling_start_tool`
3. 需要时设置 `tool_properties`；默认输出为 `Dynamic Mesh`，需要资产化静态网格时显式传 `OutputType=Static Mesh`
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
| `modeling_create_box` | 使用 bounds 创建 DynamicMesh box，并默认生成 actor box collision | `bounds`、`rotation`、`folder_path`、`label`、`collision` | `created_actor`、`collision`、`derived_primitive` |
| `modeling_create_cylinder` | 使用 bounds 创建 DynamicMesh cylinder，并默认使用 DynamicMesh complex collision | `bounds`、`rotation`、`folder_path`、`label`、`collision` | `created_actor`、`collision`、`derived_primitive` |
| `modeling_create_plane` | 使用 bounds 创建 DynamicMesh plane，并默认生成 actor box collision | `bounds`、`rotation`、`folder_path`、`label`、`collision` | `created_actor`、`collision`、`derived_primitive` |
| `modeling_create_ramp` | 使用 bounds 创建沿局部 +X 抬升的 DynamicMesh ramp，并默认使用 DynamicMesh complex collision | `bounds`、`rotation`、`folder_path`、`label`、`collision` | `created_actor`、`collision`、`derived_primitive` |
| `modeling_create_ramp_corner` | 使用 bounds 创建 DynamicMesh corner ramp，并默认使用 DynamicMesh complex collision | `bounds`、`rotation`、`folder_path`、`label`、`collision` | `created_actor`、`collision`、`derived_primitive` |
| `modeling_create_sphere` | 使用 bounds 创建 DynamicMesh sphere，并默认生成 actor sphere collision | `bounds`、`rotation`、`folder_path`、`label`、`collision` | `created_actor`、`collision`、`derived_primitive` |
| `modeling_create_stairs` | 使用 bounds 创建 DynamicMesh stairs，并默认按踏步生成 simple collision | `bounds`、`rotation`、`folder_path`、`label`、`collision` | `created_actor`、`collision`、`derived_primitive` |
| `modeling_add_material_slot` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_align_to_world` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_auto_uv` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_bake_transform` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_boolean` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_convert_actor_to_dynamic_mesh` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_duplicate_to_new_static_mesh` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_extrude_faces` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_fill_holes` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_generate_convex_collision` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_generate_simple_collision` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_mesh_cut` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_mirror` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_offset` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_plane_cut` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_project_uv` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_recompute_normals` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_remesh` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_remove_material_slot` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_set_material_slot` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_simplify` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_subdivide` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_trim` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_voxel_boolean` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_weld_edges` | Modeling ToolWrappers 封装命令，内部设置 `tool_identifier` 后走 `modeling_start_tool` | `target_actor`、`asset_path`、`tool_properties`、`response_options` | `data` 摘要；debug/raw 返回工具细节 |
| `modeling_duplicate_faces` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_get_active_tool` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_get_active_tool_properties` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_get_mesh_selection_info` | **原子/兼容**：控制 Modeling Mode 工具、选择或网格编辑动作 | `target_actor`、`asset_path`、`tool_name`、`selection`、`properties` | `success`、`warnings`、`errors` |
| `modeling_get_mesh_spatial_info` | 读取网格体 AABB 与 pivot 在 AABB 内的相对位置 | `asset_path`、`actor_id`、`actor_label`、`actor_path`、`component_name`、`bounds_space` | `target.target_type`、`frame.bounds_space`、`frame.bounds_source`、`frame.unit`、`aabb.min`、`aabb.max`、`pivot_in_aabb.ratio` |
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
| `modeling_voxel_grid_add_bounds` | 创建/修改体素网格 session，把 bounds 覆盖到的 cell 加入占用集 | `session_id`、`expected_revision`、`bounds.space`、`bounds.min/max` 或 `bounds.center/extent` | `changed_cell_count`、`occupied_cell_count`、`revision`、`bounds.cell_range` |
| `modeling_voxel_grid_apply` | 把体素占用集生成到 DynamicMeshActor，并生成 exact-cover box collision | `session_id`、`expected_revision`、`mesh_build`、`collision.mode`、`collision.max_boxes`、`keep_session` | `output_type`、`mesh.*`、`collision.box_count`、`collision.coverage_matches_occupied_cells`、`metadata.sidecar_path`、`metadata.anchor` |
| `modeling_voxel_grid_begin` | 开始创建或编辑体素网格 session | `mode`、`session_id`、`grid_id`、`actor_id`、`grid.cell_size`、`grid.origin`、`grid.rotation` | `session_id`、`grid_id`、`actor_id`、`output_type`、`revision`、`sidecar_path`、`anchor` |
| `modeling_voxel_grid_remove_bounds` | 从体素网格 session 中剔除 bounds 覆盖到的 cell | `session_id`、`expected_revision`、`bounds.space`、`bounds.min/max` 或 `bounds.center/extent` | `changed_cell_count`、`occupied_cell_count`、`revision`、`bounds.cell_range` |

<!-- UAI_FORMAL_COMMAND_INDEX_END -->
