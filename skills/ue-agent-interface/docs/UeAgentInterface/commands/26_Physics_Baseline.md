# Physics / Chaos 基础指令

本分册覆盖项目创建后默认可用的 Physics / Chaos 基础能力：PrimitiveComponent 物理状态、PhysicalMaterial、PhysicsConstraintComponent、PhysicsAsset 基础刚体/约束结构，以及编辑器世界内的轻量 runtime probe。

## 边界

- 本分册只覆盖无需额外启用可选插件的基础物理能力。
- Chaos Vehicles、Geometry Collection、Field System、Chaos Cache、Chaos Cloth/Flesh、Physics Control、Chaos Visual Debugger 等可选插件不在本基础分册内；命令遇到这些专用字段会返回 `unsupported_optional_plugin_field` 或能力报告。
- Level 中 Actor 的创建、删除、transform、folder/tag 和普通组件属性主流程仍走 `level_content_*_json`。`physics_component_plan_patch` 只负责把物理意图转换成可交给 `level_content_apply_json` 的 patch。
- `level_content_apply_json` 已对 PrimitiveComponent 的常见物理 setter 字段做安全适配：`BodyInstance.bSimulatePhysics`、`BodyInstance.bEnableGravity`、`BodyInstance.bUseCCD`、`BodyInstance.MassInKgOverride`、`BodyInstance.LinearDamping`、`BodyInstance.AngularDamping`、`BodyInstance.CollisionEnabled` 会走 UE setter 并读回，而不是裸写无效反射字段。
- Runtime probe 用于短时间验证物理状态、速度和恢复，不替代正式 PIE/gameplay 测试。

## 指令总览

| 指令 | 作用 | 关键参数 | 返回重点 |
| --- | --- | --- | --- |
| `physics_capabilities_query` | 查询基础物理可用性、碰撞 profile/channel、项目物理设置摘要和排除的可选插件 | `include_project_settings`、`include_collision_profiles`、`include_optional_plugin_status` | `baseline_physics_available`、`available_classes[]`、`collision_profiles[]`、`physics_settings_summary`、`excluded_optional_plugins[]` |
| `physics_component_query` | 查询 Actor 上 PrimitiveComponent 的物理/碰撞/质量/材质/运行时状态 | `actor_id`、`component`、`include_collision_responses`、`include_material`、`include_runtime_state` | `simulate_physics`、`collision_profile_name`、`mass_kg`、`enable_gravity`、`use_ccd`、`physical_material`、`level_content_patch_hint` |
| `physics_component_validate` | 对 PrimitiveComponent 当前物理状态做只读断言 | `actor_id`、`component`、`expected` | `ok`、`checks[]`、`mismatches[]`、`query` |
| `physics_component_plan_patch` | 将物理目标转换成 `uai.level_content.v1` patch | `actor_id`、`component`、`desired`、`emit_level_content_patch` | `properties`、`level_content_patch`、`requires_mobility_change`、`warnings[]` |
| `physical_material_export_json` | 导出 `UPhysicalMaterial` 单文件 JSON | `asset_path`、`output_file` | `schema`、`asset_path`、`properties`、`output_file` |
| `physical_material_validate_json` | 校验 PhysicalMaterial JSON | `json`/`json_file`、`strict` | `valid`、`issues[]` |
| `physical_material_apply_json` | 创建或更新 PhysicalMaterial 并读回 | `json`/`json_file`、`create_if_missing`、`backup`、`save_after_apply` | `asset_created`、`backup_created`、`property_results[]`、`readback`、`readback_hash` |
| `physics_constraint_export_json` | 导出场景中的 PhysicsConstraintComponent | `actor_id`、`component`、`output_file` | `target`、`constrained`、`constraint` |
| `physics_constraint_validate_json` | 校验 Constraint JSON 与端点、基础约束字段 | `json`/`json_file`、`strict` | `valid`、`issues[]` |
| `physics_constraint_apply_json` | 创建或更新场景 PhysicsConstraintActor/Component 并绑定两个 PrimitiveComponent | `json`/`json_file`、`create_if_missing`、`transaction` | `actor_created`、`set_constrained_components_applied`、`readback` |
| `physics_asset_export_folder` | 导出 PhysicsAsset 文件夹式 JSON | `asset_path`、`folder_path` | `asset.json`、`bodies.json`、`constraints.json`、`profiles.json`、`validation/coverage_report.json` |
| `physics_asset_validate_folder` | 校验 PhysicsAsset folder profile | `folder_path`、`strict`、`allow_destructive_replace` | `valid`、`issues[]`、`coverage_report` |
| `physics_asset_apply_folder` | 创建或更新 PhysicsAsset 基础 bodies/constraints/profiles | `folder_path`、`create_if_missing`、`backup`、`save_after_apply`、`allow_destructive_replace` | `asset_created`、`body_results[]`、`constraint_results[]`、`profile_results[]`、`readback` |
| `physics_runtime_probe` | 在 editor world 中短时间推进物理，采样速度/位移并可恢复 | `targets[]`、`duration_seconds`、`fixed_delta_seconds`、`expect[]`、`cleanup` | `samples[]`、`expectation_results[]`、`expectations_passed`、`restored` |

## PrimitiveComponent 工作流

查询当前物理状态：

```json
{
  "command": "physics_component_query",
  "params": {
    "actor_id": "SM_Crate_01",
    "component": "StaticMeshComponent",
    "include_collision_responses": true,
    "include_material": true,
    "include_runtime_state": true
  }
}
```

生成可交给 Level Content 的 patch：

```json
{
  "command": "physics_component_plan_patch",
  "params": {
    "actor_id": "SM_Crate_01",
    "component": "StaticMeshComponent",
    "desired": {
      "simulate_physics": true,
      "collision_profile_name": "PhysicsActor",
      "enable_gravity": false,
      "use_ccd": true,
      "mass_override_kg": 25.0,
      "linear_damping": 0.2,
      "angular_damping": 0.1
    }
  }
}
```

返回的 `level_content_patch` 直接用于：

```json
{
  "command": "level_content_apply_json",
  "params": {
    "mode": "patch",
    "preflight": true,
    "transaction": true,
    "validate_after_apply": true,
    "content": {
      "schema": "uai.level_content.v1",
      "resources": []
    }
  }
}
```

## PhysicalMaterial JSON

Schema：`ue_agent_interface.physical_material.v1`

```json
{
  "schema": "ue_agent_interface.physical_material.v1",
  "asset_path": "/Game/Physics/PM_Stone",
  "properties": {
    "friction": 0.8,
    "static_friction": 0.9,
    "restitution": 0.1,
    "density": 1.2,
    "surface_type": "SurfaceType_Default"
  }
}
```

写入流程：

1. `physical_material_validate_json`
2. `physical_material_apply_json`
3. `physical_material_export_json` 或读取 `readback`

## PhysicsConstraint JSON

Schema：`ue_agent_interface.physics_constraint.v1`

```json
{
  "schema": "ue_agent_interface.physics_constraint.v1",
  "target": {
    "actor_id": "Constraint_SM_A_SM_B",
    "component": "ConstraintComp"
  },
  "constrained": {
    "component1": {
      "actor_id": "SM_A",
      "component": "StaticMeshComponent"
    },
    "component2": {
      "actor_id": "SM_B",
      "component": "StaticMeshComponent"
    }
  },
  "constraint": {
    "disable_collision": true,
    "linear": {
      "x_motion": "Locked",
      "y_motion": "Locked",
      "z_motion": "Limited",
      "limit": 120.0
    },
    "angular": {
      "swing1_motion": "Limited",
      "swing1_limit_degrees": 30.0,
      "swing2_motion": "Limited",
      "swing2_limit_degrees": 30.0,
      "twist_motion": "Locked"
    }
  }
}
```

`target.component` 支持实际组件名，也支持 `ConstraintComp` / `PhysicsConstraintComponent` 这类 `APhysicsConstraintActor` 常见别名。

## PhysicsAsset Folder Profile

文件夹结构：

```text
PhysicsAssetProfile/
  asset.json
  bodies.json
  constraints.json
  profiles.json
  validation/
    coverage_report.json
```

`asset.json`：

```json
{
  "schema": "ue_agent_interface.physics_asset.v1",
  "asset_path": "/Game/Physics/PA_Character",
  "skeletal_mesh": "/Game/Characters/SK_Character.SK_Character",
  "skeleton": ""
}
```

`bodies.json`：

```json
{
  "replace_all": true,
  "bodies": [
    {
      "bone_name": "pelvis",
      "body_name": "pelvis",
      "physics_type": "Default",
      "primitive_shapes": [
        {
          "type": "sphere",
          "radius": 32.0,
          "transform": {
            "location": [0, 0, 0],
            "rotation": [0, 0, 0],
            "scale": [1, 1, 1]
          }
        }
      ]
    }
  ]
}
```

`constraints.json`：

```json
{
  "replace_all": false,
  "constraints": [
    {
      "name": "spine_to_pelvis",
      "parent_body": "pelvis",
      "child_body": "spine_01",
      "linear": {
        "x_motion": "Locked",
        "y_motion": "Locked",
        "z_motion": "Locked"
      },
      "angular": {
        "swing1_motion": "Limited",
        "swing1_limit_degrees": 25.0,
        "swing2_motion": "Limited",
        "swing2_limit_degrees": 25.0,
        "twist_motion": "Limited",
        "twist_limit_degrees": 15.0
      }
    }
  ]
}
```

`replace_all=true` 属于破坏性替换，validate/apply 必须显式传 `allow_destructive_replace=true`。

## Runtime Probe

```json
{
  "command": "physics_runtime_probe",
  "params": {
    "duration_seconds": 0.1,
    "fixed_delta_seconds": 0.0166667,
    "targets": [
      {
        "actor_id": "SM_Probe",
        "component": "StaticMeshComponent",
        "initial_impulse": [0, 0, 250],
        "initial_velocity": [0, 0, 250]
      }
    ],
    "expect": [
      {
        "actor_id": "SM_Probe",
        "component": "StaticMeshComponent",
        "min_velocity_size": 1.0
      }
    ],
    "cleanup": "restore_transforms"
  }
}
```

说明：

- `targets[].initial_impulse` 使用 UE `AddImpulse`。
- `targets[].initial_velocity` 使用 UE `SetPhysicsLinearVelocity`，用于在 NullRHI / editor world smoke 中获得可重复采样。
- `cleanup=restore_transforms` 会恢复 Actor transform、线速度和角速度。
- 如果目标组件未注册或未模拟物理，命令返回 `physics_probe_unstable_world`，不会伪造成功。

## 测试覆盖

自动化 smoke 组：

`GptProjectTest.UeAgentInterface.Smoke.Physics`

覆盖：

- capabilities 查询和可选插件排除清单。
- PrimitiveComponent query / validate / plan patch / LevelContent apply / readback。
- PhysicalMaterial validate / apply / export round-trip。
- PhysicsConstraint validate / apply / export round-trip，包含别名解析和端点绑定。
- PhysicsAsset folder validate / apply / export round-trip，包含 body、shape、profile、coverage report。
- Runtime probe 速度采样和 restore。
- 可选插件字段 strict guard。
