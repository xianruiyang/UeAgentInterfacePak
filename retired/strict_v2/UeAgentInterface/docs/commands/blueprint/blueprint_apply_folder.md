---
command: blueprint_apply_folder
category: blueprint
title: Blueprint 统一 HJSON Apply
summary: 通过共享 operation lifecycle 应用任意 Blueprintable 类的单文件 authoring workspace
aliases: []
tags: [blueprint, authoring, hjson]
status: active
---

# `blueprint_apply_folder`

读取 `index.hjson` 并通过 `uai.apply_workspace.blueprint.asset`、共享 workspace loader、operation coordinator、事务和 snapshot verification 创建或修改 Blueprint。通用 Blueprint 与 Actor Blueprint 走同一生命周期；SCS component authoring 只在实际父类具备 SCS 时生效。

## Parameters

- `asset_path`：外部目标约束，必须与 `index.hjson#/target/asset_path` 一致。
- `folder_path`：包含 `index.hjson` 的 workspace；省略时使用该资产的默认导出目录。

命令不再接受 `create_if_missing`、`compile_after_apply`、`save_after_apply` 或安全绕过参数。创建/更新行为由 `operation` 决定，compile/save 等领域执行选项在 `provider_extension` 中表达。

## Input

<!-- uai-hjson-file: index.hjson -->
```hjson
operation: update
target: { asset_path: "/Game/Example/BP_Example", asset_kind: actor_blueprint }
provider_extension: {
  parent_class: "/Script/Engine.Actor"
  compile: true
  save: false
  class_defaults: { properties: [] }
  members: { variables: {}, delegates: {} }
  components: {}
  graphs: {}
}
```

`asset_kind: blueprint` 表示通用 Blueprint；`actor_blueprint` 是要求父类继承 `AActor` 的窄类型断言。省略 `asset_kind` 时由现有资产或 `parent_class` 推导。父类是否合法始终以 UE 的 `CanCreateBlueprintOfClass` 为准，不由 UAI 自行维护类白名单。

Apply 输入可比 Export 多或少；Apply 只根据已提供的信息创建或修改实际对象，不从 Export 字段反推输入限制。缺失的创建内容优先来自 Blueprint factory、CDO、schema 和 UE 原生节点重建机制。

完整输入在 mutation 前完成 parse、identity resolve、依赖检查和 scratch completion。update 只修改目标成员、SCS、graph、node、pin、edge 和属性，不使用 whole-object copy。属性统一使用共享结构化 value codec。

Actor Blueprint 的 `components` 是稳定键对象映射，不以键名字典序表达组件创建顺序。Apply 会根据每个组件的 `parent` 建立依赖并稳定拓扑排序，保证父组件先于子组件创建；重复组件名、父组件在同批输入中被删除或父子循环会在 scratch preflight 阶段以精确错误拒绝，不会修改真实资产。非 Actor Blueprint 不会伪造 SCS；空组件映射可正常往返，非空组件输入会明确拒绝。

## Returns

成功返回 `status=applied`、`phase=complete`、`resolved_operation`、资产 identity、领域计数、preflight/mutation 计数和 rollback 状态。

失败时结构化 data 保留 `error_code` 与 `error_detail`。命令错误消息优先传递可操作的 `error_detail`，为空时才回退到 `error_code`，使 CLI/LLM 能直接看到具体组件、属性、节点或引脚原因。

## Validation

Apply 后立即执行 `blueprint_export_folder` 或结构化 snapshot readback。不能仅依据 HTTP `ok=true` 判断成功；Blueprint compile 和关键 component/node/member identity 必须同时通过。
