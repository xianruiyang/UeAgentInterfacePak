# Reflection Asset Authoring Domain

## 1. 适用范围

Reflection Asset Domain 负责以下单一 UObject 资产 profile 的通用结构化编辑：

- AI 与图资产：`behavior_tree`、`state_tree`、`eqs`、`deformer_graph`、`sequence`
- Physics 与 mesh：`physics_asset`、`static_mesh`
- Media 与 Paper2D：`media_player`、`media_source`、`media_texture`、`paper_flipbook`、`paper_sprite`、`paper_tilemap`、`paper_tileset`
- Texture：`render_target`、`runtime_virtual_texture`、`sparse_volume_texture`、`subuv_animation`、`texture_array`、`texture_collection`、`texture_cube`、`texture_cube_array`、`texture_graph`、`volume_texture`
- Material：`material_instance`

`ai_behavior_stack` 是多个资产组成的只读复合视图，不是单一 UObject authoring profile，不注册 Apply/Export contract。

## 2. 统一结构

目录、单文件和 inline source 最终都路由成一个逻辑单元。目录的唯一合法文件是 `index.hjson`：

```hjson
{
  operation: update
  target: {
    asset_path: "/Game/Example/MyAsset"
    asset_kind: render_target
    class_path: "/Script/Engine.TextureRenderTarget2D"
  }
  properties: [
    { property_path: SizeX, value_kind: int32, value: { literal: 512 } }
  ]
}
```

- `operation` 支持 contract 为该 profile 声明的 `create`、`update`、`upsert`、`clone`、`remove`。
- `target.asset_path` 是稳定 identity；`asset_kind` 是 profile 约束。
- `target.class_path` 是可选具体类约束。创建时只能选择 profile 基类范围内的非抽象类；更新和克隆时必须与真实类一致。
- `properties` 使用共享递归 UObject/UStruct/container property descriptor，不由各 profile 重复实现 parser 或 codec。
- `provider_extension.save` 可写入 Apply source；命令参数 `save` 可覆盖该值。

## 3. Apply

Apply 支持目录、单 HJSON 和 inline source。统一流程是 whole-workspace load、preflight、依赖检查、事务 mutation、可选保存、shared snapshot verification 和失败回滚。

缺失字段按 operation 处理：

- `update` 保留当前实例值。
- `create` 从 UE Factory、constructor 和 CDO 原生结果开始，再应用显式字段。
- owned UObject/UStruct/container 由共享递归解析器处理；允许的 owned object 使用真实 outer 创建。
- class、property、container 或 reference 约束冲突时在 mutation 前失败。

同一 Reflection source 中的显式 `properties` 先作为完整 proposed state 原子应用，再对发布后的真实资产触发一次整体 `PostEditChange`，最后执行 shared snapshot verification。这样 `Parent`、`BasePropertyOverrides` 等存在 UE 内部耦合的字段不会因逐字段通知而在中间状态互相覆盖；如果整体通知改变了请求语义，通知后的读回校验会使事务失败并回滚。

创建、导入、重导入、编译、bake、preview probe、运行时 setup validation 等命令仍是领域生命周期 hook，不属于通用 HJSON parser。

## 4. Export

Export 只从 Shared State Snapshot 投影，不读取 Apply request。`llm_authoring` 默认只输出：

- `operation: update`
- canonical `target`
- 可编辑 `properties`

默认不输出 `operations`、`control_type`、`category_path` 和可由 structured `value` 可靠表达的 `value_text`。`value_text` 仅允许出现在 `readback` 或 `debug` profile，或 structured value 无法可靠表达时。

ExportContract 与 ApplyInputContract 相互独立；导出的 authoring workspace 只是其中一条受支持的 Apply 输入，不限制 Apply 接收更多或更少的合法信息。

## 5. 文件和错误边界

- 目录 source 只允许 `index.hjson`，额外文件直接拒绝。
- filesystem reference 必须留在 workspace root 内。
- 同一 workspace 的重复 target、未解析依赖和 cycle 直接拒绝。
- Apply 成功必须经过写后 shared snapshot verification；不能只以命令返回成功作为资产状态证据。
- `validate_setup`、`validate_usage` 和 runtime probe 不替代 authoring source preflight。
