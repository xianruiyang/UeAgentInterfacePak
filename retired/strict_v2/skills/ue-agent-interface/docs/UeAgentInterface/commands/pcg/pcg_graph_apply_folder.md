---
command: pcg_graph_apply_folder
category: pcg
title: PCG Graph HJSON Apply
summary: 从单个结构化 index.hjson 预检或原子创建、修改 PCG Graph
aliases: []
tags: [pcg, authoring, hjson, apply]
status: active
---

# `pcg_graph_apply_folder`

## LLM Compact

- 输入目录必须只包含一个 `index.hjson`；未知文件、旧 `asset.hjson`、`graph.hjson`、`details/` 均拒绝。
- `dry_run` 默认 `true`；显式传 `false` 才进入共享事务并修改资产。
- `asset_path` 仅是可选身份断言；真实操作和目标由 `index.hjson` 决定。
- 创建、更新、克隆、删除和 upsert 复用统一对象生命周期、默认值、类型解码、事务、回滚及写后验证。
- 节点 key 是稳定身份；`authored_title` 如出现必须与 key 相同。

## Workspace Contract

`index.hjson` 顶层结构：

<!-- uai-hjson-file: index.hjson -->
```hjson
operation: upsert
target: { asset_kind: pcg_graph, asset_path: "/Game/PCG/PCG_Example" }
properties: []
provider_extension: {
  replace_nodes: true
  compile: true
  save: false
  graph: {
    nodes: {
      __input__: { role: input, position: [0, 0] }
      __output__: { role: output, position: [400, 0] }
      Grid: {
        settings_class: "/Script/PCG.PCGCreatePointsGridSettings"
        position: [180, 0]
        properties: []
      }
    }
    edges: {}
    parameters: {}
  }
}
```

- `operation`：`create | update | upsert | remove | clone`。
- `properties`：PCG Graph 根 UObject 的统一 typed property descriptor 列表。
- `graph.nodes`：按稳定节点身份组织；原生输入/输出节点用 `role`，普通节点用 `settings_class`。
- `graph.nodes.<id>.properties`：节点 Settings UObject 的统一 typed property descriptor 列表。
- `input_pins` / `output_pins`：按 pin 名组织的结构化 pin 描述；类型与方向由 PCG 节点语义校验。
- `graph.edges`：key 为 `FromNode:FromPin->ToNode:ToPin`，值包含结构化 `from` 与 `to`。
- `graph.parameters`：统一 property bag 结构。
- `provider_extension.replace_nodes`、`compile`、`save` 是 Apply 控制，不要求由 Export 输出。

## Parameters

- `folder_path`：workspace 目录；也接受命令参数别名 `input_folder`、`folder`。
- `asset_path`：可选 UE 资产路径断言，必须与 HJSON 目标一致。
- `dry_run`：默认 `true`。

## Result And Verification

成功结果包含解析后的操作、计划或实际节点/边/节点属性计数、`mutations_applied`、`no_op` 和回滚状态。非 dry-run Apply 后使用 `pcg_graph_snapshot` 或 `pcg_graph_export_folder` 读回；`compile: false`、`save: false` 且语义无变化时，`mutations_applied` 必须为 `0`。
