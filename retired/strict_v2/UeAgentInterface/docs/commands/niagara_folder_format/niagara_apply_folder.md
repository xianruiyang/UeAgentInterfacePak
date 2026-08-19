---
command: niagara_apply_folder
category: niagara_folder_format
title: 从统一 index.hjson workspace 创建或修改 Niagara System
summary: 从统一 index.hjson workspace 创建或修改 Niagara System
aliases: []
tags: [niagara_folder_format, hjson_authoring, unified_apply_export]
status: active
---

# `niagara_apply_folder`

## LLM Compact

- purpose: 从统一 index.hjson workspace 创建或修改 Niagara System
- key_inputs: `folder_path`, `asset_path`
- workspace: 单文件 `index.hjson`
- contract: `uai.apply_workspace.niagara.asset`
- backend: `shared workspace loader -> preflight -> atomic transaction -> snapshot verification`

## Parameters

- `folder_path`：workspace 目录；目录内必须由 workspace contract 路由到唯一 `index.hjson`。
- `asset_path`：可选的外部目标约束；提供时必须与 `index.hjson#/target` 一致。省略 `folder_path` 时必须提供该路径，以定位默认 workspace。

## Behavior

- Directory、single-file 和 inline 输入共用 `uai.apply_workspace.niagara.asset`、`uai.apply_input.niagara.asset` 和 `niagara.apply`。
- 全 workspace 先加载、路由、依赖排序和 preflight，再进入一个原子事务；失败时回滚，不允许边读边改。
- 对已存在 Niagara 资产的结构性 `update` 在事务进入 rollback capture 后执行编辑器隔离：只有 stage/module、Emitter、Renderer 或 Event Handler 结构发生变化时，才关闭目标资产编辑器并确认旧 ViewModel 已释放。仅修改 System User Parameter 或普通根属性不会关闭资产编辑器。
- `operation` 支持 `create`、`update`、`upsert`、`remove`、`clone`。Export 默认只生成 `update`。
- stage/module/dynamic input 递归解析；普通 Module 的脚本引用统一经过 `ResolveScript`，未知或冲突引用在 preflight 失败。
- 合法 dynamic input 树的 Apply、快照验证与 Export 统一支持最多 32 层递归；超过上限返回 `niagara_dynamic_input_depth_exceeded`，图内循环仍单独返回 `niagara_dynamic_input_cycle_detected`。
- standalone `Module` Script 内的 dynamic input 统一以 `Module.<DynamicInput>.<Input>` 参与调用别名化；字面量、`linked_input`、递归 dynamic input 和 Data Interface 不再各自生成不同命名空间。
- 递归输入名解析失败时，`error_detail` 保留稳定前缀 `input_name_not_found:`，并报告 `requested`、`owner_script`、有界 `available` 和 `workspace_pointer`；调用方应按该上下文修正输入，不得盲目重试。
- `provider_extension.stages.<stage>.modules.<module>` 可用 `module_kind: assignment` 和 `assignment_targets` 创建或更新 UE 原生 Assignment Module。`assignment_targets` 是完整目标集合；Niagara 已知属性可用 `null` 让 UE 类型表补全，未知属性必须显式给类型。Assignment 不接受 `script_asset_path`。
- `modules.<module>` 优先使用 Export 返回的合法 GUID；稳定语义键会按规范化最终目标资产路径、stage 上下文和所属 Emitter Handle 补全成确定性 GUID，临时 proposed 对象路径不参与身份计算。重复 Apply 同一语义键必须更新原模块并保持数量不变。
- Apply 在 mutation 前递归比较现有 literal、`linked_input`、Data Interface 和 dynamic-input 子树；语义相同的输入是 no-op，不重写 pin、不标脏图。只有模块脚本、Assignment 目标集合或输入语义确实变化时才进入图 mutation。
- Apply 可接受 Export 未展示但契约允许的字段；Apply 输入不会反向改变 Export profile。
- 当前 Apply 覆盖 emitter handle 自动补全、stage/external module/Assignment Module/dynamic input 递归编辑、renderer 属性、Event Handler 结构与 System User Parameter；Export 只按 profile 暴露必要编辑字段，两者字段集合互不推导。Assignment 是受控的 UE 原生参数写入模块，不代表任意 Script graph topology 已开放。
- `provider_extension.user_parameters` 以 `User.*` 参数名为 key；新参数必须提供 `type`，结构化 `value` 可省略并交给 UE 原生默认。已有参数可省略 `type`，缺失 `value` 保留现值；`null` 或 `remove: true` 才删除。
- User Parameter 的 `llm_authoring` Export 不写冗余 `has_value`；`readback` / `debug` 可带 `value_text`。Apply 可直接消费当前各 Export profile 和历史带 `has_value` 的 workspace：这两个字段只作为已校验的只读元数据，写入仍只认结构化 `value`，矛盾的 `has_value=false` 加 `value` 会在 preflight 失败。
- System 的 `provider_extension.emitters.<key>.source_asset_path` 是 Apply-only 自动补全提示。目标 emitter handle 不存在时，Apply 从指定 standalone Emitter 创建 handle；目标已存在时幂等复用并校验 parent。可选 `source_sync_mode` 为 `merge`（默认，UE 原生合并并保留本地覆盖）或 `replace`（以当前 source 重建 handle instance 基线，再应用本次显式嵌套字段）；两种模式都保持 handle ID、名称、启用状态和 System 图接入。
- System Emitter Owner 可用 `provider_extension.emitters.<key>.enabled: true|false` 原子修改 Handle 启用状态。该字段只适用于 System 内的 Emitter Handle，standalone Emitter 输入会拒绝；Export 对 System 始终读回当前 `enabled`，因此开关、编译、保存和失败回滚走同一个 HJSON authoring 事务，不再依赖 deprecated 直连命令。
- 新建 handle 必须提供 `target.emitter_name`，不得预写 `target.emitter_handle_id`；可选 `emitter_version` 指定源 Emitter 版本。新增 handle 后，同一事务可立即递归 Apply 其 renderer、Event Handler 和 stage/module。
- Emitter Owner 与 Renderer 属性组在 mutation 前通过共享 ObjectApply 完成 schema、字段路径、类型和值转换 preflight；`add`/`replace` 使用 source baseline 校验，Renderer attribute binding 额外校验 `RootVariable.Name`。无效嵌套字段不会先创建或替换 handle instance。
- 自动补全触发 System overview graph、System spawn/update emitter node、执行顺序和缓存刷新。后续 mutation、compile、verification 或 save 失败时，新增 handle 与递归修改一起回滚。
- 所有事务失败都会在编辑器事务取消后恢复调用前的 package dirty 状态，语义回滚成功但遗留 clean-to-dirty 变化同样视为失败。
- `provider_extension.stages.<stage>.operation=replace` 是完整 stage 声明：全量解析和循环验证先于 mutation，替换过程原子执行，失败恢复原图，重复 Apply 不得产生重复模块或 helper 节点。
- `compile: true` 在 System 编译完成后同步刷新 compiled data cache，使后续 runtime component 与 `niagara_system_runtime_probe` 使用最新粒子数据布局；不能以旧 cache 的属性数量判断本次 Apply 结果。
- target 与 `source_asset_path` 仍须是 UE 已注册挂载点下的合法长包名。Apply 先解析已加载包内对象，再解析完整对象路径，最后回退磁盘加载，因此可编辑合法路径下尚未保存的内存 UObject；未注册的 `/Temp` 等路径仍在 preflight 拒绝。
- 未知文件和未知输出字段拒绝；旧多文件 Niagara folder 不再作为兼容输入。
- 本命令只接受 `asset_kind=system`。standalone Emitter 必须使用 `niagara_emitter_apply_folder`，standalone Script 必须使用 `niagara_script_apply_folder`；类型冲突不是可重试的 stage-key 问题。

## Emitter handle 自动补全

<!-- uai-hjson-file: index.hjson -->
```hjson
operation: update
target: { asset_path: "/Game/VFX/NS_Example", asset_kind: system }
provider_extension: {
  compile: true
  save: true
  emitters: {
    MainArc: {
      source_asset_path: "/Game/VFX/Emitters/NE_Arc"
      source_sync_mode: replace
      target: { emitter_name: MainArc }
    }
  }
  stages: {
    MainArcUpdate: {
      target: { emitter_name: MainArc, usage: EmitterUpdateScript, usage_id: "00000000-0000-0000-0000-000000000000" }
    }
  }
}
```

`source_asset_path` 和 `source_sync_mode` 不由 Export 为了回放而强制输出。它们只表达 Apply 的创建/同步证据；重复执行同一输入不得复制第二个 handle。`replace` 用于确定性 source-authoritative 重建，显式 owner/renderer/Event Handler/stage 字段在替换后应用并具有更高优先级；未知 mode、缺少 source、parent 路径或版本冲突会在 preflight 失败。

## Returns

成功返回 `status`、`phase`、`asset_path`、`asset_kind`、`object_path`、`resolved_operation`、`folder_path`、`units_checked`、`mutations_applied`、`repaired_emitter_version_count`、`editor_isolation_performed`、`closed_editor_count`、`rollback_attempted`、`rollback_succeeded`。失败时 compact 响应保留 `status`、`phase`、`error_code`、`error_detail` 和 rollback 状态，`failure.wire_error` 有界保留原始诊断。

## Validation

Apply 后必须调用对应 Export 命令读回并比较语义或 HJSON golden；涉及新增 emitter handle 时还必须检查 `niagara_system_list_emitters` 的 `enabled` / `emitter_ready_to_run`，并用 runtime probe 确认其执行状态不是 `Disabled`。不能只检查 HTTP `ok=true` 或 handle 数量。
