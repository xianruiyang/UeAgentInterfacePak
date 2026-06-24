# 指令详解：AnimBlueprint

> 废弃写入命令已迁移到 `deprecatedCommand/11_AnimBlueprint.md`；本分册只保留主流程、读取、导出/应用、编译、诊断，以及尚未被 JSON / 结构化 JSON 覆盖的命令。

## 模块定位

这一组命令现在已经覆盖四层能力：

- AnimBlueprint / AnimLayerInterface 资产创建与编译
- 事件图 / 逻辑函数图 / 宏图 / 变量等 Blueprint 级逻辑编辑
- Anim Layer 与 Layer Interface 结构管理
- State Machine / State / Conduit / Alias / Transition 结构管理

另外还补了编辑器侧辅助能力：

- 图视图读写
- 预览视口相机读写
- 图 / 视口截图
- 预览网格 / 预览动画蓝图配置

## 资产与编译

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_create` | 创建普通 AnimBlueprint 资产 | `asset_path`、`parent_class`、`target_skeleton`、`preview_skeletal_mesh`、`template`、`compile_after_create`、`open_editor`、`save_after_create` |
| `anim_blueprint_create_layer_interface` | 创建 Anim Layer Interface 资产 | `asset_path`、`compile_after_create`、`open_editor`、`save_after_create` |
| `anim_blueprint_open_editor` | 打开资产编辑器 | `asset_path` |
| `anim_blueprint_compile` | 编译 AnimBlueprint / Layer Interface | `asset_path`、`include_messages`、`severity_filter`、`max_messages`、`save_after_compile` |
| `anim_blueprint_get_compile_log` | 编译并读取编译日志 | `asset_path`、`severity_filter`、`max_messages`、`save_after_compile` |
| `anim_blueprint_export_folder` | 导出为结构化文件夹 | `asset_path`、`clean_output_dir`、`include_validation` |
| `anim_blueprint_apply_folder` | 从结构化文件夹回写 | `asset_path`、`create_if_missing`、`compile_after_apply`、`save_after_apply` |
| `anim_blueprint_get_info` | 读取基础信息、图统计、预览配置和支持能力 | `asset_path` |
| `anim_blueprint_list_graphs` | 列出顶层图（EventGraph / FunctionGraphs / MacroGraphs / DelegateGraphs） | `asset_path` |

### `anim_blueprint_create`

- 默认父类：`/Script/Engine.AnimInstance`
- 支持三种创建口径：
  1. 显式传 `target_skeleton`
  2. 只传 `preview_skeletal_mesh`，由网格反推 skeleton
  3. `template=true`，创建模板动画蓝图

约束：

- `template=true` 时，不允许同时传 `target_skeleton` 或 `preview_skeletal_mesh`
- 非模板动画蓝图如果最终拿不到 skeleton，会直接失败

### `anim_blueprint_create_layer_interface`

- 这条命令创建的是 Animation Layer Interface 资产，不是普通 AnimBlueprint
- 创建后可继续通过 folder JSON 为它补 layer graph。

### `anim_blueprint_export_folder`

- 这是当前 `AnimBlueprint` 的主 authoring 工作流。
- 对状态机、AnimLayer、图节点属性很多的对象，推荐先写最小结构，再 export 一轮，让 UE 吐出真实模板后继续补全。
- 固定导出根目录：`Saved/UeAssetFolders/AnimBlueprint`
- 当前第一版会导出：
  - `asset.json`
  - `settings/anim_blueprint.json`
  - `members/*.json`
  - `layer_interfaces/interfaces.json`
  - `anim_layers/layers.json`
  - `state_machines/*.json`
  - `graphs/*.json`
  - 可选 `validation/checks.json`
- 逻辑图（`EventGraph / Function / Macro`）会复用现有 Blueprint 文件夹工作流，但在 AnimBlueprint 目录下统一落成 `node_kind` 风格的图 JSON。
- `AnimLayer / State / Conduit / Transition` 的子图不会混进 `state_machines/*.json`，而是按 `graphs/*.json` 单独导出。

### `anim_blueprint_apply_folder`

- 结构修改默认优先走这条文件夹式回写，而不是逐条节点命令手搓。
- 推荐方法同样是：
  1. 先写最小结构
  2. apply 生成真实资产
  3. export 看真实图/结构 JSON
  4. 再补更多字段
- 当前第一版按这条顺序回写：
  1. `asset.json`
  2. `settings/anim_blueprint.json`
  3. `members/*.json`
  4. `layer_interfaces/interfaces.json`
  5. `anim_layers/layers.json`
  6. `state_machines/*.json`
  7. `graphs/*.json`
  8. 编译 / 保存
- 默认 `compile_after_apply=true`。apply 会收集编译日志并返回 `compile_status`、`compile_error_count`、`compile_warning_count`、`compile_has_error`、`compile_messages[]`；如果有编译 error 或 Blueprint 状态为 `BS_Error`，命令失败返回 `compile_failed_after_apply`，并且不会执行最终 `save_after_apply`。
- 普通逻辑图和成员层当前复用 `blueprint_apply_folder` 代理回写。
- `AnimLayer / StateMachine` 结构层当前采用“按结构真源重建后再回填图”的策略，不做节点级 diff。
- 对已存在资产，`target_skeleton / template` 目前只在创建时生效；若与现有资产不一致，apply 会给 warning，不会强改现有资产。
  - 初始化某个局部结构
  - 结构化回写前后的 live 探针读取
  - schema 还没覆盖到的尾部字段
- `anim_blueprint_apply_folder` 在节点属性回写时会检查写后读回值；如果 `value_text` 与读回结果不一致，会进入 `warning_count / warnings`，消息包含请求值、读回值和 `cpp_type`。
- 可选文件（如 `settings/anim_blueprint.json`、`anim_layers/layers.json`、`layer_interfaces/interfaces.json`）只有不存在时才会跳过；文件存在但读取失败或 JSON 语法解析失败会直接失败返回并带文件路径。
- `anim_layers[]`、`implemented_interfaces[]` 中不是 object 或缺 `layer_name/interface_class` 的条目会进入 `warning_count / warnings[]`，不再静默忽略。

## Blueprint 级逻辑编辑

这一组命令是 `blueprint_*` 的 AnimBlueprint 前缀包装，参数语义保持一致，但 `graph_name` 现在可以直接指向 AnimBlueprint 的子图：

- State Machine graph
- State graph
- Transition graph
- Anim Layer graph

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_inspect_nodes` | 列出指定图里的节点与引脚 | `asset_path`、`graph_name`、`limit_per_graph`、`include_pins` |
| `anim_blueprint_layout_graph` | 自动排版指定 AnimBlueprint 图节点 | `asset_path`、`graph_name`、`horizontal_spacing`、`vertical_spacing`、`node_padding`、`dry_run`、`compile_after_layout`、`save_after_layout` |

说明：

- 普通 K2 节点和普通 AnimGraph 节点应通过 folder JSON 的图节点描述创建，`graph_name` 也支持直接传 `graph_path`。
- AnimBlueprint 节点 authoring 前必须先用 `anim_blueprint_list_graphs`、`anim_blueprint_inspect_nodes`、`anim_blueprint_export_folder` 或 `node_graph_list(adapter=anim_blueprint)` 读取真实图路径、节点 class、pin 和属性。不能凭 AnimGraph 菜单显示名、截图文字或记忆拼 `node_class`。
- 结构化图写入仍然不负责创建会附带子图或额外结构初始化的节点；例如 `StateMachine` 这类结构节点应走 AnimBlueprint folder workflow 中的状态机描述。
- 这一层主要处理 EventGraph / 逻辑函数图 / 宏图 / TransitionGraph，以及不带附属结构的 AnimGraph 节点施工。
- `anim_blueprint_layout_graph` 是 `blueprint_layout_graph` 的 AnimBlueprint 前缀包装；它只移动图节点坐标，不改状态机结构、AnimGraph 资产引用、transition rule 或业务逻辑。复杂状态机子图建议传 `graph_path`，避免重名。
- 文件夹式工作流当前已额外保留一小批 AnimGraph 节点属性真源，第一版明确覆盖：
  - `Node.BlendSpace`
  - `Node.Sequence`
  - `Node.bLoopAnimation`
  - `Node.ControlRigClass`
  - `Node.DefaultControlRigClass`
  - `Node.bExecute`
  - `Node.InputSettings` / `Node.InputSettings.bUpdatePose` / `Node.InputSettings.bUpdateCurves`
  - `Node.OutputSettings` / `Node.OutputSettings.bUpdatePose` / `Node.OutputSettings.bUpdateCurves`
  - `Node.Alpha` / `Node.AlphaInputType` / `Node.bAlphaBoolEnabled`
  - `Node.bSetRefPoseFromSkeleton` / `Node.AlphaCurveName` / `Node.LODThreshold`
  这意味着 `BlendSpace Player / RotationOffsetBlendSpace / Sequence Player / Sequence Evaluator` 这类资产引用节点，已经能在 `export_folder / apply_folder` 里稳定 round-trip 资产引用；`Sequence Player` 还会保留是否循环播放，避免 Jump/Attack 这类一次性状态在结构化导出后丢失 `Node.bLoopAnimation`。
  `AnimGraphNode_ControlRig` 也已经能稳定 round-trip Control Rig class、执行开关、输入/输出姿态同步设置和基础 Alpha/LOD 设置；完整 exposed variable mapping 仍按后续 profile 扩展处理。
- 如果某个 AnimGraph 节点不在上述导出模板、inspect 结果或明确支持 profile 中，必须先补 UAI 候选/模板读取能力或人工提供已验证模板；不得让 LLM 自行猜该节点类、内部 `Node.*` 属性和 pin。

### Control Rig 节点接入验证

Control Rig 资产能独立编译，不代表它已经在角色动画蓝图中执行。通过 `anim_blueprint_apply_folder` 接入或修改 Control Rig 节点后，必须编译并重新 export 或 inspect 节点，确认以下字段实际写入：

- `Node.ControlRigClass`
- `Node.DefaultControlRigClass`
- `Node.bExecute`
- `Node.InputSettings.bUpdatePose`
- `Node.OutputSettings.bUpdatePose`
- `Node.Alpha / Node.AlphaInputType / Node.AlphaCurveName / Node.LODThreshold`

如果 Control Rig probe 有效果但运行时角色无效果，优先排查节点类为空、`bExecute=false`、输入/输出 Pose 未同步、Alpha 为 0、LOD 被屏蔽、或 `AlphaCurveName` 指向的 AnimSequence 曲线没有有效权重。

## Layer Interface / Anim Layer

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_list_layer_interfaces` | 列出当前已实现的 Layer Interface | `asset_path` |
| `anim_blueprint_list_anim_layers` | 列出 Anim Layer，合并编辑图和编译函数视图 | `asset_path` |

### `anim_blueprint_list_layer_interfaces`

返回每个接口项：

- `interface_class`
- `interface_name`
- `graph_count`
- `graphs[]`

### `anim_blueprint_list_anim_layers`

返回每个 layer 项：

- `layer_name`
- `graph_name` / `graph_path`
- `has_graph`
- `compiled_function_found`
- `is_implemented`
- `implemented_interface`
- `input_pose_count` / `input_pose_names`
- `asset_player_node_count`
- `linked_anim_layer_node_count`
- `has_blend_options`

说明：

- 对“本地 layer”来说，通常 `has_graph=true`
- 对“由 interface 引入的 layer”来说，可能出现 `has_graph=false`，但 `compiled_function_found=true`

## State Machine

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_list_state_machines` | 列出所有状态机及其结构明细 | `asset_path` |

### `anim_blueprint_list_state_machines`

每个状态机项当前会返回：

- `state_machine_name`
- `graph_path`
- `owner_anim_graph_name`
- `has_entry_node`
- `entry_node_guid`
- `entry_connected_state_name` / `entry_connected_state_guid`
- `state_count` / `conduit_count` / `alias_count` / `transition_count`
- `state_names` / `conduit_names` / `alias_names`
- `state_nodes[]`
- `transition_nodes[]`
- `compiled_machine_found`
- `compiled_state_count` / `compiled_transition_count`
- `compiled_initial_state`

说明：

- 这是“结构盘点”命令，不是节点图编辑器替代物
- 返回同时包含编辑图结构和编译后 `BakedStateMachines` 统计

## State / Conduit / Alias / Transition

> 废弃写入命令已迁移到 `deprecatedCommand/11_AnimBlueprint.md` 的对应章节。

说明：

- `state_name` 在 `rename/remove` 里是节点显示名，不区分 state / conduit / alias；若有歧义，优先传 `node_guid`
- `add_transition` 默认按 `source/target` 中点放置 transition node；显式给 `pos_x/pos_y` 时用显式值
- `set_state_alias_targets` 目前只接受普通 `State` 作为 alias 目标，不接受 conduit 或 alias 再次作为目标
- `set_state_properties` 当前只作用于普通 `State`，不会改 Conduit / Alias

## 预览配置

> 废弃写入命令已迁移到 `deprecatedCommand/11_AnimBlueprint.md` 的对应章节。

> 废弃写入命令已迁移到 `deprecatedCommand/11_AnimBlueprint.md` 的对应章节。
## 图视图 / 预览视口 / 截图

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_graph_get_view` | 读取指定图的平移/缩放 | `asset_path`、`graph_name`、`open_editor_if_needed` |
| `anim_blueprint_graph_set_view` | 设置指定图的平移/缩放 | `asset_path`、`graph_name`、`view_x`、`view_y`、`zoom`、`snap_to_pixel_grid`、`update_document_view_state`、`save_after_set`、`open_editor_if_needed` |
| `anim_blueprint_viewport_get_camera` | 读取 AnimBlueprint 预览视口相机 | `asset_path`、`open_editor_if_needed` |
| `anim_blueprint_viewport_set_camera` | 设置 AnimBlueprint 预览视口相机 | `asset_path`、`location`、`rotation`、`fov`、`open_editor_if_needed` |
| `anim_blueprint_screenshot` | 对图面板 / 预览视口 / 窗口截图 | `asset_path`、`target`、`graph_name`、`format`、`quality`、`max_size`、`open_editor_if_needed` |

说明：

- `graph_name` 现在支持顶层图名、子图名，也支持直接传 `graph_path`
- 对 `State` Bound Graph、`Transition` Rule Graph 这类容易重名的子图，优先建议传 `graph_path`
- `anim_blueprint_graph_set_view` 复用 Blueprint 图视图入口；`snap_to_pixel_grid` 默认 `true`，会按 `round(view * zoom) / zoom` 对齐屏幕像素，避免非 1 缩放下图面文字和线缆发糊。`update_document_view_state` 默认同步 UE 下次打开图时使用的 `LastEditedDocuments`，`save_after_set=true` 时把该状态写入资产包。
- `viewport_*` 和 `screenshot target=viewport` 建议在真实 Editor 会话下验证；`NullRHI` 自动化不适合拿它们做稳定回归
- `anim_blueprint_screenshot` 复用 `blueprint_screenshot`，Slate UI 截图默认走离屏 WidgetRenderer；返回 `legacy_backbuffer_capture=disabled`，不再使用真实窗口 backbuffer 截图。

## 当前边界

当前仍然**没有**单独对外的能力：

- 任意 AnimGraph 节点的通用删除 / 连线原语
- 会附带子图或复杂初始化的结构型 AnimGraph 节点按类创建
- Transition 规则图内部的专用节点施工命令
- Notify / Slot / Layer Blend / Override / SyncGroup 等细粒度动画图编辑命令
- Persona 预览场景高级选项编辑

也就是说，这个模块现在是：

- `AnimBlueprint` 资产与结构命令：完整
- `AnimBlueprint` 文件夹式导出/回写：第一版可用
- `AnimBlueprint` 上的 Blueprint 级逻辑编辑：可用
- 任意动画节点级施工：仍未做成通用原语

补充说明：

- 当前已经能通过 `AnimGraph` 节点属性真源保留 `BlendSpace 1D/2D` 节点上的 `BlendSpace` 资产引用。
- 当前已经能通过 `AnimGraph` 节点属性真源保留 `Control Rig` 节点上的 `DefaultControlRigClass / ControlRigClass` 和基础 Alpha/LOD 设置。
- 但这不等于已经支持 `BlendSpace` 资产本体 authoring；当前仍没有单独的 `blendspace_*` 命令面。
- `Control Rig` 节点的 exposed variable mapping、input/output property binding 还不是完整独立 profile；需要时先 export 真实节点，再按导出的 `properties[] / pin_defaults[] / edges[]` 做结构化修改。

## 推荐流程

1. `anim_blueprint_create` 或 `anim_blueprint_create_layer_interface`
2. `anim_blueprint_export_folder`
3. 编辑 `members/*.json`、`layer_interfaces/interfaces.json`、`anim_layers/layers.json`、`state_machines/*.json`、`graphs/*.json`
4. `anim_blueprint_apply_folder`
5. `anim_blueprint_compile`
6. 需要检查结构时，用：
   - `anim_blueprint_list_anim_layers`
   - `anim_blueprint_list_layer_interfaces`
   - `anim_blueprint_list_state_machines`
   - `anim_blueprint_inspect_nodes`
7. 需要编辑器可视检查时，用：
   - `anim_blueprint_graph_get_view / set_view`
   - `anim_blueprint_viewport_get_camera / set_camera`
   - `anim_blueprint_screenshot`

## 废弃命令

本分册不再列出已废弃写入命令；这些命令仅保留在 `deprecatedCommand/11_AnimBlueprint.md`，供旧脚本兼容、bootstrap、迁移和故障补修查阅。
