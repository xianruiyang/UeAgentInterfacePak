# `material_export_folder`

将 `UMaterial` 通过 Shared Authoring Core 的只读快照、Material projection 和共享 HJSON writer 导出为统一 workspace。

## 参数

| 参数 | 必需 | 说明 |
| --- | --- | --- |
| `asset_path` | 是 | 已挂载且可读取的 `UMaterial` 资产路径。 |
| `output_folder` | 否 | 可选输出 workspace；verification readback 必须使用 request-scoped owned 路径。 |
| `profile` | 否 | `llm_authoring`、`readback`、`debug` 或 `validation`；默认 `llm_authoring`。 |

未传 `output_folder` 时，导出目录由 `asset_path` 映射到 Material 默认 workspace。命令先生成完整 plan，再通过 owned staging publisher 一次发布，最终只写 `index.hjson`；不会在 staging 完成前清空旧 final，也不会生成 `settings/`、`parameters/`、`graphs/` 或 `validation/` 中间目录。

## `index.hjson`

<!-- uai-hjson-file: index.hjson -->
```hjson
operation: update
target: { asset_path: "/Game/Materials/M_Example", asset_kind: material }
properties: [
  { property_path: TwoSided, value_kind: bool, value: { literal: true } }
]
provider_extension: {
  graph: {
    expressions: {
      "<expression-guid>": {
        expression_class: "/Script/Engine.MaterialExpressionConstant3Vector"
        pos: { x: -240, y: 0 }
        properties: []
      }
    }
    edges: {
      "<stable-edge-key>": {
        from: { node: "<expression-guid>", output: "" }
        to: { node: "<expression-guid>", input: A }
      }
    }
    root_inputs: {
      BaseColor: { from: { node: "<expression-guid>", output: "" } }
    }
  }
}
```

节点、连接和根输入使用稳定身份键，避免重复身份字段。普通 profile 不输出 `operations`、`control_type`、`category_path` 或可靠结构化值对应的 `value_text`。同行、列表、复合值和特殊字符转义完全由共享 writer 决定。

## 只读保证

Export 不重建 MaterialGraph，不调用 Apply，不修改资产、表达式、连接、布局或 dirty 状态。输出值只来自捕获完成的 Shared State Snapshot。

## 返回

返回 `uai.export_workspace_result.v1` 的 `status`、`contract_id`、`profile_id`、`token_budget`、`metrics`、`files`、相对 `entry_file`、完整 `written_relative_files`、绝对 `written_files` 和 `publisher`，并补充 `asset_path`、`asset_kind`、`folder_path` 和 `file_count`。当前契约成功时 `file_count=1`。

导出的 `index.hjson` 可直接交给 `material_apply_folder` 回写；Apply 可接受的字段范围独立于 Export 展示范围。
