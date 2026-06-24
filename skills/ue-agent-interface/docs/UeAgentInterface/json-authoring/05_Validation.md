# Validation

本页定义 JSON authoring 的验证要求。验证目标不是“命令返回 success”，而是确认 UE 状态已经按语义变化。

## 基础检查

每次结构化 JSON 编辑至少执行：

1. JSON parse。
2. authoring hygiene lint。
3. adapter 转换。
4. validate 或 dry-run。
5. apply。
6. export/readback。
7. 语义比较。

## Lint 必须拦截

- readback/diagnostics 字段泄漏到 authoring。
- 缺少 enum 候选项。
- `value` 形态与 `type_info` 不匹配。
- `operation` 未实现。
- `space_contract` 缺字段。
- legacy alias 泄漏到 authoring 主面。
- 派生 count、file path、coverage report、compile report 被当成可写字段。
- catalog seed 缺 `kind/name/full_name`，或只有显示 `name` 没有 `full_name`。
- `json_authoring` 被放到与 `profile_path` 不一致的位置。
- 忽略 `write_support/support_reason`，把候选用于不支持的写入场景。

## Adapter 必须拦截

- selector 找不到或匹配多个。
- source/operation 不支持。
- dynamic input 缺 `kind/name/full_name` 或无法由 `full_name` 解析到真实 script asset path。
- linked input 缺目标参数。
- enum selected 不在候选项中。
- 空间合同不完整。
- 会丢用户意图的降级转换。
- Niagara module seed 指向的 module 不在当前导出 stage 中，却被当作新增 stack module 成功。

## Apply 后读回

| 编辑类型 | 验证 |
| --- | --- |
| 普通值 | 读回值 exact match 或可解释的 UE normalized match。 |
| Enum | 读回 selected/write value，并用 display label 辅助确认语义。 |
| Graph | 节点、连线、pin default、layout 读回；必要时 compile。 |
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
