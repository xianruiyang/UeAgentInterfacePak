---
command: pcg_graph_validate_folder
category: pcg
title: PCG Graph HJSON Validate
summary: 通过统一 authoring 预检校验单个 PCG Graph index.hjson
aliases: []
tags: [pcg, authoring, hjson, validate]
status: active
---

# `pcg_graph_validate_folder`

## LLM Compact

- 读取与 Apply 相同的单 `index.hjson` workspace、身份、依赖和类型规则。
- 仅执行共享预检，不创建、修改、编译或保存资产。
- 未知文件、legacy 路径、未知字段、身份冲突、无效 Settings class、pin 或 edge 均失败。

## Parameters

- `folder_path`：workspace 目录；也接受 `input_folder`、`folder`。
- `asset_path`：可选目标身份断言，必须与 HJSON 目标一致。

## Result

返回 `valid`、`units_checked`、解析后的 `asset_path`，失败时返回稳定 `error_code` 和 `error_detail`。通过 Validate 只表示共享预检成立，不表示已经 Apply。

## Contract

完整 HJSON 结构、稳定节点/edge 身份和 typed property 规则见 `pcg_graph_apply_folder`。目录中除 `index.hjson` 外不得出现其他输入文件。
