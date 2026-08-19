# 废弃指令：Material

> 本文件从 `../05_Material.md` 抽出，保留原分册章节结构。主分册只保留 JSON / 结构化 HJSON 主流程、读取、导出/应用、编译和诊断命令。

## 属性与实例参数

| 指令 | 作用 | 关键参数 | 说明 |
|---|---|---|---|
| `material_set_property` | **Deprecated for authoring**：设置材质或实例属性 | `asset_path`、`property_name`、`value_text` | 优先写 `settings/material.json` 或对应 folder JSON |
| `material_set_instance_parent` | **Deprecated for authoring**：修改实例父材质 | `asset_path`、`parent_material_path` | 优先写 `parent.json` |
| `material_set_parameter` | **Deprecated for authoring**：统一设置实例参数 | `asset_path`、`parameter_type`、`parameter_name` | 优先写 `parameters/overrides.json` |
| `material_set_scalar_parameter` | **Deprecated for authoring**：设置标量参数 | `asset_path`、`parameter_name`、`value` | 兼容旧入口 |
| `material_set_vector_parameter` | **Deprecated for authoring**：设置向量参数 | `asset_path`、`parameter_name`、`value`/`value_text` | 兼容旧入口 |
| `material_set_texture_parameter` | **Deprecated for authoring**：设置纹理参数 | `asset_path`、`parameter_name`、`texture_path` | 兼容旧入口 |
| `material_set_static_switch_parameter` | **Deprecated for authoring**：设置静态开关参数 | `asset_path`、`parameter_name`、`value` | 兼容旧入口 |

## 表达式图编辑

| 指令 | 作用 | 关键参数 | 说明 |
|---|---|---|---|
| `material_add_expression` | **Deprecated for authoring**：添加表达式节点 | `asset_path`、`expression_class` | 优先写 `graphs/*.json` |
| `material_set_expression_property` | **Deprecated for authoring**：设置节点属性 | `asset_path`、`expression_guid`/`expression_name`、`property_name`、`value_text` | 优先写 `graphs/*.json` |
| `material_connect_expressions` | **Deprecated for authoring**：连接节点到节点 | `asset_path`、`from_expression*`、`to_expression*` | 优先写 `graphs/*.json` |
| `material_connect_expression_to_property` | **Deprecated for authoring**：连接节点到材质属性 | `asset_path`、`expression*`、`material_property` | 优先写 `graphs/*.json` |
| `material_delete_expression` | **Deprecated for authoring**：删除表达式节点 | `asset_path`、`expression_guid`/`expression_name` | 优先写 `graphs/*.json` |

## `material_set_parameter`

这是保留的兼容统一入口，目的是在必须做局部修补时避免继续扩散命令数。完整实例参数 authoring 应优先编辑 `parameters/overrides.json` 后调用 `material_instance_apply_folder`。

`parameter_type` 目前支持：

- `scalar`
- `vector`
- `texture`
- `static_switch`
- `static_component_mask`

参数说明：

- `scalar`
  - 使用 `value`
- `vector`
  - 使用 `value:{r,g,b,a}` 或 `value_text`
- `texture`
  - 兼容旧字段 `texture_path`
  - 统一写法可用 `value_path`
- `static_switch`
  - 使用布尔 `value`
- `static_component_mask`
  - 可用 `value:{r,g,b,a}`
  - 也可直接传顶层 `r/g/b/a`
  - 返回 `resolved_value`
