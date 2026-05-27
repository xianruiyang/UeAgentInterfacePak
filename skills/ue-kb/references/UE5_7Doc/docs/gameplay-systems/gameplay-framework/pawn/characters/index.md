---
title: "角色"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/characters-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "Pawn", "角色"]
---

# 角色

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / Pawn / 角色

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/characters-in-unreal-engine

添加 `CharacterMovementComponent`、`CapsuleComponent` 和 `SkeletalMeshComponent` 后，[Pawn](https://dev.epicgames.com/documentation/404)类可延展为功能完善的 **角色** 类。 角色用于代表垂直站立的玩家，可以在场景中行走、跑动、跳跃、飞行和游泳。 此类也包含基础网络连接和输入模型的实现。

### 骨架网格体组件

与pawn不同的是，角色自带 `SkeletalMeshComponent`，可启用使用骨架的高级动画。可以将其他骨架网格体添加到角色派生的类，但这才是与角色相关的主骨架网格体。 如需了解骨架网格体的更多内容，请参见：

## 骨架网格体要点

- 骨架网格体动画系统

### 胶囊体组件

`CapsuleComponent` 用于运动碰撞。为了计算 `CharacterMovementComponent` 的复杂几何体，会假设角色类中的碰撞组件是垂直向的胶囊体。如需了解碰撞的更多信息，请参见：

## 胶囊体组件要点

### 角色移动组件

`CharacterMovementComponent` 能够使人身不使用刚体物理即可行走、跑动、飞行、坠落和游泳。 其为角色特定，无法被任何其他类实现。 可在 `CharacterMovementComponent` 中设置的属性包含了摔倒和行走摩擦力的值、在空气、水、土地中行进的速度、浮力、重力标度，以及角色能对物理对象施加的物理力。 `CharacterMovementComponent` 还包含来自动画的根运动参数， 其已转换到世界空间中，可直接用于物理。
