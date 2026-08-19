---
command: montage_apply_json
category: montage
title: 资产与基础信息
summary: 从单文件 HJSON 回写 Montage
aliases: []
tags: [montage]
status: active
---

# `montage_apply_json`

## LLM Compact

- status: active.
- purpose: 从单文件 HJSON 回写 Montage
- key_inputs: `json_file`, `create_if_missing`, `save_after_apply`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- validation: apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- 命令名和 `json_file` 参数名保留历史 `json`；authoring 文件格式为 HJSON，`json_file` 传 `.json` 时按同名 `.hjson` 读取。

## Parameters

- `json_file`：HJSON authoring 文件路径；传 `.json` 时按同名 `.hjson` 读取。长 HJSON 和可复用 payload 优先走文件。
- `create_if_missing`：按命令实现读取/写入的字段；写入后用对应 readback 验证。
- `save_after_apply`：布尔/开关字段；默认值以本命令契约为准。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

apply 后立刻 export/query readback，比较关键字段；不能只看 `success=true`。
