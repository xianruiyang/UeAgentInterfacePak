---
command: level_topology_apply_json
category: level_topology_streaming_world_partition_data_layer_hlod
title: 拓扑编排
summary: 预检并批量应用 HJSON 拓扑关系
aliases: []
tags: [level_topology_streaming_world_partition_data_layer_hlod]
status: active
---

# `level_topology_apply_json`

## LLM Compact

- status: active.
- purpose: 预检并批量应用 streaming level、DataLayer、World Partition、HLOD 和 task 拓扑关系
- key_inputs: `json_file|input_file`, `json|topology|content|json_text`, `dry_run`, `allow_destructive`, `allow_delete`
- key_returns: `status`, `preflight`, `results[]`, `changed`, `completed_count`, `partial_commit`, `partial_commit_possible`, failure fields
- behavior: 默认 `dry_run=true`；所有请求先执行 validate/preflight，预检通过后才允许计划或写入。
- note: 高风险授权只读取顶层请求参数；HJSON 内容中的同名字段不能给整个 apply 自授权。
- validation: apply 后立刻 export/query readback；出现 `partial_failure` 时必须按 `results[]` 识别已提交步骤。

## Authoring Notes

- 命令名中的 `json` 是历史 API 名；authoring 文件统一使用 HJSON。
- `json_file`/`input_file` 传 `.json` 时规范化为同名 `.hjson` 再读取，不会读取原 `.json` 文件。
- apply 不是原子事务，也不承诺跨子操作回滚。运行期失败时，`partial_commit=true` 表示此前已有子操作成功提交。
- remove/delete、WP unload、HLOD clear、真实 commandlet build/resave/generate 等高风险子操作会在任何写入前统一检查请求侧授权。

## Parameters

- `json_file` / `input_file`：HJSON authoring 文件路径；`.json` 后缀会规范化为 `.hjson`。
- `json` / `topology` / `content`：兼容的 inline object 输入。
- `json_text`：兼容的 inline JSON 文本输入；不改变文件格式约定。
- `dry_run`：默认 `true`；预检通过后返回 `status=planned`，不执行子操作。
- `allow_destructive`：默认 `false`；真实执行中的 remove、delete、WP unload、HLOD clear 和写入型 commandlet 等需要显式授权。
- `allow_delete`：默认 `false`；真实执行中的 DataLayer delete、资产 delete 和 HLOD delete step 等需要显式授权。
- HJSON 内部的 `allow_destructive`/`allow_delete` 不替代以上请求侧参数。

## Returns

- `status`：`preflight_failed`、`planned`、`applied`、`failed` 或 `partial_failure`。
- `preflight`：`level_topology_validate_json` 的完整预检结果。
- `results[]`：按执行顺序记录各子操作的 `operation`、`ok`、`error` 和子命令返回。
- `changed`、`completed_count`：已完成写入摘要。
- `partial_commit`：失败时已有至少一个子操作成功提交则为 `true`。
- `partial_commit_possible`：运行期执行失败路径为 `true`；preflight/plan/success 路径为 `false`。
- `failed_operation`、`failed_error`：运行期失败的子操作和原因。
- `source`：inline key 或规范化后的 `.hjson` 文件路径。

## Validation

先用默认 dry-run 检查 `preflight` 和 `status=planned`。真实 apply 后执行 `level_topology_export_json` 或逐域 query；若 `partial_commit=true`，按 `results[]` 和 `completed_count` 逐项读回已提交状态，再决定补偿或继续，不能假设自动回滚。
