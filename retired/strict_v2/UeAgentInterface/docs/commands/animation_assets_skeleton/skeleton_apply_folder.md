---
command: skeleton_apply_folder
category: animation_assets_skeleton
title: Skeleton 单文件应用
summary: 从 index.hjson 原子创建或更新 Skeleton
aliases: []
tags: [skeleton, animation, authoring, apply, hjson]
status: active
---

# `skeleton_apply_folder`

## LLM Compact

- 加载完整 workspace，并通过统一 contract、preflight、native default、事务和语义读回链执行。
- `folder_path` 必须只包含 `index.hjson`。
- `asset_path` 是可选身份断言；提供时必须与 HJSON 中的 `target.asset_path` 一致。
- Apply 可接受的合法内容与 Export 字段集合相互独立。
- 成功后检查 `status=applied`、`phase=complete` 并做 Skeleton 读回。

## Apply Contract

- 支持 contract 声明的 `create`、`update`、`upsert`、`clone`、`remove` 操作。
- 缺失值优先来自 UE 原生 factory、CDO、archetype 或现有对象。
- `properties` 走共享 UObject/UStruct 递归解析；UE-owned 子对象和容器内 owned object 使用同一 `owned_object` 机制。
- 普通外部对象引用不允许通过父对象属性隐式递归修改。
- `provider_extension` 处理 `settings`、`sockets`、`virtual_bones`、`slot_groups`、`retargeting`、`bones`。
- 只读内容冲突、未知字段、额外文件和不可靠引用均在写入前失败。

## Parameters

- `folder_path`：必填，只包含 `index.hjson` 的 workspace 根目录。
- `asset_path`：可选，目标 Skeleton 身份断言。

## Returns

- `status`、`phase`、`resolved_operation`。
- `asset_path`、`object_path`、`units_checked`、`mutations_applied`、`applied`。
- `rollback_attempted`、`rollback_succeeded`。
- 失败时返回 `error_code` 和 `error_detail`。

## Validation

Apply 后调用 `skeleton_get_info` 或重新 export，核对 sockets、virtual bones、slot groups 和 retargeting。不能只依赖命令成功标志。

