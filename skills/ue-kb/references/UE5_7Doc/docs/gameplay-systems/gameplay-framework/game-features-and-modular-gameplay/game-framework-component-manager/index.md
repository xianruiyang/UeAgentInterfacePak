---
title: "游戏框架组件管理器"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/game-framework-component-manager-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "游戏功能和模块化Gameplay", "游戏框架组件管理器"]
---

# 游戏框架组件管理器

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / 游戏功能和模块化Gameplay / 游戏框架组件管理器

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/game-framework-component-manager-in-unreal-engine

**游戏框架组件管理器（Game Framework Component Manager）** 是 **模块化Gameplay插件（Modular Gameplay plugin）** 中的一个 **游戏实例子系统（Game Instance Subsystem）** 。它可以与 **游戏功能插件（Game Feature Plugins）** 一起使用。 该子系统中实现的函数可以由 **游戏功能操作（Game Feature Actions）** 用于支持可扩展性。 游戏功能操作由一般Gameplay代码用于协调不同Gameplay对象之间的通信。管理器实现两个基本系统：**扩展处理程序（Extension Handlers）** 和 **初始化状态（Initialization States）** 。

## 扩展处理程序系统

扩展处理程序系统允许在激活游戏功能时修改游戏对象。此系统有两个部分：**Actor** 充当注册以扩展的 **接收器（Receivers）** ，**扩展处理程序（Extension Handlers）** 是为响应事件而触发的委托。这些事件包括处理新的接收器、删除现有接收器，以及Gameplay代码调用的任意事件。

## 接收器和扩展处理程序

要正确注册为接收器，Actor应当从 `PreInitializeComponents` 方法调用 `AddGameFrameworkComponentReceiver` 函数，并从 `EndPlay` 方法调用 `RemoveGameFrameworkComponentReceiver` 函数。这可确保它在正常组件初始化过程中注册为接收器，并在删除或禁用Actor时注销。

接收器可以调用 `SendGameFrameworkComponentExtensionEvent` 函数以发送任意事件。不同于下面所述的[初始化状态系统](#%E5%88%9D%E5%A7%8B%E5%8C%96%E7%8A%B6%E6%80%81%E7%B3%BB%E7%BB%9F)，这些扩展事件是无状态的，只会修改当前处于活动状态的处理程序。 要正确注册扩展处理程序，`GameFeatureAction_AddComponents` 等类可以调用 `AddExtensionHandler` 来注册手动委托，或调用 `AddComponentRequest` 以调用包装器函数，后者将自动添加所需组件。

在两种情况下，添加函数返回的句柄都需要像数组一样存储，因为委托保持注册状态的前提是存在对返回的句柄结构体的实时共享指针引用。

## Lyra示例

有关此系统的用法示例，可以查看[Lyra示例游戏](../../../../samples-and-tutorials/sample-game-projects/lyra-sample-game/index.md)中的实现。`ALyraCharacter` 类用于游戏中的所有角色，并从 `AModularCharacter` 类继承，后者将注册作为接收器处理。此外，你可以观察 **LyraHUD** Actor，它会手动调用此函数以启用UI扩展。 Lyra中诸如 `ShooterCore` 等游戏功能插件使用引擎定义的 `UGameFeatureAction_AddComponents` 操作将组件添加到生成的Actor。Lyra使用诸如 `UGameFeatureAction_AddInputBinding` 等一些特定于游戏的操作来处理一些特定于游戏的情况。

对于特定于游戏的 `UGameFeatureAction_AddInputBinding` 操作，`HandlePawnExtension` 函数注册为手动扩展处理程序，并响应多个不同的扩展事件。为所有相关Actor首次添加或删除扩展处理程序时，将调用诸如 `NAME_ExtensionRemoved` 和 `NAME_ExtensionAdded` 等事件。它会在需要绑定特定于功能的输入事件时，响应 **LyraHeroComponent** 发射的特定于游戏的 `NAME_BindInputsNow` 事件。

## 初始化状态系统

初始化状态系统（**初始状态（Init State）**）提供了相应函数，用于跟踪附加到游戏世界中Actor的不同功能（通常由组件实现）的初始化和一般生命周期。该系统不用作通用Gameplay状态机，因为状态是为整个游戏全局定义的，并且从创建到完全初始化进行线性排列。

在Actor上同步组件初始化是复杂的过程，尤其是在涉及网络复制的情况下。该系统提供了注册和通知函数，有助于简化协调工作。低级别函数由游戏框架组件管理器实现，有一个可选的原生GameFrameworkInitStateInterface，它可以由实现指定功能的组件（或其他Gameplay对象）继承。

## Actor功能

在该系统注册的Actor将有多个 **Actor功能** ，这些功能定义为唯一的 **名称** 。这些名称由游戏定义，并且可以对应于原生类名或功能特性。 该子系统将跟踪为Actor注册的所有功能的 **初始状态（Init State）** 和实现程序对象（通常是一个组件）。对于实现 `GameFrameworkInitStateInterface` 的对象，功能名称由 `GetFeatureName` 接口函数返回，并用于其他所有操作。

## 初始状态

**初始状态（Init States）** 实现为[Gameplay标签](https://dev.epicgames.com/documentation/404)，必须在游戏实例初始化期间通过调用 `RegisterInitState` 向子系统注册。这些状态按顺序注册，共享给游戏中的所有Actor。例如，一个游戏可以支持使用 `InitState.Spawning` 和 `InitState.Ready` 的简单双状态系统，也可以使用更复杂的系统，类似下面的[Lyra示例](#lyra%E7%A4%BA%E4%BE%8B)。

## 报告和查询状态

向此系统注册的所有功能都需要在每次更改初始状态时向游戏框架组件管理器报告，因为管理器会存储该状态，供以后查询。管理器不会对状态更改强制实施限制，而是具备灵活性。

`GameFrameworkInitStateInterface` 为简单的C++状态机提供了框架，通过覆盖几个函数，即可快速实现该状态机：

| 函数 | 覆盖说明 |
| --- | --- |
| `CanChangeInitState` | 该函数应该覆盖以在允许请求的状态过渡时返回true。你会在这里实施检查，了解必需的数据是否可用。 |
| `HandleChangeInitState` | 该函数应该覆盖以执行在特定状态过渡时应发生的特定于对象的更改。 |
| `CheckDefaultInitialization` | 可以覆盖以尝试遵循功能的默认初始化路径。如果使用初始状态数组调用 `ContinueInitStateChain` 函数，它将调用 `CanChangeInitState` 和 `HandleChangeInitState` 以到达状态链中尽可能远的地方。 该函数应从可能推进初始化的 `OnRep` 函数等地方调用。 |

此外，该子系统和接口提供了注册和查询函数：

| 函数 | 说明 |
| --- | --- |
| `RegisterInitStateFeature` | 向系统注册，但不设置状态，这很适合从组件 `OnRegister` 调用。 |
| `UnregisterInitStateFeature` | 这通常应该从 `EndPlay` 调用，以从系统注销并取消绑定通知委托。 |
| `HasReachedInitState` | 可以调用该函数以查看功能是否已达到指定状态或初始化顺序中的稍后状态。 |
| `HaveAllFeaturesReachedInitState` | 对管理器调用该函数可查看是否所有功能都已达到特定状态。这很适合用于协调扩展，因为你可以设置一个中央功能，使其等待其他所有功能就绪，然后再过渡到下一个状态。 |

## 注册状态更改

该系统最有用的部分是，可以注册初始状态更改并在达到特定状态后调用委托。`RegisterAndCallForActorInitState` 等注册函数会在功能达到特定状态时调用指定委托，如果该功能已经达到该状态，则会立即调用委托。

你可以使用类名调用 `RegisterAndCallForClassInitState` 来侦听是否有功能达到该状态，这很适合用于侦听全局初始化。你可以从C++代码或蓝图调用这些函数，接口上的版本会填充功能名称。委托执行逻辑旨在处理连续发生的多个状态过渡，并且将调用所有相关委托。

为方便使用，`BindOnActorInitStateChanged` 和 `OnActorInitStateChanged` 可以用于接口，以快速侦听对同一个Actor的其他功能的更改。然后，可将其用于调用 `CheckDefaultInitialization` 等函数，从而推进功能初始状态。

## Lyra示例

有关此系统的用法示例，请查看5.1或更高版本[Lyra示例游戏](../../../../samples-and-tutorials/sample-game-projects/lyra-sample-game/index.md)中的实现。Lyra的5.0版本日期早于初始化状态系统，并且有多个竞争条件是此系统旨在帮助解决的。下面是Lyra示例使用的状态，如 `ULyraGameInstance::Init` 中所注册

| 初始状态 | 说明 |
| --- | --- |
| `InitState.Spawned` | 功能已完成生成和初始复制，从 `BeginPlay` 调用。 |
| `InitState.DataAvailable` | 功能需要的所有数据都已复制或加载，包括其他Actor上也可能需要复制的依赖关系。 |
| `InitState.DataInitialized` | 所有数据都可用之后，该状态用于完成其他初始化操作，如添加Gameplay能力。 |
| `InitState.GameplayReady` | 对象已完成所有初始化，并准备好在正常Gameplay中进行交互。 |

使用此系统的两个主要组件是 `ULyraPawnExtensionComponent` 和 `ULyraHeroComponent` ，前者协调总体初始化，后者处理摄像机和输入等玩家控制的系统的初始化。 两个组件的初始化都依赖于从多个源复制的数据，并且它们从 `OnRegister` 方法调用 `RegisterInitStateFeature` 函数，让组件管理器知道它们存在。两个组件稍后会在初始复制完成后从 `BeginPlay` 方法调用 `CheckDefaultInitialization` 函数。

这两个组件需要完整初始化状态机，因为它们还依赖于 `LyraPlayerState` 等其他Actor复制的数据，这些数据可能下载起来很慢。下面的列表显示了Lyra角色的总体初始化时间轴。

1. 角色最初在客户端和服务器上生成时，它会附加并注册所有组件，包括两个初始状态组件以及其他组件，如[LyraAbilitySystemComponent](../../../../samples-and-tutorials/sample-game-projects/lyra-sample-game/abilities-in-lyra/index.md)。
2. 在角色上调用 `BeginPlay` 时，它会尝试在所有组件上调用 `BeginPlay` 。在服务器上，这会立即发生，但在客户端上，所有复制的属性都已发送其初始数据之后，才会调用 `BeginPlay` 。对于每个组件，此操作会在不同的时间发生，具体取决于它们需要复制多少数据。
3. 在Hero组件或Lyra Pawn组件上调用 `BeginPlay` 时，这些组件会调用 `BindOnActorInitStateChanged` 以侦听初始状态更改，然后调用 `CheckDefaultInitialization` 以尝试遵循4状态初始化链。此时，两个组件都将达到 `InitState.Spawned` ，并将尝试继续初始化。
4. Hero组件尝试过渡到 `InitState.DataAvailable` 时，它会检查玩家状态和输入组件是否已就绪。如果该数据不可用，状态机将停顿，直至某个对象调用 `CheckDefaultInitialization` 。如果必需的数据可用，它将过渡到 `DataAvailable` ，但还无法过渡到 `DataInitialized` 。
5. Pawn扩展组件调用 `CheckDefaultInitialization` 时，它会尽可能告知其他组件（如Hero组件）将其初始化状态机向前移动。然后，在尝试将其自己的状态向前移至 `InitState.DataAvailable` 时，它会检查 `PawnData` 和控制器是否已完全可用。 Pawn扩展组件会从各种 `OnRep` 函数调用 `CheckDefaultInitialization`，以在重要的交叉Actor引用完成复制后尝试将状态机向前移动。另一个选项是从原生更新函数调用初始化函数。
6. Pawn扩展组件尝试向前移至 `InitState.DataInitialized` 时，它会在其他所有组件（如Hero组件）都达到 `DataAvailable` 之后才前移。实际过渡时，这会在Hero组件以及正在侦听的其他所有对象上激活 `OnActorInitStateChanged` 函数。
7. 发生这种情况后，扩展组件会移至 `InitState.DataInitialized` ，这会导致Hero组件也移至 `DataInitialized` 。在此过渡期间，Gameplay能力将创建并绑定到玩家输入。
8. 然后，Hero组件和Pawn扩展组件会过渡到 `InitState.GameplayReady` ，这会在 **W_Nameplate** 等类中激活蓝图回调，而这些类会在注册后等待达到此状态。

Lyra角色初始化流程很复杂，但许多网络游戏需要的初始化流程差不多同样复杂。初始状态系统旨在帮助用户更轻松地设置复杂系统，避免竞争条件或随机延迟循环。
