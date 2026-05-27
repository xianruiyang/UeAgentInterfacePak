---
title: "Pawn"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/pawn-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "Pawn"]
---

# Pawn

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / Pawn

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/pawn-in-unreal-engine

**Pawn** 是可那些由玩家或 AI 控制的所有 Actor 的基类。Pawn 是玩家或 AI 实体在游戏场景中的具化体现。这说明， Pawn 不仅决定了玩家或 AI 实体的外观效果，还决定了它们如何与场景进行碰撞以及其他物理交互。某些游戏可能在游戏中没有可见的玩家模型或替身（Avatar），因此这点在某些情况下可能会令人困惑。不过，无论如何，Pawn 仍代表着玩家或实体在游戏中的物理方位、旋转角度等。[Character](characters/index.md) 是一种特殊的、可以行走的 Pawn。

默认情况下，[控制器（Controllers）](../controllers/index.md)和 Pawn 之间是一对一的关系；也就是说，每个控制器在某个时间点只能控制一个 Pawn。此外，在游戏期间生成的 Pawn 不会被控制器自动控制。

在 **蓝图（Blueprints）** 中，为Pawn以及Pawn的子类添加移动的最佳方法是调用 **SetActorLocation** 函数。用 **SetActorLocation** 时，你可以决定是瞬移还是逐渐走到某个位置。如果是逐渐走到某个位置，那你的 Pawn 会沿某个方向移动，并且如果撞到东西就会停下来。

## 默认 Pawn

尽管 Pawn 类只提供了用于在场景中展现玩家或 AI 实体的最基本的功能，但其子类 *DefaultPawn* 还附带了一些额外的组件和功能。

DefaultPawn 类包含了原生的 *DefaultPawnMovementComponent*、球形 *CollisionComponent* 组件以及一个 *StaticMeshComponent* 组件。为了控制 *DefaultPawnMovementComponent* 以及摄像机，DefaultPawn 类还包含一个用于添加移动绑定的布尔值，并且被默认设置为 *true*。

### DefaultPawnMovementComponent

DefaultPawnMovementComponent 的移动风格被设置为无重力并且可飞行。除了原有的 *MovementComponent* 变量外，它还包括"MaxSpeed​​"、"Acceleration"和"Deceleration"等浮点值。这三个变量也可以在 DefaultPawn 的子类的蓝图中访问。

### Spectator Pawn

*SpectatorPawn_类是 DefaultPawn 的子类。通过[GameMode](../game-mode-and-game-state/index.md)中，可以将不同的类指定为默认的 Pawn 和 SpectatorPawn。这个类提供了一个的简单框架，很适合用于实现观看功能。和 DefaultPawn 一样，它包含一个球体碰撞组件，但由于 `.DoNotCreateDefaultSubobject(Super::MeshComponentName)` 的实现，它缺少一个 _静态网格体组件（StaticMeshComponent）*。 SpectatorPawn 类的移动在 SpectatorPawnMovementComponent 中处理；它的无重力飞行行为与 *DefaultPawnMovementComponent* 中的相同，并添加了在必要的代码，用于处理或忽略时间膨胀（time dilation）。
