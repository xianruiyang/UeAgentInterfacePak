---
command: modeling_save_mesh_asset
category: modeling
title: 保存 Mesh Asset Package
summary: 保存指定或当前选中 Actor 引用的 Static Mesh package，并返回实际保存的 package paths。
aliases: []
tags: [modeling, mesh, save, package]
status: active
---

# `modeling_save_mesh_asset`

## LLM Compact

- **用途**：保存目标 Actor 的 Static Mesh package。
- **关键输入**：可选 `actor_ids[]`；省略时使用当前 Editor 选择。
- **关键返回**：`saved_package_count`、`saved_package_paths[]`。
- **边界**：返回的是本次实际提交保存的 package path，不是调用方传入的资产路径回显。

## Authoring Notes

- `actor_ids[]` 存在时只处理这些 Actor；省略时读取当前 Editor 选择。
- 命令解析 Actor 的 Static Mesh 组件，去重 package 后统一保存。
- 没有可保存的目标 Actor 或 Static Mesh package 时明确失败，不返回空列表成功。
- `saved_package_paths[]` 已排序，可直接用于后续读回、日志或确定性比较。

## Parameters

- `actor_ids`：可选字符串数组；Actor ID 来自 Modeling/Editor 选择或空间查询结果。省略时使用当前 Editor 选择。

## Returns

- `saved_package_count`：实际保存的唯一 package 数量。
- `saved_package_paths`：实际保存 package 的已排序路径数组。

## Errors

- `no_target_actors`：既未提供有效 Actor，也没有可用的当前选择。
- `no_static_mesh_packages_saved`：目标中没有可保存的 Static Mesh package，或没有 package 成功保存。

## Minimal Example

```json
{
  "actor_ids": [
    "StaticMeshActor_12",
    "StaticMeshActor_19"
  ]
}
```

## Validation

确认 `saved_package_count` 等于 `saved_package_paths[]` 的去重元素数量，并按返回路径读回对应 package/asset 状态。
