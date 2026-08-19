---
command: anim_blueprint_apply_folder
category: anim_blueprint
title: Animation Blueprint 单文件应用
summary: 从 index.hjson 原子创建或更新 Animation Blueprint
aliases: []
tags: [anim_blueprint, animation, authoring, apply, hjson]
status: active
---

# `anim_blueprint_apply_folder`

## LLM Compact

- 加载整个 workspace，并通过统一 contract、preflight、native default、事务和语义读回链执行。
- `folder_path` 必须只包含 `index.hjson`。
- `asset_path` 只是可选身份断言；提供时必须与 HJSON 中的 `target.asset_path` 一致。
- Apply 根据实际输入创建或修改对象；其可接受内容与 Export 输出字段集合相互独立。
- 成功不能只看 HTTP `success`，还要检查 `status=applied`、`phase=complete` 并做资产读回。

## Apply Contract

- 支持 contract 声明的 `create`、`update`、`upsert`、`clone`、`remove` 操作。
- 缺失值优先来自 UE 原生 factory、CDO、archetype 或现有对象；不由 UAI 发明默认值。
- `properties` 支持任意合法 UObject/UStruct 的共享递归解析，包括 known struct、generic struct、container 和 UE-owned 子对象。
- 普通 object/class/interface/soft/weak reference 只替换引用，不递归修改外部对象。
- `provider_extension` 处理 `settings`、`blueprint`、`state_machines`；只读内容若显式提交且与实际值冲突，preflight 失败。
- 全部单元预检成功前不写入；失败按统一事务语义回滚。

## Parameters

- `folder_path`：必填，只包含 `index.hjson` 的 workspace 根目录。
- `asset_path`：可选，目标资产身份断言。

## Returns

- `status`：`applied` 或 `failed`。
- `phase`、`resolved_operation`、`asset_path`、`object_path`。
- `units_checked`、`mutations_applied`、`applied`。
- `rollback_attempted`、`rollback_succeeded`。
- 失败时返回 `error_code` 和 `error_detail`。

## Validation

Apply 后调用 `anim_blueprint_get_info` 或重新 export，核对目标 Skeleton、Blueprint 图和状态机等关键状态。`mutations_applied=0` 表示状态 no-op，不替代读回。

