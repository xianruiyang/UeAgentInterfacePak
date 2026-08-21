# Validation

本页定义 HJSON authoring 的验证要求。验证目标不是“命令返回 success”，而是确认 UE 状态已经按语义变化。

## 基础检查

每次结构化 HJSON 编辑至少执行：

1. JSON parse。
2. authoring hygiene lint。
3. validate 或 dry-run；缺 dedicated validate 时记录 coverage gap。
4. apply。
5. export/readback。
6. 语义比较。

## Lint 必须拦截

- readback/debug/diagnostics/legacy 字段泄漏到 `llm_authoring`。
- 缺少 enum 候选项。
- `value` 形态与 `value_kind` 不匹配。
- `operation` 未实现。
- `space_contract` 缺字段。
- legacy alias 泄漏到 authoring 主面。
- 默认字段项继续输出 `name/authored_name/cpp_type/enum_options` 等重复或 legacy 字段。
- 派生 count、file path、coverage report、compile report 被当成可写字段。
- raw config、export timestamp、coverage report 等 report/debug 字段进入默认 authoring。
- path-backed seed 使用旧 `full_name`、`asset_path`、`class_path`、`object_path`、`component_class_path`、`script_asset_path` 或 `module_script_path` 作为主输入。
- 仅凭显示 `name` 写入本应有路径的自定义资产、类或对象。
- 领域 candidate 返回的 executable identity、`binding_revision` 或 context 被放到与 owning domain/profile 不一致的位置。
- 忽略 `write_support/support_reason`，把候选用于不支持的写入场景。

## Adapter 必须拦截

- selector 找不到或匹配多个。
- source/operation 不支持。
- dynamic input 缺 `path`/`name` seed，或 path 无法解析到真实 script asset。
- linked input 缺目标参数。
- enum selected 不在候选项中。
- 空间合同不完整。
- 会丢用户意图的降级转换。
- Niagara module seed 指向的 module 不在当前导出 stage 中，却被当作新增 stack module 成功。

## Dedicated Validate / Diff Coverage

当前 folder validate/diff 覆盖不是完整矩阵。

| 类型 | dedicated validate | dedicated diff |
| --- | --- | --- |
| `blueprint` | missing | missing |
| `umg` | missing | missing |
| `anim_blueprint` | missing | missing |
| `material` | missing | missing |
| `material_instance` | missing | missing |
| `material_function` | missing | missing |
| `niagara_system` | missing | missing |
| `niagara_emitter` | missing | missing |
| `niagara_script` | missing | missing |
| `sequence` | missing | missing |

AI 行为树相关既有 folder 文档存在，但 contract operation registration 仍为 `missing`；不得把这些文档写成完整闭环能力。

缺 dedicated validate/diff 时，使用以下证据组合补足验证：

- command response 和 report。
- export/readback 后目标 JSON 的语义比较。
- authoring consistency gate。
- domain compile/stack issue/probe。
- 必要时对两份 folder package 做结构化文件比较，但必须写明不是 dedicated diff coverage。

Authoring consistency gate 的正式入口、失败字段、deferred check 边界和不得宽泛搜索源码/旧文档的规则见 `07_ImplementationConsistency.md`。

## Apply 后读回

| 编辑类型 | 验证 |
| --- | --- |
| 普通值 | 读回值 exact match 或可解释的 UE normalized match。 |
| Enum | 读回 selected/write value，并用 display label 辅助确认语义。 |
| Graph | `graph.hjson` 中节点/连线/pin default 读回；若改 layout，再读 `layout.hjson`；必要时 compile。 |
| Niagara | module input 读回、active branch/mode、Stack issue、compile log；视觉相关再 runtime probe/screenshot。 |
| 曲线 | key 数量、时间、值、插值、tangent、外推模式读回。 |
| 空间字段 | 同一 subject、同一 frame、同一 state 读回。 |
| ProjectSettings | validate/diff/dry-run，必要时重启风险记录。 |
| destructive edit | dry-run/plan、显式 gate、删除后 readback。 |
| catalog seed 新增 | readback 中出现目标 component/widget/node/value，并补齐 class/template/slot/pin/properties 或 domain readback 字段。 |

## Warning 处理

Warning 不等于可以忽略。以下 warning 必须回到 authoring 修正：

- `hidden_or_inactive_branch`
- `unsupported_write_policy`
- `dynamic_input_source_missing_script_asset_path`
- `linked_input_source_missing_parameter`
- `module_input_link_apply_verification_failed`
- `property_import_status=import_failed`
- `value_text_changed_after_import` 且无法解释为 UE 正常规范化

## Editor 和进程

- 普通验证复用当前 UE Editor。
- 不因普通验证完成而关闭用户已有 UE。
- 需要编译插件/UE C++ 时，先处理 dirty resource，再关闭 UE 构建。
- 如果验证脚本自己启动了临时 Editor 或 `UnrealEditor-Cmd`，脚本结束必须清理。
- 每次结束确认无 `CrashReportClient` 残留。
