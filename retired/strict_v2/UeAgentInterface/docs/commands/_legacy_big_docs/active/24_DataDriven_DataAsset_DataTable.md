# DataDriven / DataAsset / DataTable

DataAsset 与 DataTable row 字段统一使用 `uai.uobject_properties.v2` canonical descriptor：

```hjson
fields: [
  { property_path: Damage value_kind: int32 value: { literal: 25 } }
  { property_path: Icon value_kind: soft_object_ref value: { path: /Game/UI/T_Sword.T_Sword } }
]
```

未知字段、重复 `property_path`、错误 `value_kind`、非法 canonical value 和引用类型不匹配会在 preflight 失败；不提供跳过未知字段的兼容开关。

## DataAsset

- `data_asset_export_json`
- `data_asset_validate_json`
- `data_asset_diff_json`
- `data_asset_apply_json`

创建或回写后必须重新 export，比较 canonical readback 和 `read_back_hash`。

## DataTable

- `data_table_export_json`
- `data_table_validate_json`
- `data_table_diff_json`
- `data_table_apply_json`
- `data_table_query`

`rows[].fields[]` 使用同一 descriptor。row add/remove/replace 属于 DataTable 领域结构；row 内属性值仍由公共 codec 解码和校验。

## Asset Manager

Primary Asset、label 和 bundle 命令保留各自领域 schema。只要字段映射到真实 FProperty，其叶子值必须使用同一 canonical value 规则。
