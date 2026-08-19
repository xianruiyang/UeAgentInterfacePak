---
command: umg_apply_folder
category: umg
title: UMG 统一 HJSON Apply
summary: 通过共享 operation lifecycle 应用 Widget Blueprint 的单文件 authoring workspace
aliases: []
tags: [umg, authoring, hjson]
status: active
---

# `umg_apply_folder`

读取 `index.hjson`，通过 `uai.apply_workspace.umg.asset`、共享 workspace loader、依赖图、operation coordinator、事务和 snapshot verification 创建或修改 Widget Blueprint。

## Parameters

- `asset_path`：外部目标约束，必须与 `index.hjson#/target/asset_path` 一致。
- `folder_path`：包含 `index.hjson` 的 workspace；省略时使用该资产的默认导出目录。

命令不接受 `create_if_missing`、`compile_after_apply`、`save_after_apply` 或安全绕过参数。创建、更新、克隆和删除由 `operation` 决定；`compile` 与 `save` 在 `provider_extension` 中表达。

## Input

<!-- uai-hjson-file: index.hjson -->
```hjson
operation: update
target: { asset_path: "/Game/UI/WBP_Status", asset_kind: widget_blueprint }
provider_extension: {
  parent_class: "/Script/UMG.UserWidget"
  compile: true
  save: false
  members: { variables: {}, delegates: {} }
  widget_tree: {
    widgets: {
      "widget:StatusLabel": {
        name: StatusLabel
        class: "/Script/UMG.TextBlock"
        parent: RootCanvas
        properties: [
          { property_path: RenderOpacity, value: { literal: 0.75 } }
        ]
        slot: {
          class: "/Script/UMG.CanvasPanelSlot"
          properties: [
            { property_path: ZOrder, value: { literal: 9 } }
          ]
        }
      }
    }
  }
  bindings: {}
  animations: {}
  graphs: {}
}
```

Apply 输入可多可少，与 Export 字段集合无包含关系。创建缺失 Widget 时使用 WidgetTree/Panel 的 UE 原生创建接口；Slot 必须由实际父 Panel 创建，再校验 slot class 并应用显式属性。省略创建字段优先采用 factory、CDO、schema 和 UE 原生默认值；update 省略字段保持当前值。

完整 workspace 在真实资产 mutation 前完成 parse、identity resolve、parent/slot 依赖检查、scratch completion 和 compile preflight。Widget、Slot、class defaults 及递归 UObject/UStruct 属性统一使用 shared canonical value codec。

## Returns

成功返回 `status=applied`、`phase=complete`、`resolved_operation`、资产 identity、Widget/Slot/binding/animation/Blueprint graph 计数、preflight/mutation 计数和 rollback 状态。

## Validation

Apply 后立即执行 `umg_export_folder` 或结构化 snapshot readback。不能只依据 HTTP `ok=true`；还必须确认 Widget parent、实际 PanelSlot 类型、关键属性、Blueprint compile 与稳定 identity。
