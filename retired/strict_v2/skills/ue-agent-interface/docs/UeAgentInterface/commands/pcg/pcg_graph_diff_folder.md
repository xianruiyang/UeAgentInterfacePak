---
command: pcg_graph_diff_folder
category: pcg
title: PCG Graph HJSON Diff
summary: 使用统一语义比较 PCG Graph index.hjson 与当前资产
aliases: []
tags: [pcg, authoring, hjson, diff]
status: active
---

# `pcg_graph_diff_folder`

## LLM Compact

- 读取与 Apply 相同的单 `index.hjson`，并对目标资产执行只读快照与语义比较。
- 节点、pin、edge 和 typed property 按稳定身份比较，不按文件顺序或 HJSON 排版比较。
- 相同值 descriptor 会在共享预检中消除；无变化返回 `no_op: true`、`change_count: 0`。
- 不执行 mutation、编译或保存。

## Parameters

- `folder_path`：workspace 目录；也接受 `input_folder`、`folder`。
- `asset_path`：可选目标身份断言。

## Result

返回 `different`、`no_op`、`change_count`、`would_create_asset` 和规范化目标。创建目标不存在时以 UE 原生 PCG Graph 默认对象作为比较基线。

## Contract

目录必须只有 `index.hjson`。完整结构见 `pcg_graph_apply_folder`；未知文件和 legacy 多文件结构拒绝。
