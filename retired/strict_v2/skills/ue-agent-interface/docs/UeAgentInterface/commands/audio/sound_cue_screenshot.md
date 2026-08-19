---
command: sound_cue_screenshot
category: audio
title: SoundCue
summary: 截取 SoundCue 图诊断图
aliases: []
tags: [audio]
status: active
---

# `sound_cue_screenshot`

## LLM Compact

- status: active.
- purpose: 截取 SoundCue 图诊断图
- key_inputs: `asset_path`, `format`, `max_size`, `require_non_black`
- key_returns: `file_path`, `appears_non_black`
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 按本命令参数、返回字段和写后读回规则执行。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `format`：输出格式，例如 png/json/csv，取决于命令支持。
- `max_size`：截图或导出尺寸上限。
- `require_non_black`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Returns

- `file_path`：生成的 artifact 文件路径。
- `appears_non_black`：按命令实现读取/写入的字段；写入后用对应 readback 验证。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
