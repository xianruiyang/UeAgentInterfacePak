---
command: ai_behavior_stack_validate_folder
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: AI Behavior Stack Validation
summary: 只读校验组合 AI 资产包的跨资产引用闭环
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject, composite_read_only]
status: active
---

# `ai_behavior_stack_validate_folder`

## Boundary

该命令只校验 `ai_behavior_stack_export_folder` 生成的组合包，不是 UObject authoring profile 的 Validate 入口。

- `authoring.state`: `none`
- side effects: none
- input: 组合只读导出目录
- writes: none

不得将校验成功解释为已修改行为树、黑板、EQS、StateTree 或 Smart Object。资产修改必须通过各自正式 profile 完成。

## Verification

检查 `status`、`asset_reference_results`、`errors`、`warnings` 和 `coverage_report`。失败时根据返回的 owner/type/path 定位到对应资产 profile 修复，再重新导出并校验。
