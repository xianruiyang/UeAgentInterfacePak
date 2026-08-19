---
command: level_validate_folder
category: level_content
title: Validate Level Workspace
summary: 对统一 Level HJSON workspace 执行无 mutation 的完整 preflight。
tags: [level_content, hjson, workspace, validate]
status: active
---

# `level_validate_folder`

读取与 `level_apply_folder` 相同的目录契约，并复用同一 loader、router、dependency graph、Apply input contract、provider preflight 和 semantic verification 准备过程。它不是另一套宽松 schema 校验器。

```json
{"input_folder":"Saved/UeAgentInterface/Authoring/LevelEdit"}
```

`input_folder` 可使用别名 `folder_path`。成功返回 `status=ready`、`phase=preflight`、`ok=true`、`units_checked` 且 `mutations_applied=0`。

验证覆盖：

- 必需 `index.hjson`、允许的 Actor/Component path pattern 与未知文件拒绝。
- HJSON 解析、大小写碰撞、workspace containment、重复 target、引用与稳定依赖顺序。
- operation、identity one-of、Actor/Component class/source 断言和目标存在性。
- 与 Export/Apply 共用的 Level authorability；受保护 Actor/Component 分别稳定返回 `level_actor_not_authorable` 或 `level_component_not_authorable`，不会降级成 identity/not-found/reference 错误。
- 递归 UObject/UStruct 属性类型、容器 element/key/mapped 类型及可选断言。
- Actor world transform 与 Component parent-local transform 的完整 `space_contract`。

Validate 不创建或修改真实 Editor Level 对象、不写属性、不保存关卡。它与 Apply preflight 共用每次 workspace 专属的最小化 Inactive scratch World 来承载 proposed 状态；不创建 `FWorldContext`，并在返回前 cleanup。通过后仍建议先用 `level_apply_folder` 默认 dry-run；两者共享语义，但后者还返回命令级 `dry_run` 字段。
