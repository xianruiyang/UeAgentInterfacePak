---
title: "组件"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/components-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "组件"]
---

# 组件

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / 组件

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/components-in-unreal-engine

**组件** 是一种特殊类型的 **对象**，**Actor** 可以将组件作为子对象附加到自身。组件适用于共享相同的行为，例如显示视觉表现、播放声音。它们还可以表示项目特有的概念，例如载具解译输入和改变其速度与方向的方式。举例而言，某个项目拥有用户可控制车辆、飞机和船只。可以通过更改载具Actor所使用的组件来实现载具控制和移动的差异。

## Actor组件

`UActorComponent` 是所有组件的基类。由于组件是渲染网格体和图像、实现碰撞和播放音频的唯一方法，因此玩家游戏期间在场景中看到或进行交互的一切其实都是某一类组件的成果。

创建自己的组件时，需要了解一些主要的类：**Actor组件**、**场景组件** 和 **Primitive组件**。

- **Actor组件**（类 `UActorComponent`）最适用于抽象行为，例如移动、物品栏或属性管理，以及其他非物理概念。Actor组件没有变换，即它们在场景中不存在任何物理位置或旋转。
- **场景组件**（类 `USceneComponent`、`UActorComponent` 的子项）支持基于位置的行为，这类行为不需要几何表示。这包括弹簧臂、摄像机、物理力和约束（但不包括物理对象），甚至音频。
- **Primitive组件**（类 `UPrimitiveComponent`、`USceneComponent` 的子项）是拥有几何表示的场景组件，通常用于渲染视觉元素或与物理对象发生碰撞或重叠。这包括静态或骨架网格体、Sprite或公告板、粒子系统以及盒体、胶囊体和球体碰撞体积。

### 注册组件

为了让Actor组件能够逐帧更新并影响场景，引擎必须 **注册** 这类组件。如果在Actor产生过程中，作为Actor子对象自动创建了组件，则这类组件会自动注册。但是，游戏期间创建的组件可以使用手动注册。`RegisterComponent` 函数提供了这个功能，要求是组件与Actor关联。

> [!NOTE]
> 游戏期间注册组件可能会影响性能，因此只应在必要时进行此操作。

#### 注册事件

在注册组件的过程中，引擎会将组件与场景关联起来，让其可用于逐帧更新，并运行以下 `UActorComponent` 函数：

| 函数 | 描述 |
| --- | --- |
| `OnRegister` | 在注册组件时，可以覆写此函数来添加代码。 |
| `CreateRenderState` | 初始化组件的[渲染状态](#sceneproxy)。 |
| `OnCreatePhysicsState` | 初始化组件的[物理状态](#physicsstate)。 |

### 取消注册组件

要从更新、模拟或渲染过程中移除Actor组件，可以使用 `UnregisterComponent` 函数将其取消注册。

#### 取消注册事件

在组件取消注册时，将运行下面的 `UActorComponent` 函数。

| 函数 | 描述 |
| --- | --- |
| `OnUnregister` | 在取消注册组件时，可以覆写此函数来添加代码。 |
| `DestroyRenderState` | 取消初始化组件的渲染状态。 |
| `OnDestroyPhysicsState` | 取消初始化组件的物理状态。 |

### 更新

Actor组件能够以类似于Actor的方法逐帧更新。`TickComponent` 函数允许组件逐帧运行代码。例如，**USkeletalMeshComponent** 使用其 `TickComponent` 函数来更新动画和骨架控制器，而 **UParticleSystemComponent** 更新其发射器和处理粒子事件。

默认情况下，Actor组件不更新。为了让Actor组件逐帧更新，必须在构造函数中将 `PrimaryComponentTick.bCanEverTick` 设置为 `true` 来启用tick。之后，在构造函数中或其他位置处，必须调用 `PrimaryComponentTick.SetTickFunctionEnable(true)` 以开启更新。之后可调用 `PrimaryComponentTick.SetTickFunctionEnable(false)` 停用tick。如果您知道组件永远不需要更新，或者打算手动调用自己的更新函数（也许从拥有的Actor类），将 `PrimaryComponentTick.bCanEverTick` 保留为默认值 `false` 即可，这样可以稍微改善性能。

### 渲染状态

为进行渲染，Actor组件必须创建渲染状态。此渲染状态还会告诉引擎，需要更新渲染数据的组件已发生变更。当发生此类变更时，渲染状态会被标记为"dirty"。如果编译您自己的组件，可以使用 `MarkRenderStateDirty` 函数将渲染数据标记为dirty。在一帧结束时，所有dirty组件的渲染数据都会在引擎中更新。场景组件（包括Primitive组件）默认会创建渲染状态，而Actor组件则不会。

### 物理状态

要与引擎的物理模拟系统交互，Actor组件需要物理状态。物理状态会在发生变化时立即更新，防止出现"帧落后"瑕疵等问题，也不需要"dirty"标记。默认情况下，Actor组件和场景组件没有物理状态，但基元组件有。覆盖 `ShouldCreatePhysicsState` 函数以确定组件类实例是否需要物理状态。

> [!NOTE]
> 如果类使用物理，则不建议只返回 `true`。请参阅函数的 `UPrimitiveComponent` 版本，了解不应创建物理状态的情况（例如在组件破坏期间）。在正常返回 `true` 的情况下，还可以返回 `Super::ShouldCreatePhysicsState`。

### 视觉化组件

某些Actor和组件没有视觉表示，使它们难以选择，或有一些重要属性不可见。在编辑器中工作时，开发者可以添加额外的组件来显示信息，但在编辑器中运行时或运行打包版本时不需要这些额外组件。为解决这个问题，编辑器支持 **视觉化组件** 的概念，这是只在编辑器中工作时存在的普通组件。

要创建视觉化组件，需创建常规组件并在其上方调用 `SetIsVisualizationComponent`。由于组件无需存在于编辑器之外，所有对它的引用都应当处在对 `WITH_EDITORONLY_DATA` 或 `WITH_EDITOR` 的预处理器检查之中。这将确保打包版本不受这些组件的影响，并保证不会在代码中的任何位置引用它们。举例而言，**摄像机组件** 使用多个其他组件来在编辑器中显示实用信息，包括用于显示视图视锥的 **绘制视锥组件**。在头文件中，绘制视锥组件在类中进行如下定义：

```
	#if WITH_EDITORONLY_DATA		// 用于显示摄像机视野所在位置的视锥组件		class UDrawFrustumComponent* DrawFrustum;		// ...	#endif 
```

同样，对这个组件的所有引用应当位于源文件中对 `WITH_EDITORONLY_DATA` 的预处理器检查之中。`OnRegister` 中的 `WITH_EDITORONLY_DATA` 检查内部的这段代码，将检查确认摄像机组件是否连接到有效Actor，然后添加绘制视锥组件代码：

```
	void UCameraComponent::OnRegister()	{	#if WITH_EDITORONLY_DATA		if (AActor* MyOwner = GetOwner())		{			// ...			if (DrawFrustum == nullptr)			{				DrawFrustum = NewObject<UDrawFrustumComponent>(MyOwner, NAME_None, RF_Transactional | RF_TextExportTransient);				DrawFrustum->SetupAttachment(this);				DrawFrustum->SetIsVisualizationComponent(true);				// ...			}		}		// ...	#endif		Super::OnRegister();		// ...在此处编写其他代码（在所有版本中运行）...	} 
```

`DrawFrustum` 现仅存在于编辑器中，被视为视觉化组件，即在编辑器中进行游戏测试时不会显示。

## 场景组件

场景组件是指存在于场景中特定物理位置处的Actor组件。该位置由 **变换**（类 [`FTransform`](https://api.unrealengine.com/INT/API/Runtime/Core/Math/FTransform/index.htm)）定义，其中包含组件的位置、旋转和缩放。场景组件能够通过将彼此连接起来形成树，Actor可以将单个场景组件指定为"根"，意味着这个Actor的场景位置、旋转和缩放都根据此组件来绘制。

### 附加

只有场景组件（`USceneComponent` 及其子类）可以彼此附加，因为需要变换来描述子项和父项组件之间的空间关系。虽然场景组件可以拥有任意数量的子项，但只能拥有一个父项，或可直接放置在场景中。场景组件系统不支持附加循环。两种主要方法分别是 `SetupAttachment` 和 `AttachToComponent`。前者在构造函数中、以及处理尚未注册的组件时十分实用；后者会立即将场景组件附加到另一个组件，在游戏进行中十分实用。该附加系统还允许将Actor彼此之间进行附加，方法是将一个Actor的根组件附加到属于另一个Actor的组件。

## 基元组件

**基元组件**（类 `UPrimitiveComponent`）是包含或生成某类几何的场景组件，通常用于渲染或碰撞。各种类型的几何体，目前最常用的是 **盒体组件**、**胶囊体组件**、**静态网格体组件** 和 **骨架网格体组件**。盒体组件和胶囊体组件生成不可见的几何体进行碰撞检测，而静态网格体组件和骨架网格体组件包含将被渲染的预制几何体，需要时也可以用于碰撞检测。

### 场景代理

基元组件的 **场景代理**（类 `FPrimitiveSceneProxy`）封装场景数据，引擎使用这些数据来与游戏线程并行渲染组件。每种类型的基元都有自身的场景代理子类，用来保存所需的特定渲染数据。

请参阅[渲染系统概述](../../../designing-visuals-rendering-and-graphics/index.md)，了解关于基元和渲染几何体的更多详情。
