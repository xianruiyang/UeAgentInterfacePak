---
title: "Actor Lifecycle"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-actor-lifecycle"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "Gameplay框架", "Actors", "Actor Lifecycle"]
---

# Actor Lifecycle

> 路径：虚幻引擎5.7文档 / Gameplay系统 / Gameplay框架 / Actors / Actor Lifecycle

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/unreal-engine-actor-lifecycle

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

本文从高层概述 [Actor](../index.md)的生命周期，包括：

- Actor 如何实例化或生成到关卡中，包括 Actor 如何初始化。
- Actor 如何标记为 PendingKill，并随后通过垃圾回收移除或销毁。
- 下方流程图展示 Actor 实例化的主要路径。无论 Actor 以何种方式创建，最终都会遵循相同的销毁路径。

## 生命周期分解

## 从磁盘加载

从磁盘加载路径适用于已经存在于关卡中的任何 Actor，例如当 [UEngine::LoadMap](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UEngine/LoadMap?application_version=5.5) 发生时，或当 [关卡流送](../../../../building-virtual-worlds/level-streaming/index.md) 调用 [UWorld::AddToWorld](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UWorld/AddToWorld?application_version=5.5).

1. 包或关卡中的 Actor 会从磁盘加载。
2. 序列化后的 Actor 会调用 [PostLoad](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/UObject/PostLoad?application_version=5.5) ，时间是在其从磁盘加载完成后。任何自定义版本处理和修正行为都应在这里实现。PostLoad 与 [AActor::PostActorCreated](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PostActorCreated?application_version=5.5).
3. World 会调用 [UAISystemBase::InitializeActorsForPlay](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/AI/UAISystemBase/InitializeActorsForPlay?application_version=5.5) 来准备 Actor 开始 Gameplay。
4. 关卡会调用 [ULevel::RouteActorInitialize](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/ULevel/RouteActorInitialize?application_version=5.5) ，用于任何尚未初始化的 Actor 以及无缝旅行保留下来的 Actor。

   1. [AActor::PreInitializeComponents](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PreInitializeComponents?application_version=5.5) 会在 Actor 组件调用 InitializeComponent 之前调用。
   2. [UActorComponent::InitializeComponent](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Components/UActorComponent/InitializeComponent?application_version=5.5) 是一个辅助函数，用于创建 Actor 上定义的每个组件。
   3. [AActor::PostInitializeComponents](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PostInitializeComponents?application_version=5.5) 会在 Actor 组件初始化完成后调用。
5. [AActor::BeginPlay](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/BeginPlay?application_version=5.5) 会在关卡开始时调用。

## 在编辑器中运行

在 Play in Editor 路径中，Actor 会从编辑器复制，而不是从磁盘加载。随后，复制出来的 Actor 会以类似“从磁盘加载”路径中描述的流程初始化。

1. 编辑器中的 Actor 会被复制到新的 World 中。
2. [UObject::PostDuplicate](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/UObject/PostDuplicate?application_version=5.5) 会被调用。
3. [UAISystemBase::InitializeActorsForPlay](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/AI/UAISystemBase/InitializeActorsForPlay?application_version=5.5)
4. [ULevel::RouteActorInitialize](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/ULevel/RouteActorInitialize?application_version=5.5) 用于任何尚未初始化的 Actor，并处理无缝旅行保留下来的 Actor。

   1. [AActor::PreInitializeComponents](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PreInitializeComponents?application_version=5.5) 会在 Actor 组件调用 InitializeComponent 之前调用。
   2. [UActorComponent::InitializeComponent](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Components/UActorComponent/InitializeComponent?application_version=5.5) 是一个辅助函数，用于创建 Actor 上定义的每个组件。
   3. [AActor::PostInitializeComponents](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PostInitializeComponents?application_version=5.5) 会在 Actor 组件初始化完成后调用。
5. [AActor::BeginPlay](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/BeginPlay?application_version=5.5) 会在关卡开始时调用。

## 生成

生成 Actor 实例时，会遵循以下路径：

1. [UWorld::SpawnActor](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UWorld/SpawnActor?application_version=5.5) 会被调用。
2. [AActor::PostSpawnInitialize](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PostSpawnInitialize?application_version=5.5) 会在 Actor 生成到 World 后调用。
3. [AActor::PostActorCreated](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PostActorCreated?application_version=5.5) 会在生成的 Actor 创建后调用；任何构造后实现行为都应放在这里。PostActorCreated 与 [PostLoad](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/UObject/PostLoad?application_version=5.5).
4. [AActor::ExecuteConstruction](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/ExecuteConstruction?application_version=5.5):
5. [AActor::OnConstruction](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/OnConstruction?application_version=5.5) - Actor 的构造阶段，蓝图 Actor 会在这里创建组件并初始化蓝图变量。
6. [AActor::PostActorConstruction](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PostActorConstruction?application_version=5.5):

   1. [AActor::PreInitializeComponents](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PreInitializeComponents?application_version=5.5) 在 Actor 组件调用 InitializeComponent 之前调用。
   2. [UActorComponent::InitializeComponent](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Components/UActorComponent/InitializeComponent?application_version=5.5) 是一个辅助函数，用于创建 Actor 上定义的每个组件。
   3. [AActor::PostInitializeComponents](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PostInitializeComponents?application_version=5.5) 会在 Actor 组件初始化完成后调用。
7. [UWorld::OnActorSpawned](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UWorld/AddOnActorSpawnedHandler?application_version=5.5) 会在 UWorld 上广播。
8. [AActor::BeginPlay](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/BeginPlay?application_version=5.5) 会被调用。

## 延迟生成

如果任何属性设置为“Expose on Spawn”，Actor 可以使用延迟生成。

1. [UWorld::SpawnActorDeferred](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UWorld/SpawnActorDeferred?application_version=5.5) 用于生成程序化 Actor，允许在蓝图构造脚本运行前执行额外设置。
2. SpawnActor 中的所有步骤都会发生，但在 [AActor::PostActorCreated](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PostActorCreated?application_version=5.5) 之后会发生以下步骤：

   1. 使用有效但尚未完整的 Actor 实例执行设置，并调用各种“初始化函数”。
   2. [AActor::FinishSpawning](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/FinishSpawning?application_version=5.5) 会被调用以最终完成 Actor，并从 [AActor::ExecuteConstruction](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/ExecuteConstruction?application_version=5.5) 继续 Spawn Actor 流程。

## Actor 生命周期结束

可以通过多种方式销毁 Actor，但它们从 World 中移除的方式遵循相同方法。在 Gameplay 期间，可以调用以下函数；不过这些函数是完全可选的，因为许多 Actor 在运行期间实际上不会被销毁（参见垃圾回收）：

- [AActor::Destroy](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/Destroy?application_version=5.5) 可由游戏在需要移除 Actor 且 Gameplay 仍在进行时手动调用。该 Actor 会被标记为 pending kill，并从关卡的 Actor 数组中移除。
- [AActor::EndPlay](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/EndPlay?application_version=5.5) 会在多个位置调用，用于保证 Actor 生命周期即将结束。运行期间 Destroy 会调用此方法；如果包含该 Actor 的流送关卡被卸载，关卡切换也会调用它。
- EndPlay 会由以下情况调用：

  - 显式调用 Destroy。
  - Play in Editor 结束时。
  - 关卡切换（无缝旅行或加载地图）。
  - 包含该 Actor 的流送关卡被卸载。
  - Actor 生命周期已到期。
  - 应用程序关闭（所有 Actor 都会销毁）。

无论如何发生，Actor 都会被标记为 `RF_PendingKill` ，使 UE 在下一次垃圾回收周期中从内存释放它。此外，与其手动检查 pending kill，不如考虑使用 `FWeakObjectPtr<AActor>` ，这样更清晰。

> [!WARNING]
> Actor 在 EndPlay 被调用时不一定会被销毁。例如，如果 `s.ForceGCAfterLevelStreamedOut` is `false` 并且子关卡很快重新加载，那么 Actor 的 EndPlay 会被调用，但该 Actor 可能会“复活”，并且会是先前存在的同一个 Actor，其本地变量也不会重新初始化为默认值。

- [AActor::OnDestroyed](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor?application_version=5.5) - 这是对 Destroy 的旧式响应。建议将这里的任何逻辑移动到 EndPlay，因为关卡切换和其他游戏清理函数也会调用 EndPlay。

## 垃圾回收

对象被标记为销毁一段时间后，垃圾回收会将它从内存中移除，并释放它占用的资源。

对象销毁期间会调用以下函数：

1. [UObject::BeginDestroy](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/UObject/BeginDestroy?application_version=5.5) - 这是对象释放内存并处理其他多线程资源（例如图形线程代理对象）的机会。大多数与销毁有关的 Gameplay 功能应已在更早的 EndPlay 中处理。
2. [UObject::IsReadyForFinishDestroy](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/UObject/IsReadyForFinishDestroy?application_version=5.5) - 垃圾回收流程会调用此函数，以确定对象是否已经准备好被永久释放。返回 false 可以将对象的实际销毁推迟到下一次垃圾回收遍历。
3. [UObject::FinishDestroy](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/CoreUObject/UObject/UObject/FinishDestroy?application_version=5.5) - 最后，对象真正即将销毁，这也是释放内部数据结构的另一次机会。这是释放内存前的最后一次调用。

### 高级垃圾回收

该 [垃圾回收](../../../../cpp-programming/reflection-system/objects/unreal-object-handling/index.md) 流程在 **Unreal Engine** 中会构建一组一起销毁的对象簇。 **聚类** reduces the total time and overall memory churn associated with garbage collection compared to deleting objects indivudally. As an object loads, it may create subobjects. By combining the object and its subobjects into a single cluster for the garbage collector, the engine can delay freeing the resources used by the cluster until the entire object is ready to be freed, and can then free all of the resources at once.

对于大多数项目，完全不需要配置或修改垃圾回收。但在一些特定场景中，可以通过以下方式改变垃圾回收器的“聚类”行为来提高效率：

- **聚类** - 关闭聚类。在 **项目设置**中，在 **垃圾回收** 部分下， **创建 Garbage Collector UObject Clusters** 选项可以设置为 false。对大多数项目来说，这会降低垃圾回收效率，因此仅建议在性能测试表明其有益时使用。

项目设置菜单中的垃圾回收聚类选项。
