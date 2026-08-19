# 废弃指令：AnimBlueprint

> 本文件从 `../11_AnimBlueprint.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## 资产与编译

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_reparent` | **Deprecated for authoring**：修改父类 | `asset_path`、`parent_class`、`compile_after_reparent`、`save_after_reparent` |
| `anim_blueprint_set_cdo_property` | **Deprecated for authoring**：写默认对象属性 | `asset_path`、`property_name`、`value_text`、`compile_after_set`、`save_after_set` |

## Blueprint 级逻辑编辑

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_add_event_node` | **Deprecated for authoring**：新增标准事件节点 | `asset_path`、`graph_name`、`event_class`、`event_name`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_add_custom_event_node` | **Deprecated for authoring**：新增自定义事件节点 | `asset_path`、`graph_name`、`event_name`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_add_node_by_class` | **Deprecated for authoring**：按类新增通用 K2 / AnimGraph 节点 | `asset_path`、`graph_name` 或 `graph_path`、`node_class`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_add_call_function_node` | **Deprecated for authoring**：新增函数调用节点 | `asset_path`、`graph_name`、`function_owner_class`、`function_name`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_add_variable_node` | **Deprecated for authoring**：新增变量 Get/Set 节点 | `asset_path`、`graph_name`、`variable_name`、`node_type`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_connect_pins` | **Deprecated for authoring**：连接节点引脚 | `asset_path`、`graph_name`、`from_node_guid`、`from_pin`、`to_node_guid`、`to_pin`、`compile_after_connect`、`save_after_connect` |
| `anim_blueprint_disconnect_pins` | **Deprecated for authoring**：断开指定连线或某个引脚上的全部连线 | `asset_path`、`graph_name`、`from_node_guid`、`from_pin`、可选 `to_node_guid` / `to_pin`、`compile_after_disconnect`、`save_after_disconnect` |
| `anim_blueprint_set_pin_default_value` | **Deprecated for authoring**：设置引脚默认值 | `asset_path`、`graph_name`、`node_guid`、`pin_name`、`default_value`、`compile_after_set`、`save_after_set` |
| `anim_blueprint_remove_node` | **Deprecated for authoring**：删除图节点 | `asset_path`、`graph_name`、`node_guid`、`compile_after_remove`、`save_after_remove` |
| `anim_blueprint_add_variable` | **Deprecated for authoring**：新增变量定义；保留给 bootstrap / smoke / 局部补修 | `asset_path`、`variable_name`、`pin_category`、`pin_subcategory`、`pin_subcategory_object`、`container_type`、`value_type`（map 必填）、`default_value`、`instance_editable`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_remove_variable` | **Deprecated for authoring**：删除变量定义 | `asset_path`、`variable_name`、`compile_after_remove`、`save_after_remove` |
| `anim_blueprint_add_function_graph` | **Deprecated for authoring**：新增逻辑函数图 | `asset_path`、`function_name`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_add_macro_graph` | **Deprecated for authoring**：新增宏图 | `asset_path`、`macro_name`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_add_event_dispatcher` | **Deprecated for authoring**：新增事件分发器 | `asset_path`、`dispatcher_name`、`compile_after_add`、`save_after_add` |

## Layer Interface / Anim Layer

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_implement_layer_interface` | **Deprecated for authoring**：为 AnimBlueprint 实现一个 Layer Interface | `asset_path`、`interface_class`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_remove_layer_interface` | **Deprecated for authoring**：移除已实现的 Layer Interface | `asset_path`、`interface_class`、`preserve_functions`、`compile_after_remove`、`save_after_remove` |
| `anim_blueprint_add_anim_layer` | **Deprecated for authoring**：新增本地 Anim Layer graph | `asset_path`、`layer_name`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_rename_anim_layer` | **Deprecated for authoring**：重命名本地 Anim Layer graph | `asset_path`、`layer_name`、`new_layer_name`、`compile_after_rename`、`save_after_rename` |
| `anim_blueprint_remove_anim_layer` | **Deprecated for authoring**：删除本地 Anim Layer graph | `asset_path`、`layer_name`、`compile_after_remove`、`save_after_remove` |

## State Machine

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_add_state_machine` | **Deprecated for authoring**：在指定 AnimGraph 中新增状态机 | `asset_path`、`state_machine_name`、`anim_graph_name`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_rename_state_machine` | **Deprecated for authoring**：重命名状态机 | `asset_path`、`state_machine_name`、`new_state_machine_name`、`compile_after_rename`、`save_after_rename` |
| `anim_blueprint_remove_state_machine` | **Deprecated for authoring**：删除状态机 | `asset_path`、`state_machine_name`、`save_after_remove` |
| `anim_blueprint_set_entry_state` | **Deprecated for authoring**：把 Entry 连接到指定 State / Alias / Conduit | `asset_path`、`state_machine_name`、`state_name` 或 `node_guid`、`compile_after_set`、`save_after_set` |
| `anim_blueprint_clear_entry_state` | **Deprecated for authoring**：清空 Entry 当前连线 | `asset_path`、`state_machine_name`、`compile_after_clear`、`save_after_clear` |

## State / Conduit / Alias / Transition

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_add_state` | **Deprecated for authoring**：新增 State | `asset_path`、`state_machine_name`、`state_name`、`pos_x`、`pos_y`、`state_type`、`always_reset_on_entry`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_set_state_properties` | **Deprecated for authoring**：修改 State 的位置和基础属性 | `asset_path`、`state_machine_name`、`state_name` 或 `node_guid`、可选 `pos_x` / `pos_y` / `state_type` / `always_reset_on_entry`、`compile_after_set`、`save_after_set` |
| `anim_blueprint_add_conduit` | **Deprecated for authoring**：新增 Conduit | `asset_path`、`state_machine_name`、`conduit_name`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_add_state_alias` | **Deprecated for authoring**：新增 State Alias | `asset_path`、`state_machine_name`、`alias_name`、`pos_x`、`pos_y`、`global_alias`、`alias_target_states`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_rename_state_node` | **Deprecated for authoring**：重命名 State / Conduit / Alias | `asset_path`、`state_machine_name`、`state_name` 或 `node_guid`、`new_state_name`、`compile_after_rename`、`save_after_rename` |
| `anim_blueprint_remove_state_node` | **Deprecated for authoring**：删除 State / Conduit / Alias | `asset_path`、`state_machine_name`、`state_name` 或 `node_guid`、`save_after_remove` |
| `anim_blueprint_set_state_alias_targets` | **Deprecated for authoring**：修改 Alias 的目标状态集 | `asset_path`、`state_machine_name`、`alias_name` 或 `node_guid`、`alias_target_states`、`global_alias`、`compile_after_set`、`save_after_set` |
| `anim_blueprint_add_transition` | **Deprecated for authoring**：新增 Transition | `asset_path`、`state_machine_name`、`source_state_name`、`target_state_name`、`pos_x`、`pos_y`、`priority_order`、`crossfade_duration`、`bidirectional`、`disabled`、`automatic_rule`、`compile_after_add`、`save_after_add` |
| `anim_blueprint_set_transition_properties` | **Deprecated for authoring**：修改 Transition 的位置和基础属性 | `asset_path`、`state_machine_name`、`source_state_name/target_state_name` 或 `node_guid`、可选 `pos_x` / `pos_y` / `priority_order` / `crossfade_duration` / `bidirectional` / `disabled` / `automatic_rule`、`compile_after_set`、`save_after_set` |
| `anim_blueprint_remove_transition` | **Deprecated for authoring**：删除 Transition | `asset_path`、`state_machine_name`、`source_state_name/target_state_name` 或 `node_guid`、`save_after_remove` |

## 预览配置

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `anim_blueprint_set_preview_mesh` | **Deprecated for authoring**：设置或清空预览 SkeletalMesh | `asset_path`、`skeletal_mesh_path`、`clear_preview_mesh`、`save_after_set` |
| `anim_blueprint_set_preview_animation_blueprint` | **Deprecated for authoring**：设置或清空预览 AnimBlueprint overlay / linked graph 配置 | `asset_path`、`preview_anim_blueprint_path`、`clear_preview_animation_blueprint`、`preview_application_method`、`preview_animation_blueprint_tag`、`save_after_set` |

## 预览视口相机

| 指令 | 废弃说明 | 新流程 |
|---|---|---|
| `anim_blueprint_viewport_get_camera` | **Deprecated for viewport camera authoring**：AnimBlueprint Persona 预览视口相机读取已进入统一 Editor Viewport 状态命令。 | `editor_viewport_get_state`，target 使用 `scope=asset_editor`、`asset_type=anim_blueprint`。 |
| `anim_blueprint_viewport_set_camera` | **Deprecated for viewport camera authoring**：AnimBlueprint Persona 预览视口相机写入已进入统一 Editor Viewport 相机命令。 | `editor_viewport_set_camera`，target 使用 `scope=asset_editor`、`asset_type=anim_blueprint`。 |

### `anim_blueprint_set_preview_animation_blueprint`

### `anim_blueprint_set_preview_animation_blueprint`

- `preview_application_method` 支持：
  - `linked_layers`
  - `linked_anim_graph`
- `preview_animation_blueprint_tag` 主要用于 `linked_anim_graph`
