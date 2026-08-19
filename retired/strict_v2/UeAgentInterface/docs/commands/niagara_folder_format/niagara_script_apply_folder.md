---
command: niagara_script_apply_folder
category: niagara_folder_format
title: 从统一 index.hjson workspace 创建或修改 standalone Niagara Script
summary: 从统一 index.hjson workspace 创建或修改 standalone Niagara Script
aliases: []
tags: [niagara_folder_format, hjson_authoring, unified_apply_export]
status: active
---

# `niagara_script_apply_folder`

## LLM Compact

- purpose: 从统一 index.hjson workspace 创建或修改 standalone Niagara Script
- key_inputs: `folder_path`, `script_asset_path`（也接受 `asset_path` 作为定位别名）
- workspace: 单文件 `index.hjson`
- contract: `uai.apply_workspace.niagara.asset`
- backend: `shared workspace loader -> preflight -> atomic transaction -> snapshot verification`

## Parameters

- `folder_path`：workspace 目录；目录内必须由 workspace contract 路由到唯一 `index.hjson`。
- `script_asset_path`（也接受 `asset_path` 作为定位别名）：可选的外部目标约束；提供时必须与 `index.hjson#/target` 一致。省略 `folder_path` 时必须提供该路径，以定位默认 workspace。

## Behavior

- Directory、single-file 和 inline 输入共用 `uai.apply_workspace.niagara.asset`、`uai.apply_input.niagara.asset` 和 `niagara.apply`。
- 全 workspace 先加载、路由、依赖排序和 preflight，再进入一个原子事务；失败时回滚，不允许边读边改。
- `operation` 支持 `create`、`update`、`upsert`、`remove`、`clone`。Export 默认只生成 `update`。
- `create` 复制 `UNiagaraEditorSettings` 配置的 UE 原生 `DefaultModuleScript`、`DefaultFunctionScript` 或 `DefaultDynamicInputScript`，保留真实 Script Source 和 Graph；`provider_extension.script_usage` 支持 `Module`、`Function`、`DynamicInput`，省略时为 `Module`。
- standalone `Module` Script 支持与 System/Emitter 相同的 `provider_extension.stages`、Assignment、script module 和递归 dynamic input 结构；非 Module usage 提供 `stages` 会在 preflight 明确失败。
- stage/module/dynamic input 递归解析；脚本引用统一经过 `ResolveScript`，未知或冲突引用在 preflight 失败。
- 合法 dynamic input 树的 Apply、快照验证与 Export 统一支持最多 32 层递归；超过上限返回 `niagara_dynamic_input_depth_exceeded`，图内循环仍单独返回 `niagara_dynamic_input_cycle_detected`。
- standalone `Module` Script 内的 dynamic input override 统一保留外层 `Module` 命名空间；字面量、`linked_input`、递归 dynamic input 和 Data Interface 使用同一句柄生成规则。这样 Script 被 Emitter 调用时，UE 会把 `Module.<DynamicInput>.<Input>` 正确别名化到调用模块，避免结构与编译状态正常但运行时读取零默认值。
- 递归输入名解析失败时，`error_detail` 保留稳定前缀 `input_name_not_found:`，并报告 `requested`、`owner_script`、有界 `available` 和 `workspace_pointer`；调用方应按该上下文修正输入，不得盲目重试。
- `modules.<module>` 优先使用 Export 返回的合法 GUID；稳定语义键会按规范化最终目标资产路径与 stage 上下文补全成确定性 GUID，临时 proposed 对象路径不参与身份计算。重复 Apply 同一语义键必须更新原模块并保持数量不变。
- Apply 可接受 Export 未展示但契约允许的字段；Apply 输入不会反向改变 Export profile。
- Export/Apply 往返 standalone Module Script 的 stack-shaped Parameter Map 图；任意低层节点、自由连线和编辑器布局不属于该结构化纵切。
- `provider_extension.stages.<stage>.operation=replace` 表示该 stage 的完整声明：先完成全量解析、依赖与图循环验证，再原子替换；省略模块会被移除，失败恢复原图，重复 Apply 不得产生重复模块或残留 helper 节点。
- 未知文件和未知输出字段拒绝；旧多文件 Niagara folder 不再作为兼容输入。

## Returns

成功返回 `status`、`phase`、`asset_path`、`asset_kind`、`object_path`、`resolved_operation`、`folder_path`、`units_checked`、`mutations_applied`、`repaired_emitter_version_count`、`rollback_attempted`、`rollback_succeeded`。失败时 compact 响应保留 `status`、`phase`、`error_code`、`error_detail` 和 rollback 状态，`failure.wire_error` 有界保留原始诊断。

## Validation

Apply 后必须调用对应 Export 命令读回并比较语义或 HJSON golden；不能只检查 HTTP `ok=true`。

创建 Module Script 时，至少读回 `target.asset_kind=script`、`provider_extension.stages.*.target.usage=Module`、模块顺序、Assignment targets 和递归 dynamic inputs，并对使用该 Script 的 System 执行编译验证。若模块输入影响粒子数据，还必须用 `niagara_system_runtime_probe` 读取对应属性；仅验证 Export 图结构或 compile status 不足以证明 dynamic input 已在调用命名空间内取值。
