# Actor Priority

---
title: "Actor Priority"
source_url: "https://dev.epicgames.com/documentation/unreal-engine/actor-priority-in-unreal-engine"
breadcrumbs: ["虚幻引擎5.7文档", "Gameplay系统", "联网和多人游戏", "编写多人游戏", "Actor Priority"]
---

# Actor Priority

> 路径：虚幻引擎5.7文档 / Gameplay系统 / 联网和多人游戏 / 编写多人游戏 / Actor Priority

> 原始页面：https://dev.epicgames.com/documentation/unreal-engine/actor-priority-in-unreal-engine

该页面没有可用的官方中文版本；以下内容保留原文，并按本项目人工译文规则逐步回译。

Unreal Engine 不保证所有 Actor 都会在一次网络更新中复制，这是因为网络资源本身受限。主要限制因素之一是连接的带宽。 *带宽* 是该连接的最大数据传输能力。当连接超过自身容量时，该连接会变为 *饱和* 。当连接饱和时，Unreal Engine 的复制系统会使用一种负载均衡技术，为所有 Actor 分配一个数值形式的 **优先级**。该优先级会根据 Actor 对 Gameplay 的重要程度，为每个 Actor 分配相对公平的可用网络带宽资源。相对优先级更高的 Actor 代表复制更重要，因此会获得更多用于复制的带宽。

## 获取 Actor 的优先级

每个 Actor 都有一个浮点型 [AActor::NetPriority](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor?application_version=5.5) 属性。较高的 `NetPriority` 表示当前 Actor 相对其他 Actor 会获得更多带宽。例如，具有 `NetPriority == 2.0` 的 Actor 会比具有 `NetPriority == 1.0`的 Actor 获得更多资源。优先级真正起作用的是它们之间的比例；单纯按比例放大所有 Actor 的网络优先级并不能提升 Unreal Engine 的网络性能。

作为基准，以下是一些常见 Unreal Engine 类使用的初始值：

| 类 | 优先级 |
| --- | --- |
| `AActor` | `1.0` |
| `APawn` | `3.0` |
| `APlayerController` | `3.0` |

`NetPriority` 是低带宽或饱和连接情况下使用的基准值。 [AActor::GetNetPriority](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/GetNetPriority?application_version=5.5) 会基于多个因素确定 Actor 的当前优先级，包括基础 `NetPriority`、到观察者的距离，以及距离上次复制经过的时间。

### 获取 Actor 当前优先级

网络驱动通过调用以下函数，确定 Actor 针对特定连接进行复制时的当前优先级： `GetNetPriority`。这会由网络驱动自动处理。

### 覆写 Actor 优先级

可以通过覆写虚函数来自定义 Actor 优先级： `GetNetPriority` 在你的 `AActor` 派生类中覆写该函数，并且也可以通过以下属性更改基础网络优先级： `NetPriority`。

> [!WARNING]
> 覆写 Actor 的以下函数时需要谨慎： `GetNetPriority`。如果不熟悉 Unreal Engine 的复制系统，这可能产生非预期后果。

## 优先级如何确定

Actor 当前网络优先级会根据距离该 Actor 上次复制经过的时间，以及其他多种因素，计算得到一个浮点优先级。

### 参数

Actor 网络优先级基于以下输入参数：

| 参数 | 说明 |
| --- | --- |
| `ViewPos` | 观察者的位置。 |
| `ViewDir` | 观察者面对的方向。 |
| `Viewer` | 正在为其确定网络优先级的客户端所拥有的网络对象，通常是 Player Controller。 |
| `ViewTarget` | 当前由以下对象查看或控制的 Actor： `Viewer`。这通常是 Pawn。 |
| `InChannel` | 该 Actor 正在其上复制的通道。 |
| `Time` | 距离该 Actor 上次复制经过的时间。 |
| `bLowBandwidth` | 如果观察者带宽较低，则为 true。 |

### 优先级逻辑

以下函数的大部分工作 `AActor::GetNetPriority` 用于根据到 Viewer 的距离、与 Viewer 的视线关系，以及当前 Actor 距离上次复制经过的时间，计算常量的乘法因子： `AActor::NetPriority` 。

网络优先级按以下方式确定：

- 如果以下两个条件同时成立，当前 Actor 会使用其所有者的网络优先级。

  - 当前 Actor 有所有者。
  - 当前 Actor 被设置为使用其所有者的网络相关性。
- 如果以下任一条件成立，当前 Actor 的网络优先级会提高。

  - 当前 Actor 是当前连接的 Pawn。
  - 当前连接的 Pawn 是某个动作的发起者。
- 如果前两点都不成立，则执行基于距离的计算来确定当前 Actor 的网络优先级：

  - 如果当前 Actor 位于观察者前方，优先级会按设定距离的反比降低。

    - 如果当前 Actor 与观察者之间的距离大于 `CLOSEPROXIMITY` 但小于 `NEARSIGHTTHRESHOLD`，则优先级乘以 `0.2`。
    - 如果当前 Actor 与视点之间的距离大于 `NEARSIGHTTHRESHOLD`，则优先级乘以 `0.4`。
  - 如果当前 Actor 与观察者之间的距离小于 `FARSIGHTTHRESHOLD` 且观察者正在看向当前 Actor，则优先级乘以 `2.0`。
  - 如果当前 Actor 与视点之间的距离大于 `MEDSIGHTTHRESHOLD`，则优先级乘以 `0.4`。

> [!NOTE]
> 距离和视线阈值常量具有以下值：
>
> | 常量 | 值 |
> | --- | --- |
> | `CLOSEPROXIMITY` | `500` |
> | `NEARSIGHTTHRESHOLD` | `2000` |
> | `MEDSIGHTTHRESHOLD` | `3162` |
> | `FARSIGHTTHRESHOLD` | `8000` |
>
> 这些常量定义可在以下文件中找到： `NetworkingDistanceConstants.h`。

## 优先级参考

### 函数

| 名称 | 说明 |
| --- | --- |
| [GetNetPriority](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/GetNetPriority?application_version=5.5) | 在决定复制哪些 Actor 时，用于为 Actor 排列优先级。 |
| [GetReplayPriority](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor/GetReplayPriority?application_version=5.5) | 类似于 `GetNetPriority`。用于在录制回放时为 Actor 排列优先级。 |

### 属性

| 名称 | 说明 |
| --- | --- |
| [bNetUseOwnerRelevancy](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor?application_version=5.5) | 如果该 Actor 有有效所有者，则调用所有者的 `IsNetRelevantFor` 和 `GetNetPriority`。 |
| [NetPriority](https://dev.epicgames.com/documentation/unreal-engine/API/Runtime/Engine/GameFramework/AActor?application_version=5.5) | 在低带宽或饱和情况下检查复制时，该 Actor 使用的优先级。优先级越高，越有可能被复制。 |

