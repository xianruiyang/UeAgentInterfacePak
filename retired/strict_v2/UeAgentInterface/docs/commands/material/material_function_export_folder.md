# `material_function_export_folder`

将 `UMaterialFunction` 通过 Shared Authoring Core 的只读快照、Material projection 和共享 HJSON writer 导出为统一 workspace。

## 参数

| 参数 | 必需 | 说明 |
| --- | --- | --- |
| `asset_path` | 是 | 已挂载且可读取的 `UMaterialFunction` 资产路径。 |
| `output_folder` | 否 | 可选输出 workspace；verification readback 必须使用 request-scoped owned 路径。 |
| `profile` | 否 | `llm_authoring`、`readback`、`debug` 或 `validation`；默认 `llm_authoring`。 |

命令先生成完整 plan，再通过 owned staging publisher 一次发布显式 `output_folder` 或该资产的默认 Material Function workspace，最终只写 `index.hjson`；不会在 staging 完成前清空旧 final。旧的 `asset.hjson`、`function.hjson`、`graphs/` 和 `validation/` 不再生成。

## `index.hjson`

<!-- uai-hjson-file: index.hjson -->
```hjson
operation: update
target: { asset_path: "/Game/Materials/MF_Example", asset_kind: material_function }
properties: []
provider_extension: {
  function_settings: {
    description: "Example function"
    expose_to_library: true
  }
  graph: {
    expressions: {
      "<expression-guid>": {
        expression_class: "/Script/Engine.MaterialExpressionFunctionOutput"
        pos: { x: 40, y: 0 }
        properties: []
      }
    }
    edges: {
      "<stable-edge-key>": {
        from: { node: "<expression-guid>", output: "" }
        to: { node: "<expression-guid>", input: "" }
      }
    }
  }
}
```

节点与连接使用稳定身份键。普通 UObject 属性和 expression 属性走共享 editable-property projector；`function_settings` 只承载 Material Function 的领域设置。HJSON 同行、列表、复合值、特殊字符和 profile 字段裁剪由共享 writer 统一处理。

## 只读保证

Export 不重建编辑器图，不修改表达式、连接、布局、函数设置或 dirty 状态。输出只消费已捕获的 Shared State Snapshot。

## 返回

返回 `uai.export_workspace_result.v1`，包括相对 `entry_file`、完整 `written_relative_files`、绝对 `written_files` 和 `publisher`，并补充 `asset_path`、`asset_kind=material_function`、`folder_path` 和 `file_count=1`。导出结果可直接交给 `material_function_apply_folder` 回写。
