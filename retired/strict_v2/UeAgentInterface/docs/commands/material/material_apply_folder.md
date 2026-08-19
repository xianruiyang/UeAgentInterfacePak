# `material_apply_folder`

从统一 `index.hjson` workspace 创建、更新或删除 `UMaterial`。目录加载、依赖解析、事务、回滚、默认值、属性 codec 和验证均走 Shared Authoring Apply。

## 参数

| 参数 | 必需 | 说明 |
| --- | --- | --- |
| `asset_path` | 是 | 外部目标约束，必须与 `index.hjson` 的 `target.asset_path` 一致。 |
| `folder_path` | 否 | 包含 `index.hjson` 的目录；省略时使用该资产的默认 Material workspace。 |

命令参数不再承载 `create_if_missing`、`compile_after_apply` 或 `save_after_apply`。生命周期和执行策略属于 HJSON 内容。

## 输入

<!-- uai-hjson-file: index.hjson -->
```hjson
operation: create
target: { asset_path: "/Game/Materials/M_Example", asset_kind: material }
properties: [
  { property_path: TwoSided, value_kind: bool, value: { literal: true } }
]
provider_extension: {
  compile: true
  save: false
  graph: {
    expressions: {
      "<expression-guid>": {
        expression_class: "/Script/Engine.MaterialExpressionConstant3Vector"
        pos: { x: -240, y: 0 }
        properties: [
          { property_path: Constant, value_kind: linear_color, value: { components: [0.2, 0.4, 1, 1] } }
        ]
      }
    }
    edges: {}
    root_inputs: {
      BaseColor: { from: { node: "<expression-guid>", output: "" } }
    }
  }
}
```

`operation` 支持 Material Apply Contract 声明的生命周期操作；`upsert` 在 preflight 解析为 `create` 或 `update`。缺失对象与结构体内容优先由 UE factory、CDO 和默认构造机制补全。`properties` 与表达式内部 `properties` 使用同一反射描述、PropertyValueCodec 和递归 Apply。

`expressions`、`edges`、`root_inputs` 接受身份键对象；图中节点引用统一使用 expression GUID。Apply 输入可多可少，与 Export 输出字段无集合约束。

`edges.*.to.input` 统一接受当前 UE UI 动态显示名、`FExpressionInput.InputName` 和反射字段名。动态改名节点可以使用稳定字段，例如 `MaterialExpressionNoise.Position`，即使当前 UI 将该 pin 显示为 `Absolute World Position`；Export 仍可输出当前显示名，二者都能无歧义回灌。Material Function Call 的动态函数输入继续以函数签名显示名为准。

## 返回与验证

成功返回 `status=applied`、`phase=complete`、`asset_path`、`asset_kind`、`object_path`、`folder_path`、`resolved_operation`、图计数、事务计数和回滚状态。执行失败不会把部分修改作为成功结果保留。

当 `provider_extension.save=true` 时，命令走 request-scoped durable package publish：从磁盘加载的 Material 会在 staging/publish 前释放 package loader；completed journal 成功后 package 必须为 clean。相同 `request_id` 与相同输入重放不会重复 mutation，也不会改写 completed receipt 或 `.uasset`；相同 ID 对应不同输入会被拒绝。`material_export_folder` 生成的根级 `.uai-export-owner` 属于 publisher metadata，Apply 会忽略该精确 marker，但仍拒绝其他未知文件。

写后使用 `material_export_folder` 进行快照读回；命令成功但 readback 不一致仍视为失败。
