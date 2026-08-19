---
command: curve_apply_json
category: core_level
title: `curve_apply_json`
summary: 创建或回写 Curve 资产结构化 HJSON
aliases: []
tags: [core_level]
status: active
---

# `curve_apply_json`

## LLM Compact

- status: active.
- purpose: 创建或回写 Curve 资产结构化 HJSON
- key_inputs: `asset_path`, `json_file`, `create_if_missing`, `curve`, `curve_kind`, `save_after_apply`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- note: 成功返回 `curve_read_back` 和 `json_issues[]`。
- note: 失败返回 `curve_json_apply_failed`，并在 `data.hjson_issues[]` 中给出完整路径。
- note: 未知字段会返回 `json_unknown_field`，并尽量给出“Did you mean”提示。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- 命令名和 `json_file` 参数名保留历史 `json`；authoring 文件格式为 HJSON，`json_file` 传 `.json` 时按同名 `.hjson` 读取。
- `curve_json`、`value_json` 等字段名是曲线/值的结构化负载，不是文件格式残留。
- 成功返回 `curve_read_back` 和 `json_issues[]`。
- 失败返回 `curve_json_apply_failed`，并在 `data.hjson_issues[]` 中给出完整路径。
- 未知字段会返回 `json_unknown_field`，并尽量给出“Did you mean”提示。
- key 缺 `value`、重复时间、非法 `interp_mode/tangent_mode/tangent_weight_mode/pre_infinity_extrap/post_infinity_extrap` 都会失败。
- 失败 apply 不会把目标资产标脏；Vector / LinearColor / CurveTable 等多通道或多行曲线采用临时对象整体验证，避免部分 channel/row 先写入。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `json_file`：HJSON authoring 文件路径；传 `.json` 时按同名 `.hjson` 读取。长 HJSON 和可复用 payload 优先走文件。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `curve`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `curve_kind`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
