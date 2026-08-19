---
command: ai_behavior_stack_export_folder
category: ai_behavior_blackboard_statetree_eqs_navigation_smartobject
title: AI Behavior Stack Export
summary: 导出跨行为树、黑板、EQS、StateTree 和 Smart Object 的组合只读检查包
aliases: []
tags: [ai_behavior_blackboard_statetree_eqs_navigation_smartobject, composite_read_only]
status: active
---

# `ai_behavior_stack_export_folder`

## Boundary

该命令导出多个独立 AI 资产之间的引用和诊断快照，不代表单个 UObject authoring profile，也不注册 Apply、field contract 或 workspace mutation provider。

- `authoring.state`: `none`
- owner: AI composite readback command
- editable assets: 分别使用 `behavior_tree`、`state_tree`、`eqs` 等正式 profile
- output: 组合 manifest、引用结果和可选资产摘要

不得把导出目录作为 `ai_behavior_stack` Apply 输入，也不得恢复旧 `manifest.hjson/details/authoring/assets` 多目录 authoring contract。

## Parameters

按 CommandSpec 提供 `folder_path`、`manifest_file`、`name` 和可选摘要开关。

## Verification

检查 `status`、`folder_path`、`written_files` 和 `coverage_report`；需要修改子资产时，进入对应资产 profile 完成 Apply 后重新导出组合包验证引用闭环。
