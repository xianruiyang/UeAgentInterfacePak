---
command: level_content_validate_json
category: level_content
title: 指令
summary: 只读校验 Level Content JSON
aliases: []
tags: [level_content]
status: active
---

# `level_content_validate_json`

## LLM Compact

- status: active.
- purpose: 只读校验 Level Content JSON
- key_inputs: `content`, `json_file`, `strict`, `actor_only`
- key_returns: `feature_gates`, `schema`, `valid`, `issues[]`, `json_issues[]`
- behavior: 只读/计划类命令，不应修改 UE 状态。
- note: 这是只读校验入口；不得把 validate 结果当成已写入状态。
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- note: 本命令校验单文件 Level Content JSON。校验 `level_export_folder` 产出的多文件 folder package 时使用 `level_validate_folder`。
- validation: 写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。

## Authoring Notes

- 这是只读校验入口；不得把 validate 结果当成已写入状态。
- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- 本命令不递归读取 Level workspace；`index.hjson`、Actor/Component operation unit、identity、递归 properties 和空间契约校验使用 `level_validate_folder`。

## Folder Workflow Boundary

- 继续使用本命令：校验 `level_content_apply_json` 使用的单文件 `resources[]` / 兼容 `actors[]` payload。
- 改用 `level_validate_folder`：校验 `index.hjson`、`actors/items/<actor_id>/actor.hjson` 与 `actors/items/<actor_id>/components/<component_id>/component.hjson` 组成的统一 workspace。
- 两者都是 active；作用对象不同，不互相替代。

## Parameters

- `content`：内联 HJSON authoring 内容；长内容优先写入文件再传 `json_file`。
- `json_file`：HJSON authoring 文件路径；长 HJSON 和可复用 payload 优先走文件。
- `strict`：严格校验模式。
- `actor_only`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `feature_gates`：功能门禁/不可用能力摘要。
- `schema`：返回 payload schema。
- `valid`：校验是否通过。
- `issues[]`：issues 列表摘要；大列表应写入 output/artifact 或 debug。
- `json_issues[]`：json_issues 列表摘要；大列表应写入 output/artifact 或 debug。

## Validation

写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。
