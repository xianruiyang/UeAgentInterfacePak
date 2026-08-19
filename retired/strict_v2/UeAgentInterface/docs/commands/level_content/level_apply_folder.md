---
command: level_apply_folder
category: level_content
title: Apply Level Workspace
summary: 通过统一 HJSON workspace 原子创建、更新、克隆或删除 Actor 与 Component。
tags: [level_content, hjson, workspace, apply]
status: active
---

# `level_apply_folder`

读取一个统一 Level workspace，先完成全目录 load、路由、引用、依赖和 typed preflight，再通过共享 transaction/backend 执行 Actor、Component 与递归 UObject 属性 mutation。默认 `dry_run=true`，不会修改关卡。

## 目录契约

```text
<workspace>/
  index.hjson
  actors/items/<actor_id>/actor.hjson
  actors/items/<actor_id>/components/<component_id>/component.hjson
```

- `index.hjson` 必须且只能描述当前 world；Actor 和 Component 文件可为零个或多个。
- 未知文件、大小写冲突、workspace 外引用、重复 target 和旧 `manifest.hjson`、`details/`、`properties.hjson` 均被拒绝。
- 目录是命令入口；共享内部 API 还可把单 HJSON 或 inline object 解析为同一 virtual bundle，语义与目录输入一致。
- 每个文件是独立 operation unit；文件路径只负责路由，不替代文件内 target identity。

## World 入口

<!-- uai-hjson-file: index.hjson -->
```hjson
{
  operation: update
  target: { world_path: "/Game/Maps/TestMap" }
}
```

World unit 只建立 workspace owner 和依赖边界，不写 WorldSettings 属性。

## Actor 单元

<!-- uai-hjson-file: actors/items/<actor_id>/actor.hjson -->
```hjson
{
  operation: upsert
  target: {
    world_path: "/Game/Maps/TestMap"
    managed_id: lightning_target
    actor_class: "/Script/Engine.PointLight"
  }
  properties: [
    { property_path: LightComponent.Intensity, value: { literal: 3210 } }
  ]
  provider_extension: {
    label: LightningTarget
    folder_path: "VFX/Lightning"
    transform: {
      translation: { components: [0, 0, 300] }
      rotation: { components: [0, 0, 0] }
      scale: { components: [1, 1, 1] }
      space_contract: {
        subject: actor.transform
        dimension: "3d"
        Fsemantic: requires_command_or_asset_context
        Fwrite: ue_actor_world_transform
        Fread: ue_actor_world_transform
        Fverify: ue_actor_world_transform
        conversion_chain: semantic_context_to_ue_frame_required
      }
    }
  }
}
```

Actor identity 选择以下一组：

- `world_path + actor_guid`
- `world_path + managed_id`
- `world_path + object_path`

`actor_class` 是精确 `/Script/...` 或 Blueprint generated class path 的类型断言；create 时必需。clone 使用 `source_actor_guid` 或 `source_managed_id`。`provider_extension` 可 patch `label`、`folder_path` 和 world-space transform。

Create/clone 未显式提供 `label` 时，Actor 名称与标签交给 UE Spawn 机制生成；语义验证不把 transient CDO/source label 当作精确期望值。显式提供 `label` 时仍严格写入并读回比较。

## Component 单元

<!-- uai-hjson-file: actors/items/<actor_id>/components/<component_id>/component.hjson -->
```hjson
{
  operation: upsert
  target: {
    world_path: "/Game/Maps/TestMap"
    owner_managed_id: lightning_target
    component_name: ImpactLight
    component_class: "/Script/Engine.PointLightComponent"
  }
  properties: [
    { property_path: Intensity, value: { literal: 8000 } }
  ]
  provider_extension: {
    attachment: {
      parent_component: RootComponent
      socket_name: ""
      transform: {
        translation: { components: [0, 0, 0] }
        rotation: { components: [0, 0, 0] }
        scale: { components: [1, 1, 1] }
        space_contract: {
          subject: component.relative_transform
          dimension: "3d"
          Fsemantic: requires_command_or_asset_context
          Fwrite: ue_scene_component_parent_relative_transform
          Fread: ue_scene_component_parent_relative_transform
          Fverify: ue_scene_component_parent_relative_transform
          conversion_chain: semantic_context_to_ue_frame_required
        }
      }
    }
  }
}
```

Component identity 选择 `world_path + owner_actor_guid + component_name` 或 `world_path + owner_managed_id + component_name`。`component_class` 在 create 时必需；clone 还需 `source_component_name`。attachment transform 始终是父组件局部空间，不能按 world transform 写入。

## Authorability 与隔离 preflight

Export、Apply target、clone source、Component owner 和 attachment parent 共用同一套 Level authorability 规则。已有 Actor 必须是绑定 World 的 PersistentLevel 中可持久编辑的对象；Builder Brush、WorldSettings、template、销毁中或 garbage 对象、object/class transient 对象，以及在正式 `level_path` identity 引入前属于其它 Level 的 Actor 都不可 author。Component 自身必须可持久编辑，且 Owner Actor 也必须满足同一 Actor 规则。

命中受保护对象时，Actor 统一返回 `level_actor_not_authorable`，Component（包括 Owner 不可 author）统一返回 `level_component_not_authorable`；`error_detail` 只携带稳定 reason，不用对象名或瞬态路径伪装成 identity/not-found 错误。拒绝发生在 mutation 前，`mutations_applied=0`，不会进入 rollback。

每次 workspace preflight/apply 使用一个专属的最小化 `EWorldType::Inactive` scratch World/PersistentLevel。Actor 与 Component 的 proposed/rollback backup 都在该隔离所有权链中构造；scratch World 不创建 `FWorldContext`，不挂入真实 Editor Level，并在 dry-run、成功、失败及 rollback 后、命令返回前统一 cleanup。它只承载内部候选和备份，不是新的可保存关卡。

## Operation 与属性

- `create`：目标必须不存在；缺失值从 UE class default/factory 默认值取得。
- `update`：目标必须存在；省略字段保留当前值，不允许用 native default 覆盖。
- `upsert`：按真实存在性解析为 create 或 update。同一 workspace 新建 Owner Actor 时，Actor class 可能自动实例化原生 Component；组件 upsert 会在 mutation 阶段对该同名、同类型组件重新解析为 update，不重复创建。显式 `create` 遇到同名组件仍按冲突失败。
- `remove`：只接受 target 和 provider extension，不接受 properties。
- `clone`：从显式 source 复制 UE 对象状态，再应用给定 patch。
- `properties[]` 走共享反射解析，支持 scalar、struct、owned object、reference、array、set、map、fixed array 和 optional，并递归处理内部 UObject/UStruct。
- `value` 是 canonical 结构化值。`value_kind`、`struct_path`、`element_type`、`key_type`、`mapped_type`、`inner_type`、`fixed_length`、`allowed_class` 只作为可选断言；未知字段直接拒绝。
- Apply 输入可比 Export 输出多或少；Apply 按输入意图解析，Export 不由 Apply 字段集合决定。

## 参数与返回

```json
{"input_folder":"Saved/UeAgentInterface/Authoring/LevelEdit","dry_run":false}
```

- `input_folder`：workspace 根目录；别名 `folder_path`。必须位于共享 UAI authoring 所有权根目录 `Saved/UAI`、`Saved/UeAssetFolders` 或 `Saved/UeAgentInterface` 的后代目录；所有权根本身不能作为输入目录。
- `dry_run`：默认 `true`。`true` 成功时返回 `status=ready`、`phase=preflight`；`false` 成功时返回 `status=applied`、`phase=complete`。
- 返回包含 `units_checked`、`mutations_applied`、Actor/Component create/update/remove 计数及 `rollback_attempted`、`rollback_succeeded`。
- mutation 或 verification 失败会触发原子回滚；命令不负责保存关卡。
- Component `remove` 后若同一事务的后续操作失败，回滚会恢复原组件的 class、名称、属性、attachment/socket 与父级局部 transform；若被移除组件原本是 Actor 的 `RootComponent`，还必须恢复该 RootComponent 关系。恢复失败统一返回 `level_component_remove_rollback_failed`，且不得把部分重建状态报告为 `rollback_succeeded=true`。

## 推荐链路

1. 已知契约时直接编写 workspace；不确定字段时先用 `level_export_folder` 获取同类对象的 canonical HJSON。
2. 调用 `level_validate_folder`，修正所有 load、identity、reference、type 和 space contract 错误。
3. 需要审阅变化时调用 `level_diff_folder`。
4. 先用默认 dry-run，再显式 `dry_run=false` 应用。
5. 重新 `level_export_folder`，按 target identity 和 canonical value 做真实状态读回。

Export 是独立只读投影：默认只输出编辑所需字段，不输出 operations 列表、`control_type`、`category_path`；`value_text` 只在 readback/debug profile 保留，或在无法形成可靠结构化 value 时作为兜底。
