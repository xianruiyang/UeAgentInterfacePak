---
command: pcg_graph_plan_folder
category: pcg
title: PCG Graph HJSON Plan
summary: 通过统一 authoring 预检生成 PCG Graph Apply 计划
aliases: []
tags: [pcg, authoring, hjson, plan]
status: active
---

# `pcg_graph_plan_folder`

## LLM Compact

- 使用与 Apply 完全相同的单 `index.hjson` loader、身份解析、默认值、类型解码和语义比较。
- 只返回生命周期与图变更计划，不执行 mutation、编译或保存。
- 计划基于当前资产读回；创建操作优先使用 UE 原生 `UPCGGraph` 默认对象补全缺失内容。

## Parameters

- `folder_path`：workspace 目录；也接受 `input_folder`、`folder`。
- `asset_path`：可选目标身份断言。

## Result

返回 `operation`、`asset_exists`、`would_create_asset`、`no_op`、计划节点/edge/节点属性计数和 `units_checked`。计划通过不代表已 Apply；需要写入时调用 `pcg_graph_apply_folder` 并显式设置 `dry_run: false`。

## Contract

目录必须只有 `index.hjson`。完整结构见 `pcg_graph_apply_folder`；任何 legacy 多文件结构均拒绝。
