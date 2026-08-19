# 废弃指令：StaticMesh / EnhancedInput

> 本文件从 `../04_StaticMesh_EnhancedInput.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## StaticMesh

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `static_mesh_set_property` | **Deprecated for authoring**：设置网格资产属性 | `asset_path`、`property_name`、`value_text` | 能由 `asset_apply_property_json` 表达时优先走 JSON |
| `static_mesh_set_material_slot` | **Deprecated for authoring**：设置默认材质槽材质 | `asset_path`、`slot_index` 或 `slot_name`、`material_path` | 主流程优先改 `materials.json` 后 `static_mesh_apply_folder` |
| `static_mesh_set_collision_boxes` | **Deprecated for authoring**：设置简单碰撞 Box 列表 | `asset_path`、`boxes[]`、`clear_other_shapes` | 主流程优先改 `collision.json`；需要等价 `clear_other_shapes=true` 的凸包清理时写 `convex_hulls: []` 或 `clear_convex_hulls=true` |
| `static_mesh_set_collision_spheres` | **Deprecated for authoring**：设置简单碰撞 Sphere 列表 | `asset_path`、`spheres[]`、`clear_other_shapes` | 主流程优先改 `collision.json`；需要等价 `clear_other_shapes=true` 的凸包清理时写 `convex_hulls: []` 或 `clear_convex_hulls=true` |
| `static_mesh_set_collision_capsules` | **Deprecated for authoring**：设置简单碰撞 Capsule 列表 | `asset_path`、`capsules[]`、`clear_other_shapes` | 主流程优先改 `collision.json`；需要等价 `clear_other_shapes=true` 的凸包清理时写 `convex_hulls: []` 或 `clear_convex_hulls=true` |
| `static_mesh_add_socket` | **Deprecated for authoring**：新增 Socket | `asset_path`、`socket_name`、`location`、`rotation`、`scale` | 主流程优先改 `sockets.json`；默认 `replace_all=true` 表示最终 socket 集合，局部 patch 可写 `replace_all=false` |
| `static_mesh_update_socket` | **Deprecated for authoring**：修改 Socket | `asset_path`、`socket_name`、`new_socket_name` | 主流程优先改 `sockets.json`；默认 `replace_all=true` 表示最终 socket 集合，局部 patch 可写 `replace_all=false` |
| `static_mesh_remove_socket` | **Deprecated for authoring**：删除 Socket | `asset_path`、`socket_name` | 主流程优先改 `sockets.json` 中 `remove=true`；从最终状态中省略该 socket 也会被默认全量替换移除 |
| `static_mesh_set_preview_view` | **Deprecated for viewport camera authoring**：StaticMesh 编辑器预览相机已由统一 Editor Viewport 层覆盖。 | `asset_path`、`yaw`、`pitch`、`distance`、`fov` | 新流程使用 `editor_viewport_set_camera`，target 使用 `scope=asset_editor`、`asset_type=static_mesh`，相机使用 `camera.orbit`；需要截图时使用 `editor_viewport_screenshot`。 |

Deprecated: `static_mesh_set_preview_view` 的替代流程为 `editor_viewport_set_camera`；需要临时设置相机并截图时使用 `editor_viewport_screenshot`。

## EnhancedInput

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `enhanced_input_set_action_property` | **Deprecated for authoring**：修改 `InputAction` 属性 | `asset_path`、`property_name`、`value_text` | 优先编辑单文件 JSON 后 `enhanced_input_apply_action_json` |
| `enhanced_input_set_mapping_context_property` | **Deprecated for authoring**：修改 `MappingContext` 属性 | `asset_path`、`property_name`、`value_text` | 优先编辑单文件 JSON 后 apply |
| `enhanced_input_add_mapping` | **Deprecated for authoring**：添加 `Action-Key` 映射 | `mapping_context_path`、`action_path`、`key`、`modifier_classes`、`trigger_classes` | 优先编辑 `mappings[]` 后 apply |
| `enhanced_input_remove_mapping` | **Deprecated for authoring**：删除某条映射 | `mapping_context_path`、`action_path`、`key` | 优先编辑 `mappings[]` 后 apply |
| `enhanced_input_clear_mappings` | **Deprecated for authoring**：清空全部映射 | `mapping_context_path` | 优先用 JSON 全量替换 |
