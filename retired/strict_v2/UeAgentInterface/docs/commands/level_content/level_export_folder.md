---
command: level_export_folder
category: level_content
title: Export Level Workspace
summary: 将当前 Editor World 只读投影为统一 Level HJSON workspace。
tags: [level_content, hjson, workspace, export]
status: active
---

# `level_export_folder`

通过共享 state snapshot、export contract、projector 和 workspace writer 导出当前 Editor World。命令只写 UAI 拥有的输出目录，不修改 Actor、Component、关卡 package dirty 状态或资产。

## 输出结构

```text
<workspace>/
  index.hjson
  actors/items/<actor-guid-or-managed-hash>/actor.hjson
  actors/items/<actor-guid-or-managed-hash>/components/<component-name>/component.hjson
```

- `index.hjson`：`operation=update` 和精确 `target.world_path`。
- `actor.hjson`：Actor identity、canonical editable properties、label、Outliner folder 和 world transform。
- `component.hjson`：owner/component identity、canonical editable properties、attachment 和 parent-local transform。
- Actor、Component 和属性按稳定 identity/path 排序；每个对象独立成文件，便于定向读取、diff 和 Apply。
- Export 与 Apply 共用 Level authorability：只导出绑定 World PersistentLevel 中可持久编辑的 Actor 及其可持久编辑 Component；Builder Brush、WorldSettings、template、销毁中/garbage、object/class transient、其它 Level Actor，以及 Owner 不可 author 的 Component 均不会进入 workspace。该规则基于对象 flags、类型和 World/Level ownership，不使用对象名或类名黑名单。
- 不生成 `manifest.hjson`、中间 index、grouped `details/`、独立 `properties.hjson`、validation/debug 旁路目录或 legacy adapter。
- world、actor、component 先分别形成不可发布的 fragment plan；全部 fragment 合并后统一检查路径 containment、大小写冲突、引用、role/cardinality、entry 和 workspace 总 token，最后只执行一次原子 publisher。任一 fragment 或全局门禁失败都不会改变旧 final workspace。

## Profile

- `llm_authoring`：默认。输出 identity 和可编辑 authoring 字段；fragment-local 保护预算 32768，完整 workspace 预算 131072。
- `readback`：增加 readback 字段，允许保留 `value_text`；fragment-local 保护预算 49152，完整 workspace 预算 196608。
- `debug`：增加诊断字段，允许保留 `value_text`；fragment-local 保护预算 98304，完整 workspace 预算 393216。
- `validation`：只输出验证所需 identity/authoring 字段；fragment-local 保护预算 8192，完整 workspace 预算 32768。

workspace 预算是 profile 的固定 contract，不按 Actor/Component 数量线性放大，也不从当前关卡输出反推。每个 fragment 先受本地资源保护，最终 plan 再按 workspace budget 计算一次总 `token_proxy`。

所有 profile 使用同一 HJSON writer：struct 递归字段数不超过 6 时可同行；列表计作 1 个字段；无 struct 的 scalar list 同行；Vector/Rotator/Color 等已知 struct 使用 `components: []`；Transform 保留 `translation`、`rotation`、`scale`，其内部使用 components list。

Export 与 Apply 独立：Export 只暴露编辑过程必要的可编辑状态，不因为 Apply 支持更多输入而扩大输出。默认移除 `operations`、`control_type`、`category_path`，`property_path` 仅在编辑定位需要时输出。

## 参数

```json
{"output_folder":"Saved/UeAgentInterface/Authoring/LevelReadback","profile":"llm_authoring"}
```

- `output_folder`：可选；别名 `output_dir`。必须位于共享 UAI authoring 所有权根目录 `Saved/UAI`、`Saved/UeAssetFolders` 或 `Saved/UeAgentInterface` 的后代目录；所有权根本身不能作为输出目录。
- `profile`：可选，默认 `llm_authoring`。
- 未传输出目录时写入 `Saved/UeAgentInterface/LevelExports/<WorldName>`。

## 返回与验收

成功返回 `status=written`、`workspace_root`、`profile`、`actor_count`、`component_count`、`file_count`、`token_budget`、`metrics`、`entry_file=index.hjson`、完整 `written_relative_files`、绝对 `written_files` 和 `publisher` transaction receipt。

`written_relative_files` 与最终 workspace 中的 HJSON 相对文件集合严格一致。完整 workspace 超预算时返回 `export_workspace_token_budget_exceeded`，并且在 publisher 前失败。

机器 verification 对 `entry_file` 做精确 `index.hjson` equality，并根据结构化 publisher 结果建立与当前 request/live session 绑定的完整 artifact receipt；验收覆盖 freshness、完整文件集、size/hash、逐文件 HJSON parse、profile/contract 和 workspace validation，不回退为绝对路径 basename 或路径存在判断。

调用前后 world package dirty 状态必须一致；任何变化都会以 `level_export_mutated_package_dirty_state` 失败。需要应用修改时使用 `level_apply_folder`，不要把导出成功视为状态已修改。
