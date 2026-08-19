---
command: asset_export_property_json
category: core_level
title: `asset_export_property_json`
summary: 导出资产属性为 HJSON
aliases: []
tags: [core_level]
status: active
---

# `asset_export_property_json`

## LLM Compact

- status: active.
- purpose: 导出资产属性为 HJSON
- key_inputs: `asset_path`, `output_file`, `property_names[]`
- key_returns: 无显式字段；使用 `**params` 传入并按单命令契约确认。
- note: 这是当前“小型浅层资产”的主工作流；能被 `properties[]` 表达的逐条纯属性 setter 已迁移到对应 `deprecatedCommand` 分册。
- note: 对字段较多、但仍适合单文件 HJSON 的资产，推荐先最小创建，再导出属性 HJSON，当作真实模板继续补全。
- note: 传 `output_file` 时，默认把 UE Details 属性外置为 `details` 引用和相邻 `details/index.hjson` + group HJSON；结构正确的 inline `properties[]` 可用于没有对应 Details ref 的创建 seed。
- note: 命令名保留历史 `json`；authoring 文件格式为 HJSON，`output_file` 传 `.json` 会规范化写到同名 `.hjson`。
- note: UObject Details 使用唯一 schema `uai.uobject_properties.v2`；字段值 shape 见 `UObjectPropertyValueV2.md`。
- note: 如果某个默认属性在当前资产上不存在，会落到 `missing_properties[]`，不会中断整条导出。
- validation: 读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。

## Authoring Notes

- 这是当前“小型浅层资产”的主工作流；能被 `properties[]` 表达的逐条纯属性 setter 已迁移到对应 `deprecatedCommand` 分册。
- 对字段较多、但仍适合单文件 HJSON 的资产，推荐先最小创建，再导出属性 HJSON，当作真实模板继续补全。
- 传 `output_file` 时，默认编辑相邻 `details/index.hjson` 引用的 group `fields[]`；命令响应只保留 compact 摘要和路径。
- 命令名保留历史 `json`；authoring 文件格式为 HJSON，`output_file` 传 `.json` 会规范化写到同名 `.hjson`。
- 如果某个默认属性在当前资产上不存在，会落到 `missing_properties[]`，不会中断整条导出。
- `fields[]` 以 `property_path + value_kind + value` 为写入核心；容器同时输出不可改写的递归内层类型元数据。

## Parameters

- `asset_path`：UE 资产路径；支持 `/Game/...`，部分命令也支持 `/Engine/...`。
- `output_file`：输出 artifact 路径；authoring 文件使用 HJSON，`.json` 后缀会规范化为 `.hjson`。大结果应写文件，不要内联到 compact data。
- `property_names[]`：property_names 列表。

## Returns

- 未在旧分册命令表中列出；以实现返回和 readback 为准。

## Validation

读取 `CommandResult.data` 的关键返回字段；失败时只展开 `debug/envelope` 定位原因。
