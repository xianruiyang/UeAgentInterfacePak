# DataAsset / DataTable JSON 指令

本分册覆盖数据驱动玩法资产的结构化 JSON 工作流：`UDataAsset / UPrimaryDataAsset` 实例资产、`UDataTable` 行数据，以及 Primary Asset 语义验证。

## 适用边界

- DataAsset 字段读写继续使用 UE `ImportText / ExportText` 的 `value_text`，便于和通用属性命令保持一致。
- DataTable 不是普通 UObject 属性集合，必须按 `row_struct`、`row_name`、字段导入结果和行策略做整体验证。
- `UCurveTable` 已由 `curve_export_json / curve_apply_json` 覆盖，本分册不重复定义 CurveTable 主流程。
- Asset Manager 的项目设置仍由 `project_settings_*` 或 `config_*` 编辑；`primary_asset_*` 只做只读扫描与语义验证。

## DataAsset / PrimaryDataAsset

| 命令 | 作用 | 关键参数 | 返回重点 |
| --- | --- | --- | --- |
| `data_asset_create` | 按类创建 `UDataAsset / UPrimaryDataAsset` 实例资产 | `asset_path`、`class_path`、`overwrite_policy`、`backup`、`save_after_create` | `asset_path`、`object_path`、`asset_class`、`backup_asset_path`、`saved` |
| `data_asset_export_json` | 导出 DataAsset schema 和字段当前值 | `asset_path`、`output_file`、`include_primary_asset` | `fields[]`、`field_count`、`class_schema_hash`、`primary_asset` |
| `data_asset_validate_json` | 只读验证 JSON 是否可导入 | `asset_path`、`class_path`、`json` 或 `json_file`、`allow_unknown_fields`、`validate_references`、`reference_policy` | `valid`、`issues[]`、`field_results[]` |
| `data_asset_diff_json` | 比较 JSON 目标字段与资产当前值 | `asset_path`、`json` 或 `json_file` | `changed`、`changed_count`、`field_diffs[]` |
| `data_asset_apply_json` | 预检通过后创建或回写 DataAsset | `asset_path`、`json` 或 `json_file`、`create_if_missing`、`backup`、`save_after_apply`、`allow_unknown_fields`、`validate_references` | `applied_field_count`、`field_results[]`、`backup_asset_path`、`read_back_hash` |
| `primary_asset_validate_asset` | 验证单个资产的 Primary Asset ID、注册状态、bundle 和加载探针 | `asset_path`、`expected_type`、`expected_id`、`validate_bundles`、`load_probe` | `valid`、`type_matches`、`id_matches`、`bundles[]`、`asset_manager_registered`、`issues[]` |
| `primary_asset_scan_assets` | 按 Primary Asset 类型读取 Asset Manager 扫描结果 | `primary_asset_type` 或 `type`、`paths[]`、`load_assets` | `found`、`asset_count`、`loaded_count`、`assets[]` |

### DataAsset JSON

```json
{
  "schema": "ue_agent_interface.data_asset.v1",
  "asset_path": "/Game/Data/DA_Item",
  "asset_class": "/Game/Data/BP_ItemData.BP_ItemData_C",
  "fields": [
    {
      "name": "Damage",
      "value_text": "25"
    },
    {
      "name": "Icon",
      "value_text": "/Script/Engine.Texture2D'/Game/UI/T_Sword.T_Sword'"
    }
  ]
}
```

写入规则：

- `asset_class` 必须能解析为 `UDataAsset` 派生类；创建缺失资产时必须提供。
- 所有字段先在临时对象中预检，全部通过后才写目标资产。
- 每个字段返回 `requested_value_text`、`applied_value_text`、`property_import_status`、`property_import_verified`、`value_text_exact_match` 和 `cpp_type`。
- 未知字段默认失败并返回 `data_asset_property_not_found`；迁移旧 schema 时可用 `allow_unknown_fields=true` 将未知字段降为 warning，但不会写入。
- `validate_references=true` 会对软引用、对象引用和类引用字段做存在性检查；`reference_policy=warning` 可把缺失引用降级为 warning。
- `include_primary_asset=true` 会附带对象自身 Primary Asset ID 与 Asset Manager 注册状态，用于区分“对象有 ID”和“项目配置已扫描到”。

## DataTable

| 命令 | 作用 | 关键参数 | 返回重点 |
| --- | --- | --- | --- |
| `data_table_export_json` | 导出 DataTable row schema 和 rows | `asset_path`、`output_file` | `row_struct`、`row_struct_schema_hash`、`row_policy=replace_all`、`row_schema[]`、`rows[]`、`row_count` |
| `data_table_validate_json` | 只读验证 DataTable JSON | `asset_path`、`json` 或 `json_file` | `valid`、`row_policy`、`row_results[]`、`issues[]` |
| `data_table_diff_json` | 比较目标 JSON 和当前表 | `asset_path`、`json` 或 `json_file` | `changed`、`row_added[]`、`row_removed[]`、`row_changed[]`、`field_changed[]`、`destructive_change_count` |
| `data_table_apply_json` | 创建或回写 DataTable | `asset_path`、`row_struct`、`row_policy`、`create_if_missing`、`backup`、`save_after_apply` | `applied_row_count`、`removed_row_count`、`destructive`、`backup_asset_path`、`read_back_hash`、`row_results[]` |
| `data_table_query_rows` | 局部查询 rows 和字段 | `asset_path`、`row_names[]`、`field_names[]`、`field_filters[]`、`limit` | `rows[]`、`row_count` |
| `data_table_sample_rows` | 对指定行字段做断言采样 | `asset_path`、`checks[]` | `passed`、`failed_count`、`checks[]` |

### DataTable JSON

```json
{
  "schema": "ue_agent_interface.data_table.v1",
  "asset_path": "/Game/Data/DT_Items",
  "row_struct": "/Script/GameplayTags.GameplayTagTableRow",
  "row_policy": "replace_all",
  "rows": [
    {
      "row_name": "Sword",
      "fields": [
        {
          "name": "Tag",
          "value_text": "Item.Sword"
        },
        {
          "name": "DevComment",
          "value_text": "Starter sword"
        }
      ]
    }
  ]
}
```

行策略：

- `merge`：新增或替换 JSON 中出现的 rows，不删除未出现行。
- `replace_all`：清空并以 `rows[]` 作为最终表内容。
- `patch`：支持 `add_rows[]`、`update_rows[]` 和 `remove_rows[]`，适合大表局部编辑。

验证规则：

- 新建 DataTable 必须提供 `row_struct`，且结构体必须继承 `FTableRowBase`。
- 已有 DataTable 的 `row_struct` 与 JSON 不一致时默认失败，返回 `data_table_row_struct_mismatch`。
- 行名必须是非空 `FName`，重复行名返回 `data_table_duplicate_row_name`。
- 字段名必须存在于 RowStruct；未知字段返回 `data_table_field_not_found`。
- 字段值用 `ImportText` 导入到临时行，失败返回 `field_import_failed`。
- `apply` 前会先完成整体验证；失败时不会修改目标资产。
- `diff` 会做字段级真实比较；无差异时 `changed=false` 且 `diff_count=0`。
- `apply` 会在回写后重新导出读回并返回 `read_back_hash`，删除行、替换结构体等破坏性变化会标记 `destructive=true`。
- `backup=true` 会在覆盖已有 DataAsset/DataTable 前创建备份副本并返回 `backup_asset_path` / `backup_object_path`。

### 查询与采样

`data_table_query_rows` 支持按行名、字段名、字段过滤和数量上限局部读取：

```json
{
  "asset_path": "/Game/Data/DT_Items",
  "row_names": ["Sword"],
  "field_names": ["Tag", "DevComment"],
  "field_filters": [
    {
      "field": "Tag",
      "op": "==",
      "value_text": "Item.Sword"
    }
  ],
  "limit": 16
}
```

`data_table_sample_rows` 用于 smoke、发布前检查和运行前数据校验：

```json
{
  "asset_path": "/Game/Data/DT_Items",
  "checks": [
    {
      "row_name": "Sword",
      "field": "Tag",
      "op": "==",
      "value_text": "Item.Sword"
    }
  ]
}
```

支持的比较符包括 `==`、`!=`、`contains`，数值字段额外支持 `>`、`>=`、`<`、`<=`。

## 与既有指令的关系

- 已有 `asset_export_property_json / asset_apply_property_json` 适合普通 UObject 属性批量读写；DataAsset 专用命令补齐“按 DataAsset 类创建实例、DataAsset schema round-trip、Primary Asset 语义验证”。
- 已有 Blueprint 类型别名能创建 `datatable` 变量或 `datatablerowhandle` 字段；DataTable 专用命令负责表资产自身的 rows CRUD。
- 已有 `curve_export_json / curve_apply_json` 已覆盖 CurveTable，因此不新增 `curve_table_*`。
