---
command: niagara_emitter_apply_folder
category: niagara_emitter
title: 从统一 index.hjson workspace 创建或修改 standalone Niagara Emitter
summary: 从统一 index.hjson workspace 创建或修改 standalone Niagara Emitter
aliases: []
tags: [niagara_emitter, hjson_authoring, unified_apply_export]
status: active
---

# `niagara_emitter_apply_folder`

## LLM Compact

- purpose: 从统一 index.hjson workspace 创建或修改 standalone Niagara Emitter
- key_inputs: `folder_path`, `emitter_asset_path`（也接受 `asset_path` 作为定位别名）
- workspace: 单文件 `index.hjson`
- contract: `uai.apply_workspace.niagara.asset`
- backend: `shared workspace loader -> preflight -> atomic transaction -> snapshot verification`

## Parameters

- `folder_path`：workspace 目录；目录内必须由 workspace contract 路由到唯一 `index.hjson`。
- `emitter_asset_path`（也接受 `asset_path` 作为定位别名）：可选的外部目标约束；提供时必须与 `index.hjson#/target` 一致。省略 `folder_path` 时必须提供该路径，以定位默认 workspace。

## Behavior

- Directory、single-file 和 inline 输入共用 `uai.apply_workspace.niagara.asset`、`uai.apply_input.niagara.asset` 和 `niagara.apply`。
- 全 workspace 先加载、路由、依赖排序和 preflight，再进入一个原子事务；失败时回滚，不允许边读边改。
- `operation` 支持 `create`、`update`、`upsert`、`remove`、`clone`。Export 默认只生成 `update`。
- stage/module/dynamic input 递归解析；普通 Module 的脚本引用统一经过 `ResolveScript`，未知或冲突引用在 preflight 失败。
- 合法 dynamic input 树的 Apply、快照验证与 Export 统一支持最多 32 层递归；超过上限返回 `niagara_dynamic_input_depth_exceeded`，图内循环仍单独返回 `niagara_dynamic_input_cycle_detected`。
- 引用 standalone `Module` Script 时，模块内部 dynamic input 的字面量、`linked_input`、递归输入与 Data Interface 由统一的 `Module.<DynamicInput>.<Input>` 句柄规则绑定；编译后的 Emitter 必须消费这些绑定，而不是退回零默认值。
- 递归输入名解析失败时，`error_detail` 保留稳定前缀 `input_name_not_found:`，并报告 `requested`、`owner_script`、有界 `available` 和 `workspace_pointer`；调用方应按该上下文修正输入，不得盲目重试。
- `provider_extension.stages.<stage>.modules.<module>` 可用 `module_kind: assignment` 和 `assignment_targets` 创建或更新 UE 原生 Assignment Module。`assignment_targets` 是完整目标集合；Niagara 已知属性可用 `null` 让 UE 类型表补全，未知属性必须显式给类型。Assignment 不接受 `script_asset_path`。
- `modules.<module>` 优先使用 Export 返回的合法 GUID；稳定语义键会按规范化最终目标资产路径与 stage 上下文补全成确定性 GUID，临时 proposed 对象路径不参与身份计算。重复 Apply 同一语义键必须更新原模块并保持数量不变。
- standalone Emitter 的 Export stage key 使用 `standalone|<Usage>|<UsageId>`，不会投影成 `system|...`；Apply 的真实 stage 选择仍来自同一对象内的结构化 `target`。
- Apply 在 mutation 前递归比较现有 literal、`linked_input`、Data Interface 和 dynamic-input 子树；语义相同的输入是 no-op，不重写 pin、不标脏图。只有模块脚本、Assignment 目标集合或输入语义确实变化时才进入图 mutation。
- Apply 可接受 Export 未展示但契约允许的字段；Apply 输入不会反向改变 Export profile。
- Apply 可递归处理 stage/module/dynamic input，并处理 Renderer 与 Event Handler 结构化属性；Apply 可接受的字段由 Apply contract 决定，不由 Export profile 的展示集合推导。Assignment 是受控的 UE 原生参数写入模块，不代表任意 Script graph topology 已开放。System User Parameter 不适用于 standalone Emitter；Data Interface 的任意对象拓扑和任意 Script graph topology 不在本纵切范围内。
- Emitter Owner 与 Renderer 的属性组在 mutation 前统一完成 schema、字段路径、类型和值转换 preflight；Renderer attribute binding 同时校验 `RootVariable.Name`。无效嵌套字段返回 `phase=preflight`，不会先替换 Renderer 或修改 Emitter。
- 事务失败会在取消编辑器事务后恢复进入命令前的 package dirty 状态；失败前为 clean 的资产不得仅因回滚过程变为 dirty，调用前已经 dirty 的资产也不得被错误清理。
- standalone Emitter 的提交前编译验证使用 UE 原生临时 System 上下文：挂入 Emitter、重建上下文节点、同步等待 System 编译完成后检查 Emitter Script；不会脱离 Emitter 上下文逐个编译 Script。上下文编译失败会阻止发布 proposed asset。
- `provider_extension.stages.<stage>.operation=replace` 是完整 stage 声明，并在全量 preflight 后原子执行；省略模块会被移除，失败恢复原图，重复 Apply 不得复制模块或残留 dynamic-input override helper。
- 本命令只接受目标 `asset_kind=emitter`；类型冲突在 preflight 返回 `niagara_asset_kind_conflict`，不会进入事务。
- 未知文件和未知输出字段拒绝；旧多文件 Niagara folder 不再作为兼容输入。

## Returns

成功返回 `status`、`phase`、`asset_path`、`asset_kind`、`object_path`、`resolved_operation`、`folder_path`、`units_checked`、`mutations_applied`、`repaired_emitter_version_count`、`rollback_attempted`、`rollback_succeeded`。失败时 compact 响应保留 `status`、`phase`、`error_code`、`error_detail` 和 rollback 状态，`failure.wire_error` 有界保留原始诊断。

## Validation

Apply 后必须调用对应 Export 命令读回并比较语义或 HJSON golden；引用 standalone Module 且其输入影响粒子属性时，还必须在 System 上编译并做 runtime probe。不能只检查 HTTP `ok=true` 或图结构。
