---
command: level_content_apply_json
category: level_content
title: Apply Level Content JSON
summary: 应用 create/upsert/patch/delete/clone、组织关系、任务和验证。
aliases: [level_actor_apply_json, TextRenderActor, text_render_create, 3d_text_create]
tags: [level_content, write, scene, whitebox, text_render, 3d_text, actor_create]
status: active
---

# `level_content_apply_json`

## LLM Compact

- status: active.
- purpose: 应用 create/upsert/patch/delete/clone、组织关系、任务和验证。
- key_inputs: `content`, `json_file`, `mode`, `dry_run`, `preflight`, `transaction`, `validate_after_apply`, `delete_policy`, `allow_destructive` ...
- key_returns: `success`, `dry_run`, `destructive`, `allow_destructive`, `resource_results[]`, `operation_results[]`, `task_results[]`, `validation_results[]`, `rollback_attempted`, `rollback_succeeded`, `saved`, `save_level_data` ...
- behavior: 写入命令；必须明确目标范围、默认值和写后读回验收。
- note: JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- note: 删除资源时在对应 resource 写 `operation: "delete"`；不要只依赖顶层 `mode=delete`。
- note: Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- note: 单文件 `level_content_*_json` 链路仍 active，适合小规模场景资源 create/upsert/patch/delete；多 Actor、多 Component、World Settings、streaming、references 或需要可审阅产物时，优先使用 `level_export_folder` -> 编辑 folder package -> `level_validate_folder` -> `level_diff_folder` -> `level_apply_folder`。
- note: 创建 TextRenderActor / 3D 文字也走本命令的最小 `resources[]`，先写 `class_path`、`label`、`folder_path`、`transform` 和必要 `properties.TextRenderComponent.*`，再 query/readback 补全。
- note: 默认 `dry_run=true`；真实写入必须显式 `dry_run=false`。包含 delete 或 replace-scope 语义时还必须显式 `allow_destructive=true`。
- note: 默认 `validate_after_apply=true`。任一写后 validation 返回 `passed=false` 时整个 apply 失败并回滚 transaction；必须检查 `rollback_succeeded`。
- validation: 写操作后用 query/snapshot 读回 label、folder、transform、tags、components/collision；删除先 dry-run 再执行。

## Authoring Notes

- JSON/folder 写入新增内容时先最小 authoring -> apply -> query/export readback -> patch 必要字段 -> 再 apply 验证；不要先找完整模板或源码推字段。
- Level Content JSON 描述场景实例最终态；复杂资产本体仍走 Blueprint/Material/Niagara 等专用 authoring。
- `level_content_apply_json` 不消费 Level folder package。若输入已经是 `level_export_folder` 产物目录，使用 `level_apply_folder`。
- 默认调用只生成计划。确认 preflight/plan 后，显式传 `dry_run=false` 才会写入。
- `resources[].operation="delete"`、顶层 `operations[].type="delete"`、`mode=delete_only|replace_scope`，以及 `delete_policy=only_managed_missing|replace_scope_managed` 都属于破坏性意图。

## Folder Workflow Boundary

- 继续使用本命令：少量 Actor、一次性资源写入、TextRenderActor、简单 transform/tag/folder patch。
- 改用 folder workflow：需要导出可审阅目录、批量修改 Actor/Component 属性、比较两个关卡包、校验引用或维护 Level/World/streaming 摘要。
- 迁移路径：`level_export_folder` -> 修改 `actors/items/<actor_id>/...` 或其它 package 文件 -> `level_validate_folder` -> `level_diff_folder` -> `level_apply_folder`。
- 两套链路都保持 active；folder workflow 覆盖的是多文件结构化 authoring 场景，不废弃本命令。

## Level Content Minimal Payload

`content` / `json_file` 的最小场景写入结构是 `resources[]`；旧 `actors[]` 仅用于显式迁移或历史读回识别，不作为当前 authoring 示例。每个空间 Actor 资源常用字段如下：

- `id` / `name` / `managed_id`：稳定身份；写入后会补 `UAI.Id=<id>` 标签。
- `operation` / `op`：资源级操作；删除资源时必须在对应 resource 写 `operation: "delete"`，不要只依赖顶层 `mode=delete`。
- `kind` / `type`：Actor 类型快捷名；支持 `static_mesh`、`point_light`、`camera`、`ambient_sound`、`trigger_box`、`nav_mesh_bounds_volume`、`target_point`、`niagara`、`actor`、`custom`。
- `class_path` / `class` / `actor_class`：显式 Actor 类；`custom` 或快捷名不足时使用。
- `label`、`folder_path`、`tags[]`、`transform.location`、`transform.rotation`、`transform.scale`：Actor 可读信息和世界 transform。
- StaticMeshActor 可写 `static_mesh` / `mesh`，也可写 `asset.static_mesh` / `asset.mesh` 或 `properties.StaticMesh.asset`。

`scope.folder_root` 用于默认 folder 和删除范围；`scope.managed_tag` 未写时默认为 `UAI.Managed`。`defaults.folder_path` 和 `defaults.tags[]` 会补到每个资源。

`properties` 是 Actor 反射路径；设置组件属性必须写 `组件名或组件类名.属性名`，例如 TextRenderActor 使用 `TextRenderComponent.Text`、`TextRenderComponent.WorldSize`、`TextRenderComponent.TextRenderColor`，不要写顶层 `Text` / `WorldSize`。

`properties` 的字段类型由目标 Actor/Component 的 UE 反射决定。基本 bool/number/string/text、enum 名称和 UObject 对象路径可以直接写裸值，公共 PropertyValueCodec 会按真实字段类型补全；canonical `{literal: ...}`、`{selected: ...}`、`{path: ...}` 同样可用。该 Apply 简写不改变 UObject/HJSON Export 的 canonical 输出。

```json
{
  "schema": "uai.level_content.v1",
  "scope": { "folder_root": "UAI/CommandFlowValidation/Case", "managed_tag": "UAI.CommandFlowValidation" },
  "defaults": { "folder_path": "UAI/CommandFlowValidation/Case", "tags": ["UAI.CommandFlowValidation"] },
  "resources": [
    {
      "id": "CFV_Box01",
      "kind": "static_mesh",
      "label": "CFV_Box01",
      "static_mesh": "/Engine/BasicShapes/Cube.Cube",
      "transform": { "location": [0, 0, 120], "rotation": [0, 0, 0], "scale": [1, 1, 1] }
    }
  ]
}
```

创建 3D 调试文字时仍只写最小资源；不要先找完整 Actor 模板：

```json
{
  "schema": "uai.level_content.v1",
  "resources": [
    {
      "id": "DBG_Text01",
      "kind": "custom",
      "class_path": "/Script/Engine.TextRenderActor",
      "label": "DBG_Text01",
      "folder_path": "UAI/Debug",
      "transform": { "location": [0, 0, 180], "rotation": [0, 180, 0], "scale": [1, 1, 1] },
      "properties": {
        "TextRenderComponent.Text": "A01 -> A02",
        "TextRenderComponent.WorldSize": 64
      }
    }
  ]
}
```

删除已管理资源的最小写法：

```json
{
  "schema": "uai.level_content.v1",
  "resources": [
    { "id": "CFV_Box01", "operation": "delete" }
  ]
}
```

## Parameters

- `content` / `json_file`：目标 Level Content JSON。
- `mode`：支持 `upsert`、`patch`、`create_only`、`delete_only`、`replace_scope`；其它值返回 `invalid_mode`。资源删除仍应使用 `resources[].operation="delete"` 明确目标。
- `dry_run`：默认 `true`，只生成计划，不写入；真实写入必须显式为 `false`。
- `preflight`：默认 `true`；真实写入即使显式关闭 preflight，也不会绕过无效 content 的基础 validation。
- `transaction`：默认 `true`；apply 或写后 validation 失败时执行 Undo。
- `validate_after_apply`：默认 `true`；任一 `validation_results[].passed=false` 会使命令返回 `level_content_validation_failed` 并回滚。
- `allow_destructive`：默认 `false`；破坏性意图与 `dry_run=false` 同时出现时必须显式为 `true`，否则返回 `allow_destructive_required`，不开始写入。
- `delete_policy`：支持空值/`none`、`only_managed_missing`、`replace_scope_managed`；后两者属于破坏性意图。
- `protected_tags`：删除保护。
- `save_level`：默认 `false`；保存复用 `save_current_level` 风险保护。
- `allow_python_gc_risk`：默认 `false`。

## Returns

- `success` / `dry_run`。
- `resource_results[]` / `operation_results[]` / `task_results[]`。
- `validation_results[]`。
- `saved` / `save_level_data`。
- `destructive` / `allow_destructive`。
- `rollback_attempted` / `rollback_succeeded`；validation 失败时两者用于确认实际 Undo 结果。
- `schema`：返回 payload schema。

## Minimal Example

```json
{
  "command": "level_content_apply_json",
  "params": {
    "json_file": "tmp/uai_params/area_a01_apply.hjson",
    "mode": "upsert",
	"dry_run": false,
    "preflight": true,
    "validate_after_apply": true,
    "save_level": false
  }
}
```

## Validation

写入后必须读回关键 Actor 的 label、folder、transform、碰撞和标签；空间任务还要截图或 shape/sweep 验收，不能只看 command success。
