# 废弃指令：Blueprint

> 本文件从 `../02_Blueprint.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## 组件（SCS）

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `blueprint_add_component` | **Deprecated for authoring**：添加组件模板 | `asset_path`、`component_class`、`component_name`、`compile_after_add`、`save_after_add` |
| `blueprint_set_component_property` | **Deprecated for authoring**：设置组件模板属性 | `asset_path`、`component_name`、`property_name`、`value_text`、`compile_after_set`、`save_after_set` |
| `blueprint_remove_component` | **Deprecated for authoring**：删除组件模板 | `asset_path`、`component_name`、`compile_after_remove`、`save_after_remove` |
| `blueprint_add_component_bound_event` | **Deprecated for authoring**：新增组件绑定事件节点 | `asset_path`、`component_name`、`delegate_owner_class`、`delegate_property_name`、`compile_after_add`、`save_after_add` |

## 图与节点

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `blueprint_add_event_node` | **Deprecated for authoring**：新增标准事件节点 | `asset_path`、`graph_name`、`event_class`、`event_name`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `blueprint_add_custom_event_node` | **Deprecated for authoring**：新增自定义事件节点 | `asset_path`、`graph_name`、`event_name`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `blueprint_add_node_by_class` | **Deprecated for authoring**：按类新增通用图节点 | `asset_path`、`graph_name` 或 `graph_path`、`node_class`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `blueprint_add_call_function_node` | **Deprecated for authoring**：新增函数调用节点 | `asset_path`、`graph_name`、`function_owner_class`、`function_name`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `blueprint_add_variable_node` | **Deprecated for authoring**：新增变量 Get/Set 节点 | `asset_path`、`graph_name`、`variable_name`、`node_type`、`pos_x`、`pos_y`、`compile_after_add`、`save_after_add` |
| `blueprint_connect_pins` | **Deprecated for authoring**：连接节点引脚 | `asset_path`、`graph_name`、`from_node_guid`、`from_pin`、`to_node_guid`、`to_pin`、`compile_after_connect`、`save_after_connect` |
| `blueprint_disconnect_pins` | **Deprecated for authoring**：断开指定连线或某个引脚上的全部连线 | `asset_path`、`graph_name`、`from_node_guid`、`from_pin`、可选 `to_node_guid` / `to_pin`、`compile_after_disconnect`、`save_after_disconnect` |
| `blueprint_set_pin_default_value` | **Deprecated for authoring**：设置引脚默认值 | `asset_path`、`graph_name`、`node_guid`、`pin_name`、`default_value`、`compile_after_set`、`save_after_set` |
| `blueprint_remove_node` | **Deprecated for authoring**：删除节点 | `asset_path`、`graph_name`、`node_guid`、`compile_after_remove`、`save_after_remove` |

## 变量 / 函数 / 宏 / 委托

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `blueprint_add_variable` | **Deprecated for authoring**：新增变量定义；保留给 bootstrap / smoke / 局部补修 | `asset_path`、`variable_name`、`pin_category`、`pin_subcategory`、`pin_subcategory_object`、`container_type`、`value_type`（map 必填）、`default_value`、`instance_editable`、`compile_after_add`、`save_after_add` |
| `blueprint_remove_variable` | **Deprecated for authoring**：删除变量定义 | `asset_path`、`variable_name`、`compile_after_remove`、`save_after_remove` |
| `blueprint_add_function_graph` | **Deprecated for authoring**：新增函数图 | `asset_path`、`function_name`、`compile_after_add`、`save_after_add` |
| `blueprint_add_macro_graph` | **Deprecated for authoring**：新增宏图 | `asset_path`、`macro_name`、`compile_after_add`、`save_after_add` |
| `blueprint_add_event_dispatcher` | **Deprecated for authoring**：新增事件分发器（委托） | `asset_path`、`dispatcher_name`、`compile_after_add`、`save_after_add` |

> 变量类型解析与结构化 HJSON 共用同一套实现；常用和中频结构体、枚举、对象/类别名见 `../02_Blueprint.md`。

## 类级操作

| 指令 | 作用 | 关键参数 |
|---|---|---|
| `blueprint_reparent` | **Deprecated for authoring**：修改 Blueprint 父类 | `asset_path`、`parent_class` |
| `blueprint_set_cdo_property` | **Deprecated for authoring**：设置 CDO 默认属性 | `asset_path`、`property_name`、`value_text` |

## 蓝图预览视口相机

| 指令 | 废弃说明 | 新流程 |
|---|---|---|
| `blueprint_viewport_get_camera` | **Deprecated for viewport camera authoring**：Blueprint SCS 预览视口相机读取已进入统一 Editor Viewport 状态命令。 | `editor_viewport_get_state`，target 使用 `scope=asset_editor`、`asset_type=blueprint`、`viewport_role=components`。 |
| `blueprint_viewport_set_camera` | **Deprecated for viewport camera authoring**：Blueprint SCS 预览视口相机写入已进入统一 Editor Viewport 相机命令。 | `editor_viewport_set_camera`，target 使用 `scope=asset_editor`、`asset_type=blueprint`、`viewport_role=components`。 |

## 2026-04-22 更新

  - **Deprecated for authoring**：`blueprint_add_enhanced_input_action_event`

  - **Deprecated for authoring**：`blueprint_add_dynamic_cast_node`

  - **Deprecated for authoring**：`blueprint_add_enhanced_input_local_player_subsystem_node`

  - **Deprecated for authoring**：`blueprint_add_enhanced_input_add_mapping_context_node`
