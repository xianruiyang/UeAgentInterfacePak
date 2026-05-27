# Significance Manager

---
title: "Significance Manager"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/significance-manager-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "测试并优化你的内容", "Significance Manager"]
---

# Significance Manager

> 路径：虚幻引擎5.7文档 / 测试并优化你的内容 / Significance Manager

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/significance-manager-in-unreal-engine

要满足即将发布的游戏的性能目标，通常需要通过降低场景复杂度的方式达到目标分辨率或帧率。大家经常使用的方法包括适用于几何体、动画甚至音频的细节层级系统，但是在某些情况下，这些基于距离的、按Actor的方法无法满足需求。在多人游戏中，具有大量可能会在单个区域中聚集的玩家或AI控制的角色，此问题就更加突出。

**Significance Manager** 提供了一个支持编写特定于项目的灵活代码的能力的集中框架，这些代码可用于对对象求值并确定它们相对于彼此的优先顺序。通过使用该评估方法，对象可通过关闭 **粒子发射器** 等 **组件** 或以较低的频率运行复杂AI代码的方式修改其行为。

> [!NOTE]
> 实际上，Significance Manager自身并不会提升性能，但是大家可以覆盖和自定义它提供的系统以满足项目的特定需求。

## 设置

由于Significance Manager存在于插件中，需要在 **编辑（Edit） > 插件（Plugins）** 菜单中启用它，而且必须将它的模块添加到项目的 `*.Build.cs` 文件。

![SignificancePlugin.png](../../../assets/images/b9/b96b3783983b82fa14017fb7537a490ba7f2ae829a96d93df190f04d145d7fa6.jpg)

*Significance Manager位于"插件（Plugins）"菜单的"编程（Programming）"部分中。*

> [!NOTE]
> 启用Significance Manager插件之后，可能需要重启引擎。

启用插件之后，需要在项目的 `*.Build.cs` 文件中将"SignficanceManager"添加到 `PublicDependencyModuleNames` 中。以下示例代码行来自"基础C++（Basic C++）"项目模板，我们对它进行了修改，以使用Significance Manager：

```
	PublicDependencyModuleNames.AddRange(new string[] { "Core", "CoreUObject", "Engine", "InputCore", "SignificanceManager" });
```

## Significance Manager的基本功能

Significance Manager插件包含一个单独的类 `USignificanceManager`，它可作为对管理对象的"重要性"进行求值的可扩展框架。然后，这些对象可基于它们的重要性数值以自定义的方式调整它们的行为，以减小它们对性能的影响。可通过游戏代码中的对象自定义这些可带来性能提升的特定行为。例如，播放不明显的音频提示或粒子效果的Actor可选择在其具有低重要性数值时不播放音频提示或粒子效果。在更加高级的用例中，它可能会将相似的Actor聚集到一起然后按Actor类型制定预算。其中的一个用法可能是：为确保玩家控制的Pawn在距离摄像机较近时始终以高细节级别运行，将通过相应地限制以高细节级别运行的AI控制的Pawn的数量，来减小多个玩家聚集在摄像机周围带来的性能影响。

### RegisterObject / UnregisterObject

对象可以被注册给Significance Manager，并基于用户指定的名称与其他已注册的对象分组到一起。在注册过程中，用户可以指定用于对对象的重要性进行求值的函数，还可以指定将在求值后运行的可选函数。注册过程中，将使用最近一次调用Significance Manager的Update函数时使用的Transform计算对象的初始重要性（如果可能）。这也使执行更高级别的处理成为可能，例如，基于已知的已注册对象列表（不同的类型可能具有不同的列表）构建内部数据结构，在游戏为不同类型的对象执行基于类别的预算时，这非常有用。

### GetSignificance / QuerySignificance

这些函数报告对象的缓存重要性数值。如果未向Significance Manager注册对象，该值将为零。`QuerySignificance` 函数与 `GetSignificance` 不同，它也会通过返回 `false` 来表明对象未注册。

### Update

该函数需要用到Transform数组，并使用与对象关联的重要性函数基于每个Transform求得每个管理对象的重要性值。最终结果将为返回的最高值（如果 `bSortSignificanceAscending` 设置为 `true`，则为最低值）。可以覆盖该函数来满足游戏的需求，例如，对系统实现处理前或处理后步骤。在求得对象的重要性之后，将会调用其"重要性求值后函数（Post Significance Function）"（如已指定）。如果对象的"重要性求值后类型（Post Significance Type）"是"并发（Concurrent）"，将立即调用该函数。如果其类型为"串行（Sequential）"，将会按重要性从高到低的顺序调用它，而所有其他管理对象则使用"串行更新后处理（Sequential post-update）"。如果未提供Transform，重要性数值将为零。

重要性求值和重要性求值后函数并行运行，这就要求这些函数是线程安全的函数。重要性求值后函数可通过顺序运行避开该要求（请参阅下面的 `FPostSignificanceFunction` 部分获取细节）。

> [!NOTE]
> `Update` 函数不自动运行。在大部分情况下，开发者每帧都需要调用它，而且每帧仅调用一次。调用它的合理位置可能在 `UGameViewportClient` 的被覆盖版本中，如以下代码所示：
>
> ```
> 	#include "MyGameViewportClient.h"	#include "SignificanceManager.h"	#include "Kismet/GameplayStatics.h"	void UMyGameViewportClient::Tick(float DeltaTime)	{		// 调用超类的Tick函数。		Super::Tick(DeltaTime);		// 确保具有有效的世界场景和Significance Manager实例。		if (UWorld* World = GetWorld())		{			if (USignificanceManager* SignificanceManager = FSignificanceManagerModule::Get(World))			{				// 仅使用玩家0的全局变换，每帧更新一次。				if (APawn *PlayerPawn = UGameplayStatics::GetPlayerPawn(World, 0))				{					// Significance Manager使用ArrayView。构造单元素数组来容纳Transform。					TArray<FTransform> TransformArray;					TransformArray.Add(PlayerPawn->GetTransform());					// 使用通过ArrayView传入的单元素数组来更新Significance Manager。					SignificanceManager->Update(TArrayView<FTransform>(TransformArray));				}			}		}	} 
> ```

## 项目侧功能

Significance Manager仅提供用于确定对象的重要性的框架，具体的计算需要由开发者在项目中定义。向Significance Manager注册对象时，也将注册与以下类型匹配的函数：

- FSignificanceFunction
- FPostSignificanceFunction

在Significance Manager进行更新的过程中，将针对对象调用这些函数。

### FSignificanceFunction

这是使用Significance Manager时必须要编写的主要求值函数。它需要使用对象参数和单个Transform来计算对象的重要性，返回的重要性数值为 `float` 类型。在Significance Manager的更新过程中，将针对每个传入的Transform调用一次该函数。最终结果将由Significance Manager的Update函数确定，默认情况下，它将为最高值。注册对象时，需要将每个对象与类型为 `FSignificanceFunction` 的函数相关联。

### FPostSignificanceFunction

该类型的函数需要用到对象本身、其原重要性数值、其新重要性数值（除非对象已注销，如果已注销，该值为一）以及指示对象当前是否已被注销的 `bool`。与重要性求值函数不同，该函数没有返回值。它为游戏提供了一种方法来处理对对象的重要性或在管理对象的总体顺序中的位置的更改。Significance Manager将基于对象的注册方式来调用该函数：

| 重要性求值后类型 | 行为 |
| --- | --- |
| **无（None）** | 函数将为null。无重要性求值后回调。 |
| **并发（Concurrent）** | 函数将不为null，将在进行对象重要性求值时立即调用。用这种方式调用的函数必须是线程安全的函数，因为它们将并行运行。 |
| **串行（Sequential）** | 函数将不为null，将会在对所有对象进行重要性求值之后按它们相对于其他顺序对象的排序调用。 在这种情况下，不要求代码是线程安全的代码。 |

