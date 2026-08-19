# 废弃指令：Control Rig / Control Rig Shape Library

> 本文件从 `../17_ControlRig_FolderFormat.md` 抽出，保留已被更通用流程覆盖的兼容命令。主分册只保留 Control Rig folder JSON 主流程、读取、导出/应用、编译、诊断、图视图和仍未被统一层覆盖的专用命令。

## 预览视口相机

| 指令 | 废弃说明 | 新流程 |
|---|---|---|
| `control_rig_viewport_get_camera` | **Deprecated for viewport camera authoring**：ControlRig Persona 预览视口相机读取已进入统一 Editor Viewport 状态命令。 | `editor_viewport_get_state`，target 使用 `scope=asset_editor`、`asset_type=control_rig`。 |
| `control_rig_viewport_set_camera` | **Deprecated for viewport camera authoring**：ControlRig Persona 预览视口相机写入已进入统一 Editor Viewport 相机命令。 | `editor_viewport_set_camera`，target 使用 `scope=asset_editor`、`asset_type=control_rig`。 |

旧命令仍保留兼容 wrapper，返回旧脚本依赖的 `location`、`rotation`、`fov`、`asset_kind` 和 `asset_path` 字段；新 authoring 应直接使用统一 `editor_viewport_*`。
