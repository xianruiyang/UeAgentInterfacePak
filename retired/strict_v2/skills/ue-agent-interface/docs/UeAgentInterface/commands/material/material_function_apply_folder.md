# `material_function_apply_folder`

从统一 `index.hjson` workspace 创建、更新或删除 `UMaterialFunction`。目录加载、依赖解析、事务、回滚、属性 codec 和验证均走 Shared Authoring Apply。

## 参数

| 参数 | 必需 | 说明 |
| --- | --- | --- |
| `asset_path` | 是 | 外部目标约束，必须与 `target.asset_path` 一致。 |
| `folder_path` | 否 | 包含 `index.hjson` 的目录；省略时使用默认 Material Function workspace。 |

命令参数不再承载创建、更新、编译或保存开关；这些内容由 HJSON 的 `operation` 与 `provider_extension` 表达。

## 输入

<!-- uai-hjson-file: index.hjson -->
```hjson
operation: create
target: { asset_path: "/Game/Materials/MF_Example", asset_kind: material_function }
properties: []
provider_extension: {
  compile: true
  save: false
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
    edges: {}
  }
}
```

缺失内容优先使用 UE factory、CDO 和默认构造机制补全。顶层 `properties` 与 expression `properties` 使用统一反射描述、PropertyValueCodec 和递归 Apply；`function_settings` 只处理函数领域设置。Apply 输入与 Export 展示规则相互独立。

## 返回与验证

成功返回 `status=applied`、`phase=complete`、目标身份、`resolved_operation`、图计数、事务计数和回滚状态。写后通过 `material_function_export_folder` 进行只读快照验证。
