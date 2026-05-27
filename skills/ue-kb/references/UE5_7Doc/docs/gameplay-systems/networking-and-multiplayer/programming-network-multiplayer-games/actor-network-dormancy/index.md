---
title: "Actor网络休眠"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/actor-network-dormancy-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "编写多人游戏", "Actor网络休眠"]
---

# Actor网络休眠

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 编写多人游戏 / Actor网络休眠

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/actor-network-dormancy-in-unreal-engine

Actor **网络休眠（Network Dormancy）** （ `AActor::NetDormancy` ）是多人游戏项目可执行的最重大服务器优化之一，每帧可节省数毫秒的服务器CPU时间。如果你的项目中存在大量不常更改的复制Actor，此功能尤其有用。在网络更新期间，NetDriver会收集与连接相关的所有复制Actor的列表，然后对这些Actor及其属性迭代，确定哪些发生了更改而应该发送到客户端。Actor的网络休眠控制该Actor是否会被添加到该连接的收集的Actor列表。*休眠* Actor不会被添加到列表，而 *苏醒* （未休眠）Actor会被添加到列表。对Actor及其属性迭代可能成本很高，尤其是对于有大量复制Actor的项目。因此，有效使用网络休眠将Actor筛出复制列表的考虑范围，这可能是多人项目至关重要的优化。

## 如何使用网络休眠

按照以下步骤在你的项目中有效使用网络休眠：

1. 在构造函数中将Actor的 `AActor::NetDormancy` 设置为 `ENetDormancy::DORM_DormantAll` ：

   ```
        NetDormancy = ENetDormancy::DORM_DormantAll;
   ```
2. 如果Actor放置在地图中，将Actor的

   AActor::NetDormancy

   设置为

   ENetDormancy::DORM_Initial

   。
3. 休眠时，Actor不会复制。
4. 要复制Actor，请在更改复制的Actor之前调用

   AActor::FlushNetDormancy

   、

   AActor::ForceNetUpdate

   或

   AActor::SetNetDormancy(ENetDormancy::DORM_Awake)

   。
5. 对于复制的组件或子对象，必须清空或唤醒所属Actor，其复制的属性才能更改。

复制的Actor被标记为休眠时， `NetDriver` 可以不将其添加到该连接的"收集的Actor列表"中。这样可节省原本考虑Actor进行复制并比较其属性所花费的时间。在休眠Actor苏醒或清空其休眠之前，该Actor不会考虑进行复制；因此，对其复制的属性进行的更改不会被发送到客户端。另外要注意，Actor休眠时，其复制的状态不应该更改，因为在Actor苏醒时，这些更改可能会丢失。这意味着，很少更改所复制属性的Actor才适合休眠。需要频繁更新的Actor（例如Pawn）不大可能从休眠中获益，而且由于更改或清空Actor的休眠状态会带来额外开销，太频繁地执行此操作的性能甚至不如一直让Actor保持苏醒。

虽然复制的Actor休眠时其Actor通道会关闭，但休眠Actor仍存在于服务器和客户端上。这和[Actor相关性](https://dev.epicgames.com/documentation/404)的处理方式不同：复制的动态Actor在不再相关时，会在客户端上被销毁。注意，系统不会检查休眠Actor的相关性，因此，如果休眠Actor本来在客户端上会变得不相关，也不会在该客户端上被销毁（除非你使用的[复制图表](https://dev.epicgames.com/documentation/404)启用了 `Net.RepGraph.DormantDynamicActorsDestruction` 控制台变量）。

## 更改Actor的网络休眠

Actor的休眠状态存储在其 `AActor::NetDormancy` 属性中。此属性可以通过调用 `AActor::SetNetDormancy` 来更改。虽然`AActor::NetDormancy` 是公共的，但此属性不应直接在Actor的构造函数外部设置。应调用 `AActor::SetNetDormancy` 以更改Actor的休眠状态，因为此函数还处理向 `NetDriver` 通知该更改的操作。

## 网络休眠状态

`ENetDormancy` 枚举类（在 `EngineTypes.h` 中定义）中说明了五个休眠状态。下表说明了这些休眠状态：

| **网络休眠状态** | **说明** |
| --- | --- |
| `DORM_Never` | 此Actor从不休眠。 休眠系统不会强制实施此操作。标记为 `ENetDormancy::DORM_Never` 的Actor可以被设为休眠。 |
| `DORM_Awake` | 此Actor没有休眠，不考虑进行复制。 |
| `DORM_DormantPartial` | 此Actor在一些连接上休眠，但不是在所有连接上都休眠。使用 `AActor::GetNetDormancy` 确定Actor对哪些连接休眠。 不建议使用部分休眠。我们计划废弃部分休眠。 |
| `DORM_Initial` | 此Actor初始在所有连接上休眠。 这应该仅由初始放置在地图中的Actor使用。 |
| `DORM_DormantAll` | 此Actor在所有连接上休眠。 |

## 唤醒休眠Actor

唤醒休眠Actor的方法主要有两种：

- 设置网络休眠属性。
- 调用清空网络休眠函数。

### 设置网络休眠

你可以调用 `AActor::SetNetDormancy(ENetDormancy::DORM_Awake)` 来唤醒休眠Actor。当Actor苏醒时，它会正常复制，直至从该Actor调用 AActor::SetNetDormancy(ENetDormancy::DORM_DormantAll)` 将其设置回休眠为止。这在休眠Actor将开始每帧发生更改的情况下很有用，例如静止物体开始移动。

> [!TIP]
> 一旦静态放置、初始休眠的Actor被唤醒，你不应该将其设置回 ENetDormancy::DORM_Initial`。请改用`ENetDormancy::DORM_DormantAll` 。

### 清空网络休眠

你还可以在Actor上调用 `AActor::FlushNetDormancy` ，为休眠Actor复制更改。这会强制Actor将至少一个更新复制到与它相关的所有连接，而不实际更改其休眠状态。但有一个例外情况，如果你在其 `Actor::NetDormancy` 被设置为 `ENetDormancy::DORM_Initial` 的Actor上调用 `AActor::FlushNetDormancy` ，调用 `AActor::FlushNetDormancy` 会将Actor的休眠更改为 `ENetDormancy::DORM_DormantAll` 。

#### 强制网络更新

在休眠Actor上调用 `AActor::ForceNetUpdate` 还会调用 `AActor::FlushNetDormancy` ，同时确保该Actor在下一次网络更新时考虑进行复制。这很适合偶尔在单帧中发生的一次性Actor更新。

清空Actor的休眠状态后（或在Actor被唤醒后将其设为休眠时），Actor可以发送多个更新，因为它不会立即变为休眠状态。相反，Actor会继续复制，直至它及其子对象没有更多应该发送的未确认更改为止。如果启用了休眠滞后，这还会阻止Actor立即休眠（请参阅 `UActorChannel::ReadyForDormancy` 和 `FObjectReplicator::ReadyForDormancy` ）。

### 何时使用唤醒方法

在更改Actor的复制属性之前，应该先在该Actor上调用 `AActor::SetNetDormancy(ENetDormancy::DORM_Awake)` 或 `AActor::FlushNetDormancy` 。唤醒休眠的Actor将复制其所复制属性的所有当前值，重新初始化该Actor的 *阴影状态* （用于比较哪些属性已更改而需要复制的状态）。也正因为如此，当Actor休眠时，不应更改其复制状态，因为唤醒Actor后，比较其属性进行复制时，将检测不到这些更改。

不过，在大部分情况下，更改后进行调用可能仍会按预期复制这些更改。但此行为属于实现细节，你不应该依赖它。例如，在特定情况下，例如更改休眠快速数组时，在更改属性之后调用 `AActor::FlushNetDormancy` 会导致根本不会复制更改。

## 蓝图Actor的休眠

对蓝图Actor使用休眠时，该Actor会在你设置所复制的属性时自动调用 `AActor::FlushNetDormancy` 。

> [!NOTE]
> 在 `ActorComponent` 蓝图上设置所复制的属性时不会自动发生此情况，但我们正在努力改进此行为，使其变得一致。

## 休眠和复制图表

使用[复制图表](https://dev.epicgames.com/documentation/404)时，休眠的运作方式应该与使用默认 `NetDriver` 时相同，以便项目代码可以将Actor设置为休眠/苏醒并正常调用 `AActor::FlushNetDormancy` 。即使节点在收集其Actor列表时返回休眠Actor， `UReplicationGraph::ReplicateActorListsForConnections_Default` 仍不会复制这些Actor。

复制图表节点可以包括针对休眠Actor的特殊处理。这可以减少为节点处理休眠Actor所花费的时间和内存，也可以减少该节点处收集的Actor列表大小。例如， `GridSpatialization2D` 节点包括针对休眠Actor的额外处理，在休眠时将其视为静态，在苏醒时视为动态。如果Actor可能有时在整个网格中移动，但在其他时候也可能保持静止和休眠，这就很有用。

## 调试网络休眠

## 日志

启用 `LogNetDormancy` 日志类别，在日志中获取有关Actor的休眠状态的信息。提高此类别的冗长度会记录更详细的信息，例如在清空Actor的休眠时。

### 控制台变量

下表包含与网络休眠相关的多个控制台变量，可能对你很有用：

| **控制台变量** | **说明** |
| --- | --- |
| `net.DormancyEnable` | 用于为所有Actor完全启用或禁用休眠。这适合用于确定复制问题是否与休眠相关。 |
| `net.ReuseReplicatorsForDormantObjects` | 如果启用此项，服务器会在Actor变为休眠时尝试复用休眠对象的 `FObjectReplicator` ，而不是将其销毁并在对象苏醒时重新创建。 此功能不再在内部使用。保留这些复制器会增加服务器内存使用量。对于有大量休眠Actor的项目，这些额外的内存使用量可能非常大。复用这些复制器还可能在复制子关卡中的Actor时造成问题。 |
| `net.DormancyValidate` | 如果启用此项，在休眠的Actor更改其复制属性时向日志打印警告。 设置为1将仅在休眠Actor被唤醒时对其进行验证。 设置为2将在每次网络更新时验证休眠Actor。 启用休眠验证会导致复用休眠对象的复制器，因为需要它们才能在休眠时比较复制的属性。 |
| `net.DormancyHysteresis` | Actor通道在变为完全休眠之前等待的时间（秒）。这默认设置为0，但增加该值可能会在Actor迅速切换休眠与苏醒的情况下防止抖动。 |
| `Net.RepGraph.LogNetDormancyDetails` | 如果启用此项，会打印有关复制图表如何处理休眠Actor的更详细日志信息。 |
| `Net.RepGraph.DormantDynamicActorsDestruction` | 如果启用此项，休眠Actor不再相关时，会在客户端上销毁。请参阅 `ReplicationGraph.cpp` 顶部的控制台变量，了解配置此行为的更多方式。 |

如需详细了解虚幻引擎中的控制台变量，请参阅[控制台变量](../../../../cpp-programming/programming-in-the-unreal-engine-architecture/console-variables-cplusplus/index.md)文档页面。
