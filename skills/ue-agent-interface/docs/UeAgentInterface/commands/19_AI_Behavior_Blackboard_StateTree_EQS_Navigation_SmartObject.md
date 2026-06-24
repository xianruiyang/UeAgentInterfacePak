# AI Behavior / Blackboard / StateTree / EQS / Navigation / Smart Object

本分册记录 UeAgentInterface 的 AI 行为栈指令。日常使用优先走已定位 `UeAgentInterfaceCMD` 的 Python `uai_core` wrapper 或 `ue.batch(..., stop_on_error=True)`；默认候选找不到 UAICMD 时先向用户确认安装路径，确认没有可用 UAICMD 后才回退 skill 内置 CLI。底层传输仍由封装层调用 UAI 服务，不直接手写 HTTP。

实现覆盖 UE 5.6 下的 `UBlackboardData`、`UBehaviorTree`、`UStateTree`、`UEnvQuery`、AI Perception 组件读回/验证、Navigation 聚合探针、`USmartObjectDefinition` 与 Smart Object runtime 查询/claim/release。Smart Object Component、AI Perception Component、AIController/Pawn Blueprint、BT/StateTree 节点 Blueprint 内部图编辑继续复用现有 Blueprint / Actor / Component 指令，不新增重复 authoring 入口。

## 通用规则

- 路径字段使用 UE 资产路径，例如 `/Game/AI/BB_Guard`；返回通常同时包含 `asset_path` 与 `object_path`。
- 写入型命令默认不保存资产；需要保存时显式传 `save_after_create` 或 `save_after_apply`。
- 破坏性删除或结构替换必须显式传 `allow_destructive=true`。
- `dry_run=true` 与 `validate_only=true` 不应产生 dirty asset。
- `strict=true` 是显式严格校验开关；当前 v1 中 Blackboard 覆盖未知字段检查，其他 profile 以必填结构、类型、重复 id 和 class/schema 引用校验为主。
- JSON / folder workflow 的诊断使用 `warnings[]`、`errors[]`、`json_issues[]`、`property_results[]`、`coverage_report`。
- 截图命令默认要求非纯黑结果；可用 `require_non_black=false` 调试禁用该保护。

## Blackboard

Profile：`ue_agent_interface.blackboard.v1`。

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `blackboard_create` | 创建 `UBlackboardData` | `asset_path`、`parent_blackboard`、`keys[]`、`save_after_create` | `keys[]`、`created_asset`、`dirty`、`saved` |
| `blackboard_get_info` | 读取 key 与父黑板摘要 | `asset_path`、`include_parent_keys`、`include_raw_properties` | `parent_blackboard`、`keys[]` |
| `blackboard_export_json` | 导出单文件 JSON | `asset_path`、`output_file`、`include_parent_keys`、`include_validation` | `output_file`、完整 profile、`coverage_report` |
| `blackboard_validate_json` | 只读校验 JSON | `json_file`、`asset_path`、`strict` | `status`、`json_issues[]`、`coverage_report` |
| `blackboard_apply_json` | 回写 JSON | `json_file`、`asset_path`、`create_if_missing`、`dry_run`、`validate_only`、`save_after_apply`、`allow_destructive` | `changed`、`created_asset`、`saved`、`property_results[]`、`coverage_report` |

`keys[]` 支持 `name`、`type`、`key_type`、`instance_synced`、`base_class`、`enum/enum_type`、`description`、`category`、`_delete`。`type` 是 canonical 字段，`key_type` 是兼容别名；导出会同时写出。删除 key 需要 `allow_destructive=true`。

## Behavior Tree

Profile：`ue_agent_interface.behavior_tree.v1`。Folder workflow 默认文件包括 `asset.json`、`blackboard.json`、`tree.json`、`nodes.json`、`decorators.json`、`services.json`、`layout.json`、`validation/*.json`。当前 v1 写入主结构是 `tree.json.root_id + tree.json.edges[] + nodes.json.nodes[]`。

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `behavior_tree_create` | 创建最小 BT | `asset_path`、`blackboard_asset`、`root_composite`、`save_after_create` | `root_id`、`nodes[]`、`created_asset` |
| `behavior_tree_get_info` | 读取树结构 | `asset_path`、`include_nodes`、`include_properties`、`include_validation` | `blackboard_asset`、`nodes[]`、`edges[]`、`node_count` |
| `behavior_tree_export_folder` | 导出 folder JSON | `asset_path`、`folder_path`、`clean_output_dir`、`include_raw_properties`、`include_validation` | `folder_path`、`files[]`、`coverage_report` |
| `behavior_tree_validate_folder` | 只读校验 folder | `folder_path`、`asset_path`、`strict`、`validate_blackboard_keys` | `status`、`json_issues[]`、`coverage_report` |
| `behavior_tree_apply_folder` | 回写 BT | `folder_path`、`asset_path`、`create_if_missing`、`dry_run`、`validate_only`、`save_after_apply`、`allow_destructive` | `changed`、`created_asset`、`saved`、`coverage_report` |
| `behavior_tree_open_editor` | 打开编辑器 | `asset_path`、`bring_to_front` | `opened` |
| `behavior_tree_graph_get_view` | 读取图视图摘要 | `asset_path`、`open_editor_if_needed` | BT 摘要 |
| `behavior_tree_graph_set_view` | 请求图视图位置 | `asset_path`、`view_x`、`view_y`、`zoom`、`snap_to_pixel_grid`、`open_editor_if_needed` | `view_requested`、`view_x/y/zoom`、`snap_to_pixel_grid` |
| `behavior_tree_screenshot` | 截取 BT 编辑器 | `asset_path`、`format`、`max_size`、`open_editor_if_needed`、`require_non_black` | `file_path`、`width`、`height`、`capture_mode=offscreen_widget_renderer`、`legacy_backbuffer_capture=disabled`、`non_black_pixel_count`、`appears_non_black` |
| `behavior_tree_runtime_snapshot` | 读取运行中 BT / Blackboard | `controller` 或 `pawn`、`include_blackboard`、`include_active_path`、`include_service_status` | controller、BT component、Blackboard 摘要、保守 `active_path[] / running_task / service_status[]` 字段 |

BT apply 只修改 `UBehaviorTree` 本体，不隐式修改 BT Task Blueprint、AIController、Pawn、AnimBlueprint 或 StateTree。
`behavior_tree_graph_set_view` 当前只记录/回传请求，不直接驱动真实 BT 图面；为保持所有图视图入口一致，`snap_to_pixel_grid` 默认 `true`，返回前会按 `round(view * zoom) / zoom` 对齐屏幕像素。

## BT Node Blueprint 摘要

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `bt_node_blueprint_get_info` | 读取 BT Task / Decorator / Service Blueprint 或原生类摘要 | `asset_path` | `class`、`generated_class`、`parent_class`、`introspection_level=class_hierarchy_only`、`is_bt_task/is_bt_decorator/is_bt_service` |

创建和内部图编辑继续使用 `blueprint_create(parent_class=...)`、`blueprint_export_folder`、`blueprint_apply_folder`、`blueprint_compile`。当前 node-info v1 只承诺类层级和 BT 节点类型判定；事件图、Blackboard selector 变量和属性详情由 Blueprint folder workflow 读写。

## StateTree

Profile：`ue_agent_interface.state_tree.v1`。Folder workflow 写入主文件是 `asset.json` 与 `states.json`；导出还会写 `schema.json`、`parameters.json`、`transitions.json`、`tasks.json`、`conditions.json`、`evaluators.json`、`global_tasks.json`、`bindings.json`、`property_bag.json`、`graph_layout.json`、`validation/*.json` 作为摘要和校验证据。

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `state_tree_create` | 创建最小 StateTree | `asset_path`、`schema_class`、`root_state_name`、`save_after_create` | `ready_to_run`、`schema_class`、`states[]` |
| `state_tree_get_info` | 读取 StateTree 摘要 | `asset_path`、`include_states`、`include_bindings`、`include_validation` | `states[]`、`evaluators[]`、`global_tasks[]`、`compile_report` |
| `state_tree_export_folder` | 导出 folder JSON | `asset_path`、`folder_path`、`clean_output_dir`、`include_raw_properties`、`include_validation` | `folder_path`、`files[]`、`coverage_report` |
| `state_tree_validate_folder` | 只读校验 folder | `folder_path`、`asset_path`、`strict` | `status`、`json_issues[]`、`coverage_report` |
| `state_tree_apply_folder` | 回写 StateTree | `folder_path`、`asset_path`、`create_if_missing`、`dry_run`、`validate_only`、`save_after_apply`、`allow_destructive` | `changed`、`ready_to_run`、`compile_report`、`coverage_report` |
| `state_tree_open_editor` | 打开编辑器 | `asset_path`、`bring_to_front` | `opened` |
| `state_tree_screenshot` | 截取 StateTree 编辑器 | `asset_path`、`format`、`max_size`、`open_editor_if_needed`、`require_non_black` | `file_path`、`width`、`height`、`capture_mode=offscreen_widget_renderer`、`legacy_backbuffer_capture=disabled`、`non_black_pixel_count`、`appears_non_black` |
| `state_tree_runtime_snapshot` | 读取运行中 StateTree 组件 | `actor` 或 `component_name`、`include_active_states`、`include_tasks` | actor、component、run status、StateTree 引用、保守 `active_states[] / running_tasks[] / queued_events[]` 字段 |

StateTree v1 支持 schema 与 states 的结构化写入，tasks / conditions / transitions 通过 `states.json` 内嵌结构参与 round-trip；同名拆分 JSON 是导出摘要，节点 Blueprint 内部图继续复用 Blueprint workflow。

## StateTree Node Blueprint 摘要

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `state_tree_node_blueprint_get_info` | 读取 StateTree Task / Evaluator / Condition Blueprint 或原生类摘要 | `asset_path` | `class`、`generated_class`、`parent_class`、`introspection_level=class_hierarchy_only`、`is_state_tree_task/is_state_tree_condition/is_state_tree_evaluator` |

当前 node-info v1 只承诺类层级和 StateTree 节点类型判定；事件图和暴露属性详情由 Blueprint folder workflow 读写。

## EQS

Profile：`ue_agent_interface.eqs.v1`。Folder workflow 写入主文件是 `asset.json` 与 `options.json`；导出还会写 `generators.json`、`tests.json`、`contexts.json`、`validation/*.json` 作为从 options 派生的摘要和校验证据。

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `eqs_create` | 创建 `UEnvQuery` | `asset_path`、`template`、`save_after_create` | `options[]`、`created_asset` |
| `eqs_get_info` | 读取 query 摘要 | `asset_path`、`include_tests`、`include_properties` | generator/test/context 摘要 |
| `eqs_export_folder` | 导出 folder JSON | `asset_path`、`folder_path`、`clean_output_dir`、`include_raw_properties`、`include_validation` | `folder_path`、`files[]`、`coverage_report` |
| `eqs_validate_folder` | 只读校验 folder | `folder_path`、`asset_path`、`strict` | `status`、`json_issues[]`、`coverage_report` |
| `eqs_apply_folder` | 回写 EQS | `folder_path`、`asset_path`、`create_if_missing`、`dry_run`、`validate_only`、`save_after_apply`、`allow_destructive` | `changed`、`created_asset`、`coverage_report` |
| `eqs_run_query` | 在当前世界运行 query | `asset_path`、`querier`、`run_mode`、`max_results` | `items[]`、score / location / actor 摘要 |
| `eqs_debug_snapshot` | 运行并返回 debug 摘要 | `asset_path`、`querier`、`run_mode`、`max_results` | query 配置与运行结果 |

EQS 不替代 Navigation。若结果要用于移动，仍应使用 `navigation_path_probe` 或已有 `navmesh_find_path` 验证可达性。

## AI Perception

AI Perception 的组件挂载和属性配置由 Blueprint / Actor / Component 指令覆盖，本节只提供语义读回、验证和 runtime probe。

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `ai_perception_get_component_info` | 读取 Perception listener / stimuli source 组件 | `actor`、`component_name`、`include_sense_configs` | listener、sense configs、stimuli sources |
| `ai_perception_validate_setup` | 校验 listener/source 基础关系 | `actor` 或 `blueprint_asset`、`component_name`、`stimuli_sources[]`、`required_senses[]` | `listener`、`stimuli_sources[]`、`json_issues[]`、`status` |
| `ai_perception_runtime_snapshot` | 当前感知状态快照 | `controller` 或 `actor`、`include_stimuli` | perceived actors / stimuli 摘要 |
| `ai_perception_runtime_probe` | 按期望做感知探针 | `controller`、`target_actor` 或 `stimulus_actor`、`expected_sensed` | `probe_passed`、`successfully_sensed`、`target_stimuli[]`、单次 `samples[]` |

## Navigation

基础 NavMesh 构建、投影、查路、Bounds Volume 创建继续使用已有 `navmesh_*` 和 Level 指令。本节提供 AI 行为栈需要的聚合信息和探针。

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `navigation_get_info` | 聚合读取当前世界 Navigation 摘要 | `include_nav_data`、`include_bounds`、`include_agents` | nav data、bounds、agent config |
| `navigation_export_config_json` | 导出导航配置摘要 | `output_file` | `output_file`、navigation profile |
| `navigation_validate_level` | 校验关卡导航配置；传入 `nodes`/`sample_points` 时复用连通性验证 | `required_bounds`、`nodes` 或 `sample_points`、`strict` | Navigation 摘要、`json_issues[]`、`status`，或连通性 `results[]` |
| `navigation_path_probe` | 批量路径探针 | `start`、`targets[]` 或直接复用 `start/end`、`accept_partial_path` | `results[]`、`all_paths_found` |
| `navigation_area_cost_probe` | 读取 NavArea cost，可选附带路径 | `expected_areas[]`、`run_path_probe`、可选 `start/end` | `area_costs[]`，以及可选 path 结果 |
| `navigation_runtime_snapshot` | runtime 导航快照 | `include_nav_data`、`include_bounds` | navigation 摘要 |

`navigation_area_cost_probe` 默认在传入 `start/end` 时会附带路径探针；只想读取 area cost 时传 `run_path_probe=false`。

## Smart Object Definition

Profile：`ue_agent_interface.smart_object_definition.v1`。

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `smart_object_definition_create` | 创建 Definition | `asset_path`、`tags[]`、`slots[]`、`behavior_definitions[]`、`save_after_create` | `slots[]`、`created_asset` |
| `smart_object_definition_get_info` | 读取 Definition | `asset_path`、`include_properties` | tags、slots、behavior definitions |
| `smart_object_definition_export_json` | 导出单文件 JSON | `asset_path`、`output_file`、`include_validation` | `output_file`、完整 profile、`coverage_report` |
| `smart_object_definition_validate_json` | 只读校验 JSON | `json_file`、`asset_path`、`strict` | `status`、`json_issues[]`、`coverage_report` |
| `smart_object_definition_apply_json` | 回写 Definition | `json_file`、`asset_path`、`create_if_missing`、`dry_run`、`validate_only`、`save_after_apply`、`allow_destructive` | `changed`、`created_asset`、`property_results[]`、`coverage_report` |

Definition 顶层支持 `activity_tags[]` 或 `tags[]`。`slots[]` 支持 `id/name`、`local_transform` 或 `offset/rotation`、`activity_tags[]` 或 `tags[]`、`runtime_tags[]`、`behavior_definitions[]`。导出会同时写出兼容别名。当前 v1 回写采用 slot 列表重建模型：已有 slots 的资产必须传 `allow_destructive=true`，不支持单 slot `_delete` 或 `activity_requirements[]` 写回。Behavior Definition class 必须继承 `USmartObjectBehaviorDefinition` 且不能是 abstract。

## Smart Object Runtime / Setup

Smart Object Component 的创建、挂载、Definition 引用和 Actor 放置复用现有 Blueprint / Actor / Component 指令。本节只验证和驱动 runtime 关系。

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `smart_object_validate_setup` | 校验 Definition 与当前关卡 Actor 上 SmartObjectComponent 的引用关系 | `definition_asset`、`owner_actor_or_blueprint` | `status`、`json_issues[]`、definition 摘要、`component_owner`、`component_definition` |
| `smart_object_find` | 查询可用 Smart Object | `query_bounds`、`required_tags[]`、`max_results`、`include_claimed` | `result_count`、`results[]`、fallback diagnostics |
| `smart_object_claim` | claim 查询结果 | `result_id` | `claim_handle`、slot / actor 摘要 |
| `smart_object_release` | release claim | `claim_handle` | `released` |
| `smart_object_runtime_snapshot` | runtime 子系统快照 | 无 | `components[]`、`component_count`、`cached_find_result_count`、`active_claim_count` |
| `smart_object_runtime_probe` | find/claim/release 一体探针 | `query_bounds`、`expect_claimable`、`agent`、`expect_reachable` | `probe_passed`、`find_result`、`claim_result`、`navigation_result`、`release_result`、`cleanup_results[]` |

异常退出或测试结束前必须 release claim；`smart_object_runtime_probe` 默认会在 claim 后释放。`expect_reachable=true` 且提供 `agent` 时会把 agent 到 slot 的路径探针写入 `navigation_result`。

## AI Behavior Stack

Profile：`ue_agent_interface.ai_behavior_stack.v1`。该 profile 是跨资产 manifest 与验证入口，不隐式写入 BT、StateTree、Blueprint、Actor 或 Component。

| 指令 | 用途 | 关键参数 | 关键返回 |
| --- | --- | --- | --- |
| `ai_behavior_stack_export_folder` | 导出行为栈 manifest 与子资产快照 | `folder_path`、`name`、`blackboard_asset`、`behavior_tree_asset`、`state_tree_asset`、`eqs_asset(s)`、`smart_object_definition_asset(s)`、`ai_controller_blueprint`、`pawn_blueprint`、`manifest_file`、`include_asset_summaries` | `folder_path`、manifest、`written_files[]`、`coverage_report` |
| `ai_behavior_stack_validate_folder` | 只读校验跨资产引用闭环 | `folder_path`、`strict` | `status`、`warnings[]`、`errors[]`、`asset_reference_results[]`、`coverage_report` |
| `ai_behavior_stack_runtime_probe` | 聚合 runtime probe | `controller`、`pawn`、`actor`、`expected_blackboard_keys[]`、`expected_perception[]` | BT / StateTree / Perception / Navigation / Smart Object 摘要、单次 `samples[]`、`expectation_results[]`、`cleanup_results[]` |

## 测试覆盖

- Headless automation：`GptProjectTest.UeAgentInterface.Smoke.AIBehaviorStackCommands` 覆盖除编辑器 GUI 截图外的全部 AI 路由命令，包括 round-trip create/export/validate/apply、runtime snapshot/probe、Smart Object find/claim/release 和 Navigation path/area probe。
- Negative automation：`GptProjectTest.UeAgentInterface.Smoke.AIBehaviorStackFailurePaths` 覆盖坏 JSON、strict 未知字段、重复 id、class/schema 不存在、引用缺失、破坏性修改未 opt-in、`dry_run / validate_only` 不落资产等失败路径。
- GUI smoke：通过 `uai-cli batch` 实际打开 Behavior Tree 与 StateTree 编辑器并运行 `behavior_tree_open_editor`、`behavior_tree_screenshot`、`state_tree_open_editor`、`state_tree_screenshot`。
- 截图验收必须检查 `appears_non_black=true` 和 `non_black_pixel_count>0`。BT / StateTree 截图默认使用 `FWidgetRenderer` 离屏渲染编辑器窗口 widget，不再调用 `FSlateApplication::TakeScreenshot(SWindow)` 的 legacy backbuffer 路径，避免 D3D12/Slate swapchain 创建失败导致 UE 崩溃。
- Stack export smoke 断言 `manifest.json`、blackboard JSON、BT nodes、StateTree states、EQS split tests、Smart Object Definition 和 validation checks 都真实写入磁盘；`ai_behavior_stack_validate_folder` 同时检查 manifest asset 引用与 `written_files[]` 文件存在性。
