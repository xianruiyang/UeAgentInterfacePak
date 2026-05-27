# Detailed Actor Replication Flow

---
title: "Detailed Actor Replication Flow"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/detailed-actor-replication-flow-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "编写多人游戏", "Detailed Actor Replication Flow"]
---

# Detailed Actor Replication Flow

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 编写多人游戏 / Detailed Actor Replication Flow

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/detailed-actor-replication-flow-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

**Actor 复制** 是一个详细的多步骤过程，其中 **网络驱动** （Net Driver）会决定哪些 Actor 需要以什么顺序复制到哪些连接。本文概述 Actor 复制流程。

大部分 Actor 复制都发生在 [UNetDriver::ServerReplicateActors](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UNetDriver/ServerReplicateActors?application_version=5.5) 函数内部。服务器会先收集它判定为与每个客户端相关的所有 Actor，然后发送自上次更新各连接客户端以来发生变化的属性。 [UActorChannel::ReplicateActor](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/Engine/UActorChannel/ReplicateActor?application_version=5.5) 函数随后处理将 Actor 复制到特定通道的细节。

## 重要属性

Actor 如何更新、会调用哪些框架回调，以及哪些属性用于判断 Actor 是否在当前服务器 tick 中复制，都有明确流程。一些重要项包括：

| 属性 | 说明 |
| --- | --- |
| [AActor::NetUpdateFrequency](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor?application_version=5.5) | 决定 Actor 应多久复制一次。 |
| [AActor::PreReplication](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/PreReplication?application_version=5.5) | 在任何复制发生前调用。 |
| [AActor::bOnlyRelevantToOwner](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/bOnlyRelevantToOwner?application_version=5.5) | 如果该 Actor 只复制给其所有者，则为 true。 |
| [AActor::IsRelevancyOwnerFor](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/IsRelevancyOwnerFor?application_version=5.5) | 当 bOnlyRelevantToOwner 为 true 时决定相关性。 |
| [AActor::IsNetRelevantFor](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/IsNetRelevantFor?application_version=5.5) | 当 bOnlyRelevantToOwner 为 false 时决定相关性。 |
| [AActor::NetDormancy](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor?application_version=5.5) | 决定 Actor 是休眠还是唤醒。 |

## Actor 复制流程概述

以下步骤构成 Actor 复制流程的高层概述：

1. 确定哪些 Actor 正在复制，并检查休眠状态、更新频率和拥有连接。

   - 将通过这些检查的 Actor 加入待考虑复制列表。
2. 遍历每个连接，并根据当前 Actor 和连接执行检查。此步骤结束后，每个连接都会有一份待考虑复制的 Actor 列表。

   - 按每个连接对 Actor 进行优先级排序。
3. 确定该 Actor 是否与此连接相关。
4. 将该 Actor 复制到当前连接。

以下章节更详细说明上述 Actor 复制流程概述中的每个步骤。

### 将 Actor 加入待考虑复制列表

此步骤会对所有 Actor 执行初始遍历，通过检查是否调用了 `AActor::SetReplicates(true)` 来确定哪些 Actor 正在主动复制。对于每个正在主动复制的 Actor，NetDriver 会执行以下检查：

1. 确定当前 Actor 是否初始休眠（`ENetDormancy::DORM_Initial`).

   - 如果初始休眠，则跳过该 Actor。
2. 通过检查 `AActor::NetUpdateFrequency` 值，确定当前 Actor 是否需要更新。

   - 如果不需要，则跳过该 Actor。
3. If `AActor::bOnlyRelevantToOwner` 为 true，则调用以下函数检查该 Actor 的拥有连接相关性： `AActor::IsRelevancyOwnerFor` ，调用对象为拥有连接的观察者。

   - 如果相关，则添加到连接上的已拥有相关列表。
   - 在这种情况下，该 Actor 只会发送到单个连接。

对于通过这些初始检查的任何 Actor，会调用 `AActor::PreReplication` 。在 `AActor::PreReplication`中，可以决定是否希望属性复制到特定连接。使用 `DOREPLIFETIME_ACTIVE_OVERRIDE` 宏可以精确控制 Actor 复制到哪些连接。如果 Actor 通过上述所有检查，则将其加入待考虑复制列表。

### 遍历每个连接

接下来，系统遍历每个连接，并针对上一步中当前连接待考虑复制列表里的每个 Actor 执行以下检查和操作：

1. 通过调用以下函数确定当前 Actor 是否休眠： `AActor::NetDormancy`.

   - 如果该 Actor 对此连接处于休眠状态，则跳过该 Actor。
2. 如果尚无通道：

   - 确定客户端是否已加载当前 Actor 所在关卡。

     - 如果关卡尚未加载，则跳过该 Actor。
   - 通过调用以下函数确定当前 Actor 是否相关： `AActor::IsNetRelevantFor` ，针对该连接执行。

     - 如果 Actor 不相关，则跳过该 Actor。

添加前面连接的已拥有相关列表中的所有 Actor。此时会得到一份与此连接相关且未休眠的 Actor 列表。按优先级（`AActor::GetNetPriority`）对该列表中的 Actor 降序排序。按优先级排序尤其重要，因为需要确保最高优先级 Actor 先于低优先级 Actor 被考虑复制，尤其是在待考虑 Actor 数量很大且连接可能饱和时。

#### 遍历已排序 Actor 列表

对于此连接待考虑复制列表中的每个 Actor：

1. 如果连接尚未加载该 Actor 所在关卡，则关闭通道（如果存在）并继续。
2. 每 1 秒调用以下函数，确定 Actor 是否与该连接相关： `AActor::IsNetRelevantFor`.

   - 如果 5 秒内都不相关，则关闭通道。
   - 如果相关且没有打开通道，则打开通道。
   - 如果此连接在任意时刻饱和：

     - 对于剩余 Actor：

       - 如果相关时间少于 1 秒，则强制在下一个 tick 更新。
       - 如果相关时间超过 1 秒，则调用 `AActor::IsNetRelevantFor` 来确定是否应在下一个 tick 更新。

对于通过以上所有检查的 Actor，会通过调用以下函数将其复制到该连接： `UActorChannel::ReplicateActor`.

> [!TIP]
> 可以通过几种方式控制 `UNetDriver::ServerReplicateActors` 每次调用复制多少客户端：
>
> 1. 引擎配置和命令行参数：
>
>    1. 使用以下命令行参数启动项目： `-limitclientticks` 。
>    2. 修改 `NetClientTicksPerSecond` 的值，位置在 `[/Script/Engine.Engine]` 引擎配置类别中。
> 2. 命令行参数：
>
>    1. 使用以下命令行参数启动项目： `-limitclientticks -ini:Engine:[/Script/Engine.Engine]:NetClientTicksPerSecond=<VALUE>`，其中 `<VALUE>` 是希望使用的每秒客户端 tick 数。
> 3. 控制台变量：
>
>    1. 设置 `net.MaxConnectionsToTickPerServerFrame` 控制台变量
>
> 请参阅 `UNetDriver::ServerReplicateActors_PrepConnections` 获取更多信息。

##### 将 Actor 复制到连接

`UActorChannel::ReplicateActor` 是将 Actor 及其所有组件复制到连接的主要方法。流程大致如下：

1. 确定这是否是该 Actor 通道打开后的第一次更新。

   - 如果是，则序列化所需的特定信息（初始位置、旋转等）。
2. 确定此连接是否拥有该 Actor。

   - 如果不拥有，并且此 Actor 的角色是 `ENetRole::ROLE_AutonomousProxy`，则降级为 `ENetRole::ROLE_SimulatedProxy`.
3. 复制该 Actor 已变化的属性。
4. 复制每个组件已变化的属性。
5. 对于任何已删除组件，发送特殊删除命令。

当 Actor 列表处理完毕或通道变为饱和后，会开始处理下一个连接，并重复该流程，直到所有连接都已更新。

## 更多信息

关于 Actor 复制的更多信息，请参阅 Unreal Engine 源代码中的以下头文件：

- `/Engine/Source/Runtime/Engine/Classes/Engine/NetDriver.h`

  - 关于 `UNetDriver::ServerReplicateActors`.
- `/Engine/Source/Runtime/Engine/Classes/GameFramework/Actor.h`

  - 关于 `AActor` 及其函数和属性的信息。
- `/Engine/Source/Runtime/Engine/Classes/Engine/ActorChannel.h`

  - 关于 `UActorChannel` 和 `UActorChannel::ReplicateActor`.
- `/Engine/Source/Runtime/Engine/Classes/Engine/EngineTypes.h`

  - 关于以下类型的信息： `ENetRole` 和 `ENetDormancy`.

