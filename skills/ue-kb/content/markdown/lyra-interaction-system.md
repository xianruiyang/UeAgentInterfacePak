# Lyra Interaction System

---
title: "Lyra Interaction System"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/lyra-sample-game-interaction-system-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "示例与教学", "游戏示例项目", "Lyra示例游戏", "Lyra Interaction System"]
---

# Lyra Interaction System

> 路径：虚幻引擎5.7文档 / 示例与教学 / 游戏示例项目 / Lyra示例游戏 / Lyra Interaction System

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/lyra-sample-game-interaction-system-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

## Lyra 交互系统

Lyra 使用自身的交互 [接口](../../../../cpp-programming/reflection-system/interfaces/index.md)/[IInterface](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/IInterface?application_version=5.5) 并通过自身的 [Gameplay Ability](../../../../gameplay-systems/gameplay-ability-system/index.md)/[UGameplayAbility](https://dev.epicgames.com/documentation/unreal-engine/API/Plugins/GameplayAbilities/Abilities/UGameplayAbility?application_version=5.5) （ULyraGameplayAbility_Interact）建立玩家如何与 Lyra 中对象交互，以及这些对象如何与玩家交互之间的因果关系。

使用 `LyraGameplayAbility_Interact` 类，可以管理交互调用逻辑。

**ULyraGameplayAbility_Interact.h**

C++

```
#pragma once
		#include "CoreMinimal.h"
		#include "AbilitySystem/Abilities/LyraGameplayAbility.h"
		#include "Interaction/InteractionQuery.h"
		#include "Interaction/IInteractableTarget.h"
		#include "LyraGameplayAbility_Interact.generated.h"

		class FIndicatorDescriptor;
		/**
```

`AbilityTask_WaitForInteractableTargets_SingleLineTrace` 是一个 Gameplay [Ability Task](../../../../gameplay-systems/gameplay-ability-system/gameplay-ability-tasks/index.md)，它执行线性追踪，并在循环计时器中等待，直到命中实现该接口的 Actor。

例如：

玩家控制的 LyraPawnActor 生命值较低，玩家将 Pawn 朝向可收集的生命物品。将准星对准该可收集物并按下“Use/Interact”键时，会从 Pawn 发出一条线性追踪。追踪命中可收集物后，该可收集物上实现的交互接口会处理逻辑，将玩家生命值恢复满。

## 交互 Ability Task

`UAbilityTask_WaitForInteractableTargets` 用于创建追踪可交互目标的新方法。

例如：

玩家控制的 LyraPawnActor 接近一扇想要打开的门。将准星对准门并按下“Use”键时，会出现径向菜单，提供“Unlock/Lock”门或尝试打开门的选项。

> [!NOTE]
> 关于 Unreal 中线性追踪的更多信息，请参阅 [追踪](../../../../gameplay-systems/physics/traces-with-raycasts/traces-tutorials/index.md)

**UAbilityTask_WaitForInteractableTargets.h**

C++

```
#pragma once
		#include "CoreMinimal.h"
		#include "UObject/ObjectMacros.h"
		#include "Abilities/Tasks/AbilityTask.h"
		#include "Engine/EngineTypes.h"
		#include "CollisionQueryParams.h"
		#include "WorldCollision.h"
		#include "Engine/CollisionProfile.h"
		#include "Abilities/GameplayAbilityTargetDataFilter.h"
		#include "Interaction/InteractionOption.h"
```

所选用于追踪的 AbilityTask 会从 `FInteractionQuery` 结构体提供一组可交互目标。

**struct FInteractionQuery**

C++

```
#pragma once
		#include "CoreMinimal.h"
		#include "Abilities/GameplayAbility.h"
		#include "InteractionQuery.generated.h"

		/**  */
		USTRUCT(BlueprintType)
		struct FInteractionQuery
		{
```

传递给方法 `UAbilityTask_WaitForInteractableTargets::UpdateInteractableOptions`:

C++

```
void UAbilityTask_WaitForInteractableTargets::UpdateInteractableOptions(const FInteractionQuery& InteractQuery, const TArray<TScriptInterface<IInteractableTarget>>& InteractableTargets)
		{

			TArray<FInteractionOption> NewOptions;

			for (const TScriptInterface<IInteractableTarget>& InteractiveTarget : InteractableTargets)

			{

				TArray<FInteractionOption> TempOptions;
```

，该方法会在每个可交互目标上调用 `IInteractableTarget::GatherInteractionOptions` 。

C++

```
virtual void GatherInteractionOptions(const FInteractionQuery& InteractQuery, FInteractionOptionBuilder& OptionBuilder) = 0;
```

更新可交互对象集合后，交互能力（GA_Interact）会调用 `TriggerInteraction` 函数：当玩家聚焦于某个可交互对象并输入希望与该对象交互时调用。

调用当前 Option 后，交互可以通过两种方式发生。第一种方式通过函数 `FInteractionOption::InteractionAbilityToGrant`向玩家的 Ability System Component 授予能力。对于武器拾取 Actor 等简单逻辑，推荐使用此函数。

或者，如果正在交互的对象包含自己的 Ability System Component 来处理复杂逻辑，可以调用 `FInteractionOption::TargetAbilitySystem` 和 `FInteractionOption::TargetInteractionHandle` 函数；这会在可交互对象上调用能力，而不是在 Lyra Character（Avatar）的 Ability System Component 上调用能力。

> [!NOTE]
> 交互函数 `FInteractionOption::InteractionAbilityToGrant` 继承自你的 `ULyraGameplayAbility_Interact` 交互能力基类，它会运行任务函数 `AbilityTask_GrantNearbyInteraction`，作为带范围的循环和计时器，在尝试与附近对象交互前收集附近能力并授予角色。可以增大 `InteractionScanRate` 浮点值，使其半径大于 `InteractionRange`，否则复制不会足够快地将能力传递到客户端。

该能力通过事件调用： [Gameplay Tag](../../../../gameplay-systems/programming-with-cpp/using-gameplay-tags/index.md), `FInteractionOption::InteractionEventTag`。此标签需要匹配能力中的触发器。例如， `GA_Collect_Interaction` 会在发送 `Ability.Type.Interact.Collect` 事件时触发，该事件在交互选项中设置。

`GA_Collect_Interaction` 只代表一种交互；它是一种能力，让你可以拾取地面上的对象并将其加入物品栏。你的想象力不受限制：可以制作吃地上苹果并恢复玩家生命值的能力，也可以制作开门、进入载具或打开宝箱的能力。

这种解耦行为使中央被动交互扫描器能够支持各种不同交互。

#### 重要 Lyra 交互术语

**InteractableTarget** - 实现 IInteractableTarget 接口的 Actor 或组件，用于决定 World 中哪些对象可以交互。

**InteractionOption** - “Affordance”或“Option”。例如，一个苹果可能同时提供“Collect”和“Consume”。

**InteractionInstigator** - 发起交互的 Pawn（LyraPawnActor）。它可以实现，也可以不实现 `IInteractionInstigator` 接口，该接口允许进一步自定义选项及其呈现方式。

