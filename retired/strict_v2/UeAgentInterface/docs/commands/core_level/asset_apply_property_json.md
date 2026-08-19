---
command: asset_apply_property_json
category: core_level
title: `asset_apply_property_json`
summary: 从 HJSON 回写资产属性
aliases: []
tags: [core_level]
status: active
---

# `asset_apply_property_json`

## LLM Compact

- status: active.
- purpose: 从 HJSON 回写资产属性
- key_inputs: `asset_path`, `json_file`, `properties[]`, `save_after_apply`
- key_returns: `asset_path`, `object_path`, `asset_class`, `applied_property_count`, `property_results`, `saved`, `json_file`。
- note: 这是与 `asset_export_property_json` 成对的通用 UObject inline/single-file 回写入口；属性树最终进入共享 Workspace/Object Apply。
- note: 推荐流程是：导出 HJSON -> 只修改需要改变的 `properties[]` -> 回写，而不是长链路反复调用原子属性命令。
- note: 命令名和 `json_file` 参数名保留历史 `json`；authoring 文件格式为 HJSON，`json_file` 传 `.json` 时按同名 `.hjson` 读取。
- note: 先创建或导入最小可用资产
- note: 再 `export_property_json`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这是与 `asset_export_property_json` 成对的主回写入口。
- 推荐流程是：导出 HJSON -> 只修改需要改变的 `properties[]` -> 回写，而不是长链路反复调用原子属性命令。
- 命令名和 `json_file` 参数名保留历史 `json`；authoring 文件格式为 HJSON，`json_file` 传 `.json` 时按同名 `.hjson` 读取。
- 先创建或导入最小可用资产
- 再 `export_property_json`
- 再在导出结果上补高价值字段
- 再 `apply_property_json`
- `json_file` 是单文件 source，`properties[]` 是 inline source；两者最终都进入同一递归 UObject/UStruct Apply。v1、`property_name` 别名、裸标量、裸数组和 `value_text` 写入不再接受。
- 同一 owner 的属性先全部预检和临时解码，再统一提交并读回；任一字段失败或读回不一致时整组不落盘或整组回滚。
- 曲线结构化 HJSON 写入失败时，失败项会返回 `property_import_status=curve_json_apply_failed` 和 `json_issues[]`；未知字段、字段拼写相近、缺 key 值、重复 key 时间、非法插值/外推模式都会显式返回。
- 曲线属性写入会先在临时曲线上完整解析；失败时不会改写目标曲线，也不会把目标资产标脏。多通道曲线任一 channel 失败时，已解析成功的其它 channel 也不会被部分写入。

## Parameters

- `asset_path`：可从参数或 `json_file.asset_path` 读取；两者都缺失时返回 `missing_asset_path`。
- `json_file`：可选单 HJSON source；文件必须使用 `schema: uai.uobject_properties.v2` 并包含 `properties[]`。传 `.json` 时按同名 `.hjson` 读取。
- `properties[]`：可选 inline source；每项最小形状为 `{ property_path, value }`。`value_kind`、`struct_path`、`enum_path`、`element_type`、`key_type`、`mapped_type`、`inner_type`、`fixed_length`、`allowed_class` 只作为可选 assertion。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- `asset_path`、`object_path`、`asset_class`：实际写入对象 identity。
- `applied_property_count`：成功提交并通过读回的属性数。
- `property_results`：逐属性 `property_path/status`；compact view 默认不展开。
- `saved`：本次是否请求并完成保存。
- `json_file`：使用文件 source 时返回实际解析路径。

## Inline Example

```hjson
asset_path: "/Game/Data/DA_Example"
properties: [
  { property_path: Tint, value: { components: [0.2, 0.5, 1, 1] } }
  {
    property_path: Bounds
    value: { fields: { Min: { components: [-100, -100, 0] }, Max: { components: [100, 100, 300] } } }
  }
]
save_after_apply: false
```

basic/known struct 使用 canonical value codec；generic struct 的 `fields`、owned object 的 `owned_object.properties` 以及 container 的 item/key/value 会继续递归。普通外部对象引用只允许替换引用，不允许从父对象隐式递归修改。

## Errors

- `missing_asset_path`、`asset_not_found`、`missing_properties`：source 或目标不完整。
- `schema_mismatch_expected_uai.uobject_properties.v2`：单文件 schema 不是当前正式版本。
- `preflight_failed`：property descriptor shape 在 mutation 前失败；检查失败返回中的 `apply_summary`。
- `workspace_*`、`direct_*`、`property_*`、`struct_*`、`container_*`：共享 Workspace/Object Apply 的路径化失败。
- `external_reference_recursive_patch_forbidden`、`owned_object_reference_outside_owner`：违反对象递归边界。
- `save_asset_failed`：属性已进入写入阶段但资产保存失败；不得只凭 HTTP success 推断已落盘。

## Validation

成功后重新 `asset_export_property_json`，按 `property_path` 比较 canonical value。失败先读取 L0 error；只有 `preflight_failed` 等汇总错误不足以定位时，再读取 `apply_summary` 或 L1/L2 artifact。
