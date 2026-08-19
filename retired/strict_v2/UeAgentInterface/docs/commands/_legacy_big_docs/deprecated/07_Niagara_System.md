# 废弃指令：Niagara（System / Asset / User Parameter）

> 本文件从 `../07_Niagara_System.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## 资产级操作

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_delete_asset` | **Deprecated**：删除 Niagara System / Emitter / Script | `asset_path`、`force_delete`、`use_unchecked_delete` | 仅用于旧脚本兼容；新流程使用 `asset_delete` |

### `niagara_delete_asset`

已由通用 `asset_delete` 覆盖。新流程应先用 `asset_delete dry_run=true` 做引用和路径字符串 preflight，确认未被任何外部对象引用后再传 `dry_run=false` 删除。临时未保存 Niagara 资产需要显式传 `allow_dirty=true`。

旧命令保留兼容语义：`force_delete=true` 会使用无确认删除路径；当目标包尚未落盘，或显式传 `use_unchecked_delete=true` 时，会走 `delete_objects_unchecked`，避免临时 NiagaraScript 等未保存资产在 UE 的递归引用替换路径中长时间阻塞 UAI 服务。删除返回成功后会清理同路径残留的非公开/非 standalone UObject，避免同一编辑器会话内立刻重建时报 `asset_already_exists`。

## System 属性与编译

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_set_property` | **Deprecated for authoring**：设置 System 可反射属性 | `asset_path`、`property_name`、`value_text` | 仅用于局部修补 |

## System User 参数 CRUD

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_user_parameter_add` | **Deprecated for authoring**：新增 User 参数 | `asset_path`、`parameter_name`、`parameter_type`、`default_value_text` | 仅用于局部修补 |
| `niagara_user_parameter_remove` | **Deprecated for authoring**：删除 User 参数 | `asset_path`、`parameter_name` | 仅用于局部修补 |
| `niagara_user_parameter_set` | **Deprecated for authoring**：设置 User 参数值 | `asset_path`、`parameter_name`、`value_text` | 仅用于局部修补 |

## System 内 Emitter 管理

| 指令 | 作用 | 关键参数 | 典型用法 |
|---|---|---|---|
| `niagara_system_add_emitter` | **Deprecated for authoring**：向 System 添加 Emitter | `system_asset_path`、`emitter_asset_path`、`emitter_name` | 仅用于 bootstrap/修补 |
| `niagara_system_remove_emitter` | **Deprecated for authoring**：从 System 移除 Emitter | `system_asset_path` + (`emitter_id`/`emitter_name`/`emitter_index`) | 仅用于修补 |
| `niagara_system_move_emitter` | **Deprecated for authoring**：调整 Emitter 顺序 | `system_asset_path` + emitter 标识 + `target_index` | 仅用于修补 |
| `niagara_system_set_emitter_enabled` | **Deprecated for authoring**：启用/禁用某 Emitter | `system_asset_path` + emitter 标识 + `enabled` | 仅用于诊断/修补 |
| `niagara_system_set_emitter_version` | **Deprecated for authoring**：切换 Emitter 版本 | `system_asset_path` + emitter 标识 + `emitter_version` | 仅用于修补 |
